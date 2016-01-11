import Foundation
/**
 * // :TODO: add an example here
 */
class SVGLinearGradient:SVGGradient {
    var x1:CGFloat/*The x1 and y1 (starting point) of the vector defining the direction of the gradient. Specified as percentages (%) of x1,y1 and x2,y2 of the shape the gradient is applied to. (Note: You should be able to use absolute numbers, but this doesn't seem to work in the browsers).*/
    var y1:CGFloat
    var x2:CGFloat//x2, y2 /*The x2 and y2 (end point) of the vector defining the direction of the gradient.*/
    var y2:CGFloat
	init(_ offsets:Array<CGFloat>,_ colors:Array<CGColor>, /*opacities:Array<CGFloat>,*/ _ x1:CGFloat, _ y1:CGFloat, _ x2:CGFloat,_ y2:CGFloat, _ gradientUnits:String, _ spreadMethod:String, _ id:String/*,gradientTransform:Matrix*/) {
		self.x1 = x1
		self.y1 = y1
		self.x2 = x2
		self.y2 = y2
		super.init(offsets, colors, /*opacities,*/ spreadMethod, id, gradientUnits)
	}
}
/**
 * Convenience
 */
extension SVGLinearGradient{
    var p1:CGPoint {get{return CGPoint(x1,y1)}set {x1 = newValue.x;y1 = newValue.y}}
    var p2:CGPoint {get{return CGPoint(x2,y2)}set {x2 = newValue.x;y2 = newValue.y}}
}


//,x1:CGFloat = CGFloat.NaN, y1:CGFloat = CGFloat.NaN, x2:CGFloat = CGFloat.NaN, y2:CGFloat = CGFloat.NaN