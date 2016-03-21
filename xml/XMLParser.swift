import Foundation

public class XMLParser{
    /**
     * Returns the root of an xml
     * NOTE: https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/NSXML_Concepts/NSXML.html#//apple_ref/doc/uid/TP40001263-SW1
     */
    public class func root(xmlStr:String)->NSXMLElement?{
        let xmlDoc:NSXMLDocument = try! NSXMLDocument(XMLString: xmlStr, options: 0)
        let rootElement:NSXMLElement = xmlDoc.rootElement()!
        return rootElement
        
    }
    /**
     * Returns all children of the root
     */
    public class func rootChildren(xmlStr:String)->Array<NSXMLElement>{
        let rootElement:NSXMLElement = root(xmlStr)!
        let children:NSArray = rootElement.children!
        let theChildren:Array<NSXMLElement> = children as! [NSXMLElement]
        return theChildren
    }
    /**
    *
    */
    public class func rootChildrenByFilePath(filePath:String)->Array<NSXMLElement>{
        let xmlStr:String = FileParser.content(filePath)!
        return rootChildren(xmlStr)
    }
    /**
     * Returns the value of a child
     * NOTE: retuns "" if there is no value
     * EXAMPLE: XMLParser.value(child)
     */
    public class func value(child:NSXMLElement)->String{
        return child.stringValue!
    }
    /**
     * Returns all attributes in @param child
     * EXAMPLE: attributes.count// num of attributes
     * EXAMPLE: if(attributes.count > 0) {  print(attributes[0]["value"]) }//prints the first attribute value in the first child that has an attribute
     */
    public class func attributes(child:NSXMLElement) -> [Dictionary<String,String>]{
        var attributes:[Dictionary<String,String>] = []
        if(child.attributes?.count > 0){
            for node:NSXMLNode in child.attributes!{
                var attribute:Dictionary<String,String> = [:]
                let name:String = node.name!
                let value:String = node.stringValue!
                //print("name: " + name + " " + "value:"+value)
                attribute["name"] = name
                attribute["value"] = value
                attributes.append(attribute)
            }
        }
        return attributes
    }
    /**
     * Returns child from @param children at @param index
     * EXAMPLE: XMLParser.childAt(children, 0)
     */
    public class func childAt(children:NSArray, _ index:Int)->NSXMLElement?{
        return children[index] as? NSXMLElement
    }
    /**
     * Returns an an XML instance at @param index (Array index)
     * @Note this function is recursive
     * @Note to find a child at an integer use the native code: xml.children[integer]
     * @Note to find the children of the root use an empty array as the index value
     */
    class func childAt(xml:NSXMLElement?,index:Array<Int>)->NSXMLElement? {
        if(index.count == 0 && xml != nil) {return xml}
        //xml!.children![0]
        else if(index.count == 1 && xml != nil) {
            let child:NSXMLElement = xml!.children![0]
            return child
        }// :TODO: if index.length is 1 you can just ref index
        
        // && xml!.children![index[0]] != nil
        //else if(index.count > 1 && xml.children().length() > 0) return childAt(xml.children()[index[0]],index.slice(1,index.length))
        return nil
    }
    /**
     * Returns the attribute value of @param child by key @param name
     * @pram name: name of the attribute
     * EXAMPLE: if let type:String = XMLParser.attribute(child, "type") { print("type: " + type) }
     * EXAMPLE: print(XMLParser.attribute(child, "type"))//returns Optional("digital") if there is something
     * NOTE: returns nil if there is no attr by that name
     */
    public class func attribute(child:NSXMLElement,_ name:String)->String?{
        return child.attributeForName(name)?.stringValue
    }
    /**
     * Returns the name of the @param child
     */
    public class func name(child:NSXMLElement)->String{
        return child.name!//child.localName also works
    }
    /**
     * Returns the first attribute that contains the attribute by the @param name and with the @param value
     */
    public class func childByAttribute(child:NSXMLElement,_ attributeName:String,_ attributeValue:String){
        //not implimented yet
    }
    /**
     * You can also drill down to the nodes you want using [ xmldoc nodesForXPath: @"/application/movie[@name='tc']" error: err ]
     * You can use the returned nodes as the new context node for evaluating further XPath expressions.
     */
    class func xPath(){
        
    }
    /**
     * Parses through an xml and returns an array
     * @example
     * 	<items>
            <item title="orange" property="harry"/>
            <item title="blue" property="na"/>
        </items>
     * outputs: [{title:"orange", property:harry}, {title:"blue", property:"no"}]
     */
    class func toArray(xml:NSXMLElement)->[Dictionary<String,String>] {
        var items:[Dictionary<String,String>] = []
        let count = xml.children!.count//or use rootElement.childCount TODO: test this
        for (var i = 0; i < count; i++) {
            let child:NSXMLElement = XMLParser.childAt(xml.children!, i)!
            //print("Import - child.toXMLString(): " + child.toXMLString());
            var item:Dictionary<String,String> = Dictionary<String,String>()
            let attributes:[Dictionary<String,String>] = XMLParser.attributes(child)
            for attribute in attributes {
                item[attribute["name"]!] = attribute["value"]!
            }
            if(child.stringValue != nil && child.stringValue!.count > 0) { item["xml"] = child.stringValue! }// :TODO: this may need to be rolled back to previouse code state
            items.append(item);
        }
        return items;
    }
}