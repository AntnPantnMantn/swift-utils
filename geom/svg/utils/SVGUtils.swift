import Foundation
/*
 * XML utility methods (Beta)
 * @Note: This class has methods that conver SVG elements into XML
 */
class SVGUtils {
	/**
	 * Returns svg syntax in an XML instance derived from @param svg 
	 * @param svg (isntance of a custom SVG class that is easy to work with)
	 * @Note for the reverse function look into using the adobe native functionality namespaceDeclarations, namespace to also include the namespace
	 */
	class func xml(svg:SVG)->NSXMLElement {// :TODO: refactor to one or loop?
		let xml:NSXMLElement = SVGUtils.svg(svg);
		for (var i : Int = 0; i < svg.items.count; i++) {
			let svgElement:ISVGElement = svg.items[i];
			var child:NSXMLElement;
            if(svgElement is SVGLine) {child = line(svgElement as! SVGLine)}
            else if(svgElement is SVGRect) {child = rect(svgElement as! SVGRect)}
            else if(svgElement is SVGPath) {child = path(svgElement as! SVGPath)}
            else if(svgElement is SVGGroup) {child = group(svgElement as! SVGGroup)}
            else {fatalError("type not supported: " + "\(svgElement)")}
            xml.appendChild(child);
		}
		return xml;
	}
	/**
	 * Returns pathData from @param path (SVGPath instance)
	 */
	class func pathData(path:SVGPath)->String {
		var pathData:String = ""
		let commands:Array<String> = path.commands
		var parameters:Array<CGFloat> = path.parameters;
		var index:Int = 0;
		for command : String in commands {
			if(command.test("[m,M,l,L,t,T]")) {
				pathData += command + String(parameters[index]) + " " + String(parameters[index + 1]) + " "
				index += 2
			}else if(command.test("[h,H,v,V]")){
				pathData += command + String(parameters[index]) + " "
				index++
			}else if(command.test("[s,S,q,Q]")){
				pathData += command + String(parameters[index]) + " " + String(parameters[index+1]) + " " + String(parameters[index+2]) + " " + String(parameters[index+3]) + " "
				index++;
			}else if(command.test("[c,C]")){
				pathData += command + String(parameters[index]) + " " + String(parameters[index+1]) + " " + String(parameters[index+2]) + " " + String(parameters[index+3]) + " " + String(parameters[index+4]) + " " + String(parameters[index+5]) + " ";
				index++;
			}else if(command.test("[a,A]")){
				pathData += command + String(parameters[index]) + " " + String(parameters[index+1]) + " " + String(parameters[index+2]) + " " + String(parameters[index+3]) + " " + String(parameters[index+4]) + " " + String(parameters[index+5]) + " " + String(parameters[index+6]) + " ";
				index++;
			}else if(command.test("[z,Z]")){
				pathData += command + " ";
				index++;
			}
		}
		pathData = pathData.replace("\\s*?$", "")/*Removes the ending whitespace, if it exists*/
		return pathData;	
	}
	/**
	 * Returns the root node for the SVG XML document
	 */
	class func svg(svg:SVG)->NSXMLElement {
		let xml:NSXMLElement = try! NSXMLElement("<?xml version=“1.0”?><svg></svg>")
		xml["xmlns"] = "http://www.w3.org/2000/svg";
		xml["x"] = String(svg.x)+"px";
		xml["y"] = String(svg.y)+"px";
		xml["width"] = String(svg.width)+"px";
		xml["height"] = String(svg.height)+"px";
		return xml;
	}
	/**
	 * Returns a svg line in SVG XML notation from @param line (SVGLine)
	 */
	class func line(line:SVGLine)->NSXMLElement {
		var xml:NSXMLElement = try! NSXMLElement("<line></line>")
		xml = id(xml,line);
		xml["x1"] = "\(line.x1)";
		xml["y1"] = "\(line.y1)";
		xml["x2"] = "\(line.x2)";
		xml["y2"] = "\(line.y2)";
		xml = style(xml,line);
		return xml;
	}
	/**
	 * Returns a svg rect in SVG XML notation from @param rect (SVGRect)
	 */
	 class func rect(rect:SVGRect)->NSXMLElement {//@Note: API<rect x="64" y="64" fill="none" stroke="#000000" stroke-miterlimit="10" width="512" height="512"/>
		var xml:NSXMLElement = try! NSXMLElement("<rect></rect>")
		xml = id(xml,rect);
		xml["x"] = "\(rect.x)";
		xml["y"] = "\(rect.y)";
		xml["width"] = "\(rect.width)";
		xml["height"] = "\(rect.height)";
		xml = style(xml,rect);
		xml["stroke-miterlimit"] = "\(rect.style!.strokeMiterLimit)";
		return xml;
	 }
	 /**
	  * Returns an SVGPath instance in SVG XML notation from @param path (SVGPath)
	  */
	 class func path(path:SVGPath)->NSXMLElement {
         var xml:NSXMLElement = try! NSXMLElement("<path></path>")
		 xml = id(xml,path);
		 xml["d"] = SVGUtils.pathData(path);
		 xml = style(xml,path);
		 return xml;
	 }
	 /**
	  * Returns an XML instance with SVGGroup data derived from @param group
	  * @Note: this method is recursive
	  * // :TODO: remeber groups can have style applied inline cant they?
	  */
	 class func group(group:SVGGroup) -> NSXMLElement {
		 var xml:NSXMLElement = try! NSXMLElement("<g></g>")
		 xml = id(xml,group);
		 /*xml = style(xml,group); not supported yet*/
		 for (var i : Int = 0; i < group.items.count; i++) {
			 let svgGraphic:ISVGElement = group.items[i] as ISVGElement;
			 var child:NSXMLElement;
             if(svgGraphic is SVGLine) {child = line(svgGraphic as! SVGLine)}
             else if(svgGraphic is SVGRect) {child = rect(svgGraphic as! SVGRect)}
             else if(svgGraphic is SVGPath) {child = path(svgGraphic as! SVGPath)}
             else if(svgGraphic is SVGGroup) {child = SVGUtils.group(svgGraphic as! SVGGroup)}
             else{ fatalError("type not supported: " + "\(svgGraphic)")}
             xml.appendChild(child);
		 }
		 return xml;
	 }
	 /**
	  * Returns the id from a ISVG instance
	  * // :TODO: move to an internal class
	  */
	 class func id(xml:NSXMLElement,_ svg:ISVGElement)->NSXMLElement {
         if(svg.id != ""/*<-this was nil*/) {xml["id"] = svg.id}
		 return xml;
	 }
	 /**
	  * Returns an XML instance with style properties derived from @param xml
	  * // :TODO: move to an internal class
	  */
	 class func style(xml:NSXMLElement,_ graphic:SVGGraphic)->NSXMLElement {
        
         //this method is missing support for gradient (Get ques from the old SVGPropertyParser)
        
         xml["fill"] = graphic.style!.fill is Double && !((graphic.style!.fill as! Double).isNaN) ? "#"+ColorUtils.hexString(UInt(graphic.style!.fill as! Double)):"none"
		 xml["stroke"] = graphic.style!.stroke is Double && !(graphic.style!.stroke as! Double).isNaN ? "#"+ColorUtils.hexString(UInt(graphic.style!.stroke as! Double)):"none"
         if(!graphic.style!.strokeWidth.isNaN && graphic.style!.strokeWidth != 1) {xml["stroke-width"] = "\(graphic.style!.strokeWidth)"}
		 // :TODO: add support for fillOpacity,fillRule,strokeOpacity,strokeLineCap,strokeLineJoin,strokeMiterLimit, (Get ques from the old SVGPropertyParser)
		 return xml;
	 }
    /**
     *
     */
    class func dsc(inout svg:SVGContainer,_ pivot:CGPoint,_ scalePoint:CGPoint){
        for var i = 0; i < svg.items.count; ++i{
            if(svg.items[i] is SVGContainer){
                let svgContainer:SVGContainer = svg.items[i] as! SVGContainer
                for var e = 0; e < svg.items.count; ++e{
                    if((svg.items[i] as! SVGContainer).items[e] is SVGPath){
                        Swift.print((svgContainer.items[e] as! SVGPath).parameters)
                    }
                }
            }else{
                fatalError("no")
            }
        }
    }
    /**
     * Styles an @param element with @param style
     * // :TODO: rename to stylize?
     * @Note this method is recursive
     */
    class func style(inout element:ISVGElement,_ style:SVGStyle) {
        element as! SVGGraphic
        //SVGModifier.update()
        //if(element is SVGView) {/*(element as! SVGView).style = style*/}
        if(element is SVGGraphic) {}
        /*if(element is SVGContainer) {
        for (var i : Int = 0; i < (element as! SVGContainer).items.count; i++){
        //if((element as! SVGContainer).items[i] is ISVGView) {SVGUtils.style((element as! SVGContainer).items[i], style)}
        }
        }*/
    }
}