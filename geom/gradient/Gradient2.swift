import Foundation
/**
 * The overall goal of this class is to provide a universal way to define gradients on a graphic. IMPORTANT ->>> So that if you scale the graphic the gradient will not look strange. <<<- IMPORTANT
 * EXAMPLE: let gradient:Gradient = Gradient([NSColor.blueColor().CGColor,NSColor.redColor().CGColor])
 * NOTE: NOTE: the radial scalar values can also be more or less than 0 and 1. think width * 1.2 etc. Works for both pos and size. (the only thing that is capped is the size if it goes under 0, then it is capped to 0)
 * NOTE: Radial gradient should maybe suport a dual system of focal and 2 point system (this dual support shoould not be provided by the Graphics class but rather the caller class)
 * NOTE: Linear and Radial should support both absolute and relative values that operate on the path boundingbox
 * TODO: Find that medium article on axial gradient. the one that looks like a "spread out patonefan"
 */
public class Gradient2:IGradient2 {/*<---its public so that it works in playground*/
    public var colors:Array<CGColor>
    public var locations:Array<CGFloat>/*same as color stops*/
    public var transformation:CGAffineTransform?
    public init(_ colors:Array<CGColor> = [], _ locations:Array<CGFloat> = [], _ transformation:CGAffineTransform? = nil){/*,*/
        self.colors = colors
        if (locations.count == 0/* && colors.count > 0*/) {//add support for nil aswell
            //Swift.print(colors.count)
            self.locations = CGFloatParser.interpolatedRange(0,  1,  colors.count)
            //Swift.print(self.locations)
        }else{
            self.locations = locations
        }
        self.transformation = transformation
    }
}
