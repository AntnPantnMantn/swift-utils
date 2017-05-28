import Foundation
//FlexContainer ->
//FlexItem -> init size, size,
class FlexBox {

}
enum FlexBoxType{
    enum Justify:String{
        case flexStart = "flexStart"/*Aligns from start to end*/
        case flexEnd = "flexEnd"/*Aligns from end to start*/
        case center = "center"/*Aligns one item after the other and centers their total position*/
        case spacebetween = "spaceBetween"/*Aligns all items from the absolute start to absolute end and adds equa spacing between them*/
        case spaceAround = "spaceAround"/*Same as spaceBetween but does not pit to sides but rather add equal spacing there as well*/
    }
}
class FlexBoxModifier{
    /**
     * TODO: Possibly use FlexItem here that decorates something 
     */
    static func justifyContent<T:IPositional>(_ items:[T], _ type:FlexBoxType.Justify) where T:ISizeable{
        switch type{
            case .flexStart:
                Swift.print("flexStart")
                JustifyUtils.justifyFlexStart(items)
            case .flexEnd:
                Swift.print("flexEnd")
            case .center:
                Swift.print("center")
            case .spacebetween:
                Swift.print("spacebetween")
            case .spaceAround:
                Swift.print("spaceAround")
        }
    }
}
class JustifyUtils{
    /**
     * Aligns from start to end
     */
    static func justifyFlexStart<T:IPositional>(_ items:[T]) where T:ISizeable{
        var x:CGFloat = 0//interim x
        items.forEach{ item in
            item.x = x
            x += item.width
        }
    }
}
