import Foundation

extension CGFloat {
    func toFixed(places:Int)->CGFloat{
        return NumberModifier.toFixed(self, places)
    }
}
/**
 * Support for addition of CGFLoat and Double
 * TODO: probably use T or Generics or similar
 * TODO: add support for returning Double aswell
 * TODO: add support for Int and Float aswell
 */
public func + (left: CGFloat, right: Double) -> CGFloat {
    return left + CGFloat(right)
}
/**
 * Support for addition of CGFLoat and Double
 */
public func + (left: Double, right: CGFloat) -> CGFloat {
    return CGFloat(left) + right
}
/**
 *
 */
public func * (left: Int, right: CGFloat) -> CGFloat {
    return CGFloat(left) * right
}

/**
 *
 */
public func * (left: CGFloat, right: Int) -> CGFloat {
    return left * CGFloat(right)
}