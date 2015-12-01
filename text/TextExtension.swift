import Cocoa
/**
 * Now you can use all the methods provided by IPositional
 */
extension NSText : IPositional{
    //var position:CGPoint{get{return frame.origin} set{frame.origin = newValue}}
    func setPosition(position:CGPoint) {
        frame.origin = position
    }
    func getPosition() -> CGPoint {
        return frame.origin
    }
}
