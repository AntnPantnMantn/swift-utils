import Foundation
import Cocoa

class CGColorParser {
    /**
     * Returns a random CGColor
     */
    class func random()->CGColor{
        let r:CGFloat  = CGFloat(rand() % 255) / 255.0;
        let g:CGFloat  = CGFloat(rand() % 255) / 255.0;
        let b:CGFloat  = CGFloat(rand() % 255) / 255.0;
        let color:CGColorRef  = CGColorCreateGenericRGB(r, g, b, 1.0);
        return color
    }
    /**
    * Returns an nsColor for @param cgColor
    */
    class func nsColor(cgColor:CGColorRef)->NSColor{
        let ciColor = CIColor(CGColor: cgColor)//convert the cg to ci
        let nsColor = NSColor(CIColor: ciColor)//convert the ci to ns
        return nsColor
    }
    /**
     * NOTE: I think you can also just do: NSColor.redColor().CGColor, which renders this method obsolete
     * NOTE: This method is nice to have around for reference
     */
    class func cgColor(nsColor:NSColor)->CGColor{
        let ciColor:CIColor = CIColor(color: nsColor)!
        let cgColor = CIColorParser.cgColor(ciColor)
        return cgColor
    }
}