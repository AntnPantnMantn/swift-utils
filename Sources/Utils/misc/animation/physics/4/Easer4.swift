import Foundation
/**
 * NOTE: The FrameTick and the InitValues typaliases are the same in Springer and Easer so we just reuse them
 * NOTE: This is the Base class
 */
class Easer4<T: Advancable4>:FrameAnimator, PhysicsAnimKind4{
    typealias InitValues = (value:T,targetValue:T,velocity:T,stopVelocity:T)
    typealias FrameTickSignature = (T)->Void
    var easing:T
    var initValues:InitValues
    var callBack:FrameTickSignature//TODO: ⚠️️ rename to onFrameTick,onFrameCallback?
    
    init(_ initValues:Easer4.InitValues, _ easing:T, _ callBack:@escaping FrameTickSignature) {
        self.initValues = initValues
        self.callBack = callBack
        self.easing = easing
        super.init()
    }
    override func onFrame() {
        self.updatePosition()
        self.callBack(value)
    }
    func updatePosition() {
        velocity = (targetValue - value) * easing
        value = value + velocity
        if assertStop {stop()}
    }
    var assertStop:Bool {
        return velocity.isNear(value:stopVelocity, epsilon:T.defaultEpsilon)
    }
}
/*Convenient default init values*/
var initConfig:CGFloat { return (0.2) }
var initPointConfig:CGPoint { return CGPoint(0.2,0.2) }
/*CGPoint*/
var initPointValues: Easer4<CGPoint>.InitValues = (CGPoint(0,0),CGPoint(0,0),CGPoint(0,0),CGPoint(0,0))
var initValues: Easer4<CGFloat>.InitValues = (0,0,0,0)
