import Foundation
protocol IPositional {
    var pos:CGPoint{get set}
    func setPosition(position:CGPoint)
    func getPosition() -> CGPoint
}
/**
 * CAUTION: These extensions can only be used if you dont need to cast the instance to ISizeable
 */
extension IPositional{
    //var positional:IPositional {get{return self as IPositional}set{}}/*This method provides support for returning a direct pointer when casting to protocol, which swift doesnt do, it only provides an immutable reference, which is unusable when setting mutating variables via extensions*/
    var x:CGFloat{get{return self.pos.x} set{self.pos.x = newValue}}
    var y:CGFloat{get{return self.pos.y} set{self.pos.y = newValue}}
    /*func getPosition() -> CGPoint {
    return position
    }*/
    /*mutating func setPosition(x:CGFloat,y:CGFloat){
    self.x = x
    self.y = y
    }*/
    /*mutating func setPosition(position:CGPoint){
    self.position.x = position.x
    self.position.y = position.y
    }*/
}


