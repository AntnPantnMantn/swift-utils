import Foundation
/*
 * variouse methods conserningpathdata both traversing over SVGPath data and svg XML syntax based data
 */
class SVGPathParser {
	/**
	 * Returns an SVGPathData instance from @param data (which is derived directly from the SVG XML formated data
	 * @param data ( M-60-45 L   25.00px,20)
	 * @example SVGPathDataUtils.pathData("M10,10pxH110");//commands: M,H parameters: 10,10,110
	 */
	class func pathData(data:String)->SVGPathData {
		var parameters:Array<CGFloat> = [];
		var commands:Array<String> = [];
		let pattern:String = "[MmLlHhVvCcSsQqTtZzAa])([\\d\\.\\-\\s\\,px]*?)(?=[MmLlHhVvCcSsQqTtZzAa]|$)"//Capturing groups: ?P<cmnd>,?P<params>
        let matches = data.matches(pattern)
        for match:NSTextCheckingResult in matches {/*Loops through the pattern*/
            match.numberOfRanges
            //let content = (data as NSString).substringWithRange(match.rangeAtIndex(0))//the entire match
            let cmnd = (data as NSString).substringWithRange(match.rangeAtIndex(1))//capturing group 1
            //Swift.print("cmnd: >" + cmnd+"<");
            commands.append(cmnd);//command()
            let params = (data as NSString).substringWithRange(match.rangeAtIndex(2))//capturing group 2
            //Swift.print("params: >" + params+"<");
            let array:Array<CGFloat> = SVGPathParser.parameters(params);
            //Swift.print("pathData.parameters: " + array);
            parameters += array//<---this is the same as concat
        }
        
//		Swift.print("pathData.commands: " + commands);
//		Swift.print("pathData.parameters: " + parameters);
		return SVGPathData(commands,parameters);
	}
    /**
	 * Returns an array comprised of values "sans" its prefix and or suffix
	 * // :TODO: write some examples in this comment section
	 * @Note cant make this private since polyline and polygon uses this method
	 */
	class func parameters(parameters:String)->Array<CGFloat> {
        let pattern:String = "(?<=^|\\,|\\s|px|\\b)\\-?\\d*?(\\.?)((?1)\\d+?)(?=px|\\s|\\,|\\-|$)"
		let stringArray:Array<String> = parameters.match(pattern);
        let array:Array<CGFloat> = stringArray.map {CGFloat(Double($0)!)}//<--temp fix
        return array
	}
	/**
	 * Returns the destination end position of a given command at @param commandIndex in @param commands
	 * @param index the index of the command
	 */
	class func end(path:SVGPath, index:Int)->CGPoint? {// :TODO: rename to position?!?
		let command:String = path.commands[index].lowercaseString
		var parameters:Array = SVGPathDataParser.pathData(path, index);
        if(command == "m" || command == "l") {return CGPoint(parameters[0],parameters[1])}
        else if(command == "c") {return CGPoint(parameters[2],parameters[3])}
        else { return nil}//Arc4Parser.end(PathDataParser.arc(pathData));/*PathCommand.ARC_TO*/
	}
	/**
	 * Returns all points in @param path
	 * // :TODO: impliment native quad to (if you test the fdt free version on your mac mini first)
	 * // :TODO: add support for zZ ?!? do we need to?
	 * // :TODO: cubic and quad curve may have more params and they may have t and s  impliment this
	 */
	class func points(path:SVGPath)->Array<CGPoint> {
		var commands:Array = path.commands;
		var params:Array = path.parameters;
		var positions:Array<CGPoint> = [];
		var i:Int = 0;/*parameterIndex*/
		var prevP:CGPoint = CGPoint();
		for (var e : Int = 0; e < commands.count; e++) {
			let command:String = commands[e];
			let isLowerCase:Bool = StringAsserter.lowerCase(command);
			var pos:CGPoint = isLowerCase ? prevP.copy() : CGPoint();
			switch(command.lowercaseString){
				case SVGPathCommand.m,SVGPathCommand.l: //lineTo,moveTo
					pos += CGPoint(params[i+0],params[i+1]);
					i += 2;
					break;
				case SVGPathCommand.h: //horizontalLineTo
					pos += CGPoint(params[i],isLowerCase ? 0 : prevP.y);
					i++;
					break;
				case SVGPathCommand.v: //verticalLineTo
					pos += CGPoint(isLowerCase ? 0 : prevP.x,params[i]);
					i++;
					break;
				case SVGPathCommand.c:/*cubicCurveTo*/ // :TODO: this isnt tested!!
					pos += CGPoint(params[i+4],params[i+5]);
					i += 6;
					break;
				case SVGPathCommand.s://smooth Cubic curve command
					pos += CGPoint(params[i+2],params[i+3]);
					i += 4;
					break;
				case SVGPathCommand.q://quadCurveTo
					pos += CGPoint(params[i+2],params[i+3]);
					i += 4;
					break;
				case SVGPathCommand.t://smooth quadratic curve command
					pos += CGPoint(params[i],params[i+1]);
					i += 2;
					break;
                default:break;
			}
			positions.append(pos);
			if(e < commands.count-1 /*&& StringAsserter.lowerCase(commands[i+1])*/) {// :TODO: check for z?
				prevP = pos.copy();
			}
		}
//		Swift.print("positions: " + positions);
		return positions;
	}
	/**
	 * Returns an Rectangle instance with points derived from @param path
	 * // :TODO: arcs and curve bounding boxes will be dificult,but you have code for this, see notebooks
	 */
	class func rectangle(path:SVGPath)-> CGRect {
		let points:Array<CGPoint> = SVGPathParser.points(path);
		return PointParser.rectangle(points);
	}
}