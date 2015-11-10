import Cocoa
class ColorUtils {
    /**
     *
     */
    class func randomColor()-> NSColor{
        let r:CGFloat  = CGFloat(rand() % 255) / 255.0;
        let g:CGFloat  = CGFloat(rand() % 255) / 255.0;
        let b:CGFloat  = CGFloat(rand() % 255) / 255.0;
        let nsColor:NSColor = NSColor(calibratedRed: r, green: g, blue: b, alpha: 1)
        return nsColor
    }
    /**
     *
     */
    class func randomColor()->CGColor{
        let r:CGFloat  = CGFloat(rand() % 255) / 255.0;
        let g:CGFloat  = CGFloat(rand() % 255) / 255.0;
        let b:CGFloat  = CGFloat(rand() % 255) / 255.0;
        
        let color:CGColorRef  = CGColorCreateGenericRGB(r, g, b, 1.0);
        return color
    }
    /**
     *
     */
    class func hexNumber(hex:String) -> UInt{
        return UInt(Float(hex)!)
    }
    /**
     *
     */
    class func hexString(hex:UInt) -> String{
        return NSString(format: "%2X", hex) as String
    }
}