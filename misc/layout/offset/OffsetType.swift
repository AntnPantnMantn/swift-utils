import Foundation
/*
* // :TODO: redesign this class like TRBL
* TODO: this should probably use GEnerics, to get rid of the casting
*/
class OffsetType:Equatable,ILayout{
    static var center:String = "center";// :TODO: move this to a class called OffsetType
    static var outside:String = "outside";
    static var inside:String = "inside";
    var left:String
    var right:String
    var top:String
    var bottom:String
    required init(_ args:Any...){
        switch(args.count){
            case 0: left = OffsetType.center; right = OffsetType.center; top = OffsetType.center; bottom = OffsetType.center
            case 1: left = args[0] as! String; right = args[0] as! String; top = args[0] as! String; bottom = args[0] as! String;
            case 2: left = args[0] as! String; right = args[0] as! String;top = args[1] as! String; bottom = args[1] as! String;
            case 3: left = args[0] as! String;right = args[1] as! String;top = args[2] as! String;bottom = OffsetType.center;
            default: left = args[0] as! String;right = args[1] as! String;top = args[2] as! String;bottom = args[3] as! String; /*length >= 4*/
        }
    }
}
/**
 * Equality
 */
func == (lhs: OffsetType, rhs: OffsetType) -> Bool {
    return lhs.left == rhs.left && lhs.right == rhs.right && lhs.top == rhs.top && lhs.bottom == rhs.bottom
}
extension OffsetType{
    /**
     *
     */
    class func center()->OffsetType{
        return OffsetType(OffsetType.center)
    }
}