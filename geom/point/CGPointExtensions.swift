import Foundation


extension CGPoint{
    /**
     * Returns a point, in a polar cordinate system (from 0,0), for @param angle and @param length
     */
    static func polarPoint(radius:CGFloat, _ angle:CGFloat) -> CGPoint {
        return PointParser.polar(radius, angle)
    }
    /**
     * Returns the distance between two points
     */
    static func distance(a:CGPoint, _ b:CGPoint) -> CGFloat{
        return PointParser.distance(a,b)
    }
    /**
     *
     */
    static func interpolate(a:CGPoint, _ b:CGPoint, scalar:CGFloat) -> CGFloat{
        return PointParser.interpolate(a,b, scalar)
    }
}
/*Convenient extensions*/
extension CGPoint{
    func distance(p:CGPoint) -> CGFloat { return CGPoint.distance(self,p) }//distance from self to p
    func polarPoint(radius:CGFloat, _ angle:CGFloat) -> CGPoint { return self + CGPoint.polarPoint(radius, angle) }//polarPoint from self
    func interpolate(b:CGPoint,scalar:CGFloat) -> CGFloat { return CGPoint.interpolate(self,b,scalar) }//interpolate from self to b by scalar
    

    init(_ x: Double, _ y:Double) { self.x = CGFloat(x); self.y = CGFloat(y); }//Init a CGPoint with Double values
    init(_ x: Int, _ y:Int) {self.x = CGFloat(x);self.y = CGFloat(y); }//Init a CGPoint with Int values
    init(_ x: CGFloat, _ y:CGFloat) { self.x = x;self.y = y;}//Init a CGPoint with CGFloat values (this method differes from the default by omitting the required argument names)
}
/*Convenient operators*/
public func +(a: CGPoint, b: CGPoint) -> CGPoint { return CGPoint(a.x+b.x, a.y+b.y)}//Adds the coordinates of point p to the coordinates of this point to create a new point
public func -(a: CGPoint, b: CGPoint) -> CGPoint { return CGPoint(a.x-b.x, a.y-b.y)}//Subtracts the coordinates of point p from the coordinates of this point to create a new point.
public func +=(inout a: CGPoint, b: CGPoint) {a.x += b.x;a.y += b.y;}//modifies a by adding b
public func -=(inout a: CGPoint, b: CGPoint) {a.x -= b.x;a.y -= b.y;}//modifies a by substracting b
public func * (left: CGPoint, right: CGPoint) -> CGPoint {return CGPoint(x: left.x * right.x, y: left.y * right.y)}//Multiplies two CGPoint values and returns the result as a new CGPoint.
public func *= (inout left: CGPoint, right: CGPoint) {left = left * right}/*Multiplies a CGPoint with another.*/
public func * (point: CGPoint, scalar: CGFloat) -> CGPoint {return CGPoint(x: point.x * scalar, y: point.y * scalar)}/*Multiplies the x and y fields of a CGPoint with the same scalar value and (returns the result as a new CGPoint.)*/
public func *= (inout point: CGPoint, scalar: CGFloat) {point = point * scalar}/*Multiplies the x and y fields of a CGPoint with the same scalar value.*/
public func / (left: CGPoint, right: CGPoint) -> CGPoint {return CGPoint(x: left.x / right.x, y: left.y / right.y)}/*Divides two CGPoint values and returns the result as a new CGPoint.*/
public func /= (inout left: CGPoint, right: CGPoint) {left = left / right}/*Divides a CGPoint by another.*/
public func / (point: CGPoint, scalar: CGFloat) -> CGPoint {return CGPoint(x: point.x / scalar, y: point.y / scalar)}/*Divides the x and y fields of a CGPoint by the same scalar value and returns (the result as a new CGPoint.)*/
public func /= (inout point: CGPoint, scalar: CGFloat) {point = point / scalar}/*Divides the x and y fields of a CGPoint by the same scalar value.*/
