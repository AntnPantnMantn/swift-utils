import Foundation
class FileParser{
	/*
	 * Returns string content from a file at file location "path"
     * PARAM path is the file path to the file
     * Todo: What format is the path?
	 */
    
    /*
    let path = "//Users/<path>/someFile.xml"
    
    var err: NSError?
    let content = String.stringWithContentsOfFile(path, encoding: NSUTF8StringEncoding, error: &err)


    */
	class func content(path:String)->String?{
        do {
            let content = try String(contentsOfFile: path, encoding: NSUTF8StringEncoding) as String//encoding: NSUTF8StringEncoding
            return content
        } catch {
            // contents could not be loaded
            return nil
        }
        
	}
    /**
     * Returns an xml instance comprised of the string content at location @param path
     */
    class func xml(path:String)->NSXMLElement {
        let content = FileParser.content(path.tildePath)
        let xmlDoc:NSXMLDocument = try! NSXMLDocument(XMLString: content!, options: 0)
        let rootElement:NSXMLElement = xmlDoc.rootElement()!
        return rootElement
    }
	/**
	 * Returns the project resource folder
	 * NOTE: https://developer.apple.com/library/mac/documentation/Cocoa/Reference/Foundation/Classes/NSBundle_Class/
	 */
    class func resourcePath()->String{
		return NSBundle.mainBundle().resourcePath!
	}
    /**
     * resourceContent("example","txt")
     */
    class func resourceContent(fileName:String, _ fileExtension:String)->String?{
        if let filepath = NSBundle.mainBundle().pathForResource(fileName, ofType:fileExtension ) {
            return content(filepath)
        } else {
            // example.txt not found!
            return ""
        }
    }
}



/*
/*open modal panel*/
let myFileDialog: NSOpenPanel = NSOpenPanel()
myFileDialog.runModal()

// Get the path to the file chosen in the NSOpenPanel
let thePath = myFileDialog.URL?.path

// Make sure that a path was chosen
if (thePath != nil) {
let theContent = FileParser.content(thePath!)
Swift.print("theContent: " + "\(theContent)")
}
*/