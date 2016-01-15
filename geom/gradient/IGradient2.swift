import Foundation

protocol IGradient2 {
    var colors:Array<CGColor>{get set}
    var locations:Array<CGFloat>{get set}
    var rotation:CGFloat{get set}
}
extension IGradient2{
    func copy() -> IGradient2 {
        if(self is LinearGradient){return LinearGradient(colors,locations,rotation)}
        else{return RadialGradient(colors,locations,rotation,(self as! RadialGradient).startCenter,(self as! RadialGradient).endCenter,(self as! RadialGradient).startRadius,(self as! RadialGradient).endRadius)}
    }
}