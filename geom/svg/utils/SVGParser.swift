import Foundation
/**
 * // :TODO: impliment text (<text x="60" y="165" style="font-family: sans-serif; font-size: 14pt; stroke: none; fill: black;">Cat</text>)
 */
class SVGParser {
    /**
     * Returns an SVGDoc instance derived from @param xml
     * @Note the regular expression removes the PX suffix
     */
    class func svg(xml:NSXMLElement)->SVG {
        var x:CGFloat = SVGPropertyParser.digit(xml,"x");
        var y:CGFloat = SVGPropertyParser.digit(xml,"y");
        var width:CGFloat = SVGPropertyParser.digit(xml,"width");
        var height:CGFloat = SVGPropertyParser.digit(xml,"height");
        var version:CGFloat = SVGPropertyParser.value(SVGPropertyParser.property(xml, "version"));
        var nameSpace:String = ""//xml.namespaceDeclarations().toString();//TODO: implement this later
        var id:String = SVGPropertyParser.id(xml);
        var doc:SVG = SVG([],x,y,width,height,version,nameSpace,id);
        
        for child : XML in xml.children() doc.add(element(child,doc));//print("Import - child.toXMLString(): " + child.toXMLString());
        return SVG()/*doc*/;
    }
}
