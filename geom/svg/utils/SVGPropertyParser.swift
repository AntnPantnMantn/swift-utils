import Foundation

class SVGPropertyParser {
	/**
	 * @Note could also be named attributeValue or value
	 * @param key is the that matches the returned value among the attributes in the xml item
	 */
	class func property(xml:NSXMLElement,_ key:String)->String? {
		return xml.hasAttribute(/*"@"+*/key) ? xml[/*"@"+*/key] : nil;
	}
	/**
	 * Returns a Number instance or if the property is null then NaN is returned
	 */
	class func value(property:Any?) -> CGFloat {
        //Swift.print("SVGPropertyParser.value() property: " + "\(property)")
		return property == nil ? CGFloat.NaN : CGFloat(Double((property as! String))!)//<-may be wrong conversion wrapping, also make a converter for ANy to CGFloat already
	}
	/**
	 * Returns NaN if no value is found and removes suffix "px" if found and also casts the value as a Number instance
	 * // :TODO: needs a re-write that doesnt include returning an associative array
	 */
	class func digit(xml:NSXMLElement,_ key:String)->CGFloat{
		let prop:Any? = property(xml, key)
        if(prop == nil) {return CGFloat.NaN}
		return StringParser.digit(prop as! String)//removes the px suffix and casts the value as a Number
	}
	/**
	 * Returns the id attribute if it exists in an xml item, returns an empty string if no id attribute is found
	 */
	class func id(xml:NSXMLElement)->String {
		return xml.hasAttribute("@id") ? xml["@id"]! : "";//xml.(hasOwnProperty("@id")).@id;TODO: the@ prefix is probably wrong
	}
	/**
	 * Returns an SVGStyle instance comprised of values derived from @param xml and or @param container, if no style data is available then default values are applied, NaN, empty string, null etc 
	 * @Note svg styles can have fill-opacity and also opacity, opacity applies to both stroke and fill
	 * SVGStyle should maybe have a master opacity value, for when you export svg again
	 */
	class func style(xml:NSXMLElement,_ container:ISVGContainer)->SVGStyle {
		//Swift.print("SVGPropertyParser.style(): ");//strokeLineCap
		var style:SVGStyle;
		let prop:String? = property(xml,"style");
        //Swift.print("SVGPropertyParser.style() prop: " + "\(prop)");
        if(prop != nil) {style = SVGStyleParser.style(prop,container)}//if a style is present in the @param xml, then derive the SVGStyle instance from this combined with the SVGContainer
		else{/*if no style is present in the xml, then derive the SVGStyle from fill,stroke etc. if these values are not present, a default value will be returned NaN, empty string, null etc whatever is appropriate*/
            //Swift.print("StylePropertyParser.style() xml.stringValue: " + "\(xml.stringValue)");
			let fill:Any = SVGStyleParser.fill(property(xml,"fill"), container)
            //Swift.print("SVGPropertyParser.style() fill: " + "\(fill)")
			var fillOpacity:CGFloat = SVGPropertyParser.value(property(xml,"fill-opacity"))
			let fillRule:String? = property(xml,"fill-rule")
			let stroke:Double = SVGStyleParser.stroke(property(xml,"stroke"))
			let strokeWidth:CGFloat = SVGPropertyParser.value(property(xml,"stroke-width"))
			var strokeOpacity:CGFloat = SVGPropertyParser.value(property(xml,"stroke-opacity"))
            //Swift.print("strokeOpacity: " + "\(strokeOpacity)")
			let strokeLineCap:String? = property(xml,"stroke-linecap")
			let strokeLineJoin:String? = property(xml,"stroke-linejoin")
			let strokeMiterLimit:CGFloat = SVGPropertyParser.value(property(xml,"stroke-miterlimit"))
            if(strokeOpacity.isNaN){strokeOpacity = SVGPropertyParser.value(property(xml,"opacity"))}/*<--new*/
            if(fillOpacity.isNaN){fillOpacity = SVGPropertyParser.value(property(xml,"opacity"))}/*<--new*/
			style = SVGStyle(fill, fillOpacity, fillRule, strokeWidth, stroke, strokeOpacity, strokeLineCap, strokeLineJoin, strokeMiterLimit)
            //Swift.print("style.strokeOpacity: " + "\(style.strokeOpacity)")
        }
		return style;
	}
}