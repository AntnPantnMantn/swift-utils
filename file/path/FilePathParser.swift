import Foundation
class FilePathParser {//TODO:rename to FilePathParser
    /**
     * Returns the path to where you can save your app's files. Here it is:
     */
    class func appDocPath()->String{
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        return paths[0]
    }
    /**
     * EXAMPLE: path("file:///Users/Me/Desktop/Doc.txt")/NSURL obj
     */
    class func path(stringPath:String)->NSURL{
        let url = NSURL(string: stringPath)
        return url!
    }
    /**
     * EXAMPLE: stringPath(path("file:///Users/Me/Desktop/Doc.txt"))//"file:///Users/Me/Desktop/Doc.txt"
     */
    class func stringPath(path:NSURL)->String{
        return path.absoluteString
    }
    /**
     *
     */
    class func userHomePath()-String{
        return NSHomeDirectory()
    }
}