import Foundation

class SVGCircleModifier {
    /**
     * Scales the SVGCircle instance from @param pivot to a specific @param scale scalar value (0-1)
     */
    class func scale(circle:SVGCircle,_ pivot:CGPoint,_ scale:CGPoint) {
        Swift.print("SVGCircleModifier.circle() circle: " + "\(circle)")
        Swift.print("circle.r: " + "\(circle.r)")
        let circleCenter:CGPoint = PointModifier.scale(circle.center, pivot, scale);
        let circleRadius:CGFloat = circle.r * scale.x;
        circle.center = circleCenter;
        circle.r = circleRadius;
    }
}