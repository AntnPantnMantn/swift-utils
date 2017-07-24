import Foundation

protocol PhysicsAnimKind4:class {
    associatedtype T: Advancable4
    typealias FrameTickSignature = (T)->Void/*generic call back signature, use Spring.FrameTick outside this class*/
    typealias InitValues = (value:T,targetValue:T,velocity:T,stopVelocity:T)
    var initValues:InitValues {get set}
    /**/
    var targetValue:T {get set} /*Where value should go to*/
    var velocity:T {get set}/*Velocity*/
    var value:T {get set}/*The value that should be applied to the target*/
    var stopVelocity:T {get set}
    /*Event related*/
    var callBack:(argType)->Void {get set}/*The closure method that is called on every "frame-tick" and changes the property, you can use a var closure or a regular method, probably even an inline closure*/
}
