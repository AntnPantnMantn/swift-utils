import Foundation
class ClassAsserter{
	/**
	 * NOTE: You may try this aswell instance.isKindOfClass(classType)//seems not to work
     * CAUTION: doesnt work well with Double,String etc
     * IMPORTANT: doesnt work with protocols yet, do protocols as the example bellow:
     * EXAMPLE: 
     * protocol Decoratable{}
     * class A:Decoratable{}
     * class B:Decoratable{}
     * let object:AnyObject = A()
     * object.dynamicType is A.Type//true
     * object.dynamicType is B.Type//false
     * object.dynamicType is Decoratable.Type//true
     * NOTE: beware of isKindOfClass vs isMemberOfClass
	 */
    class func isOfClassType(obj:AnyObject,_ classType:AnyClass)->Bool{
        return obj.isMemberOfClass(classType)
    }
    /**
     * NOTE: this method supports checking if an instance is of the same ClassType as the other
     * NOTE: it also supports checking core classes like String and Double etc
     * NOTE: it also supports checking a class agains another
     * EXAMPLE: isOfSame("","")//true
     * EXAMPLE: isOfSame("".dynamicType,"".dynamicType)//true
     * EXAMPLE: isOfSame(SomeClass.self,SomeClass())//true
     * CAUTION: currently checking against protocols isnt supported
     */
    class func isOfSame(a: AnyObject, _ b: AnyObject) -> Bool {
        return object_getClassName(a) == object_getClassName(b)
    }
    /**
     * NOTE: you can also check if a class or instance is of a Protocol type: object.dynamicType is Decoratable.Type//true (this does not work if you add that line of text inside a method)
     * Note: protocol_conformsToProtocol(a,b) also exist
     * NOTE: // Works, but seems hackish as it reverts to string comparison NSStringFromProtocol(proto) == NSStringFromProtocol(Foo)
     * TODO: needs example, cant get this to work easily
     */
    class func isOfSameProtocol(a:Protocol,_ b:Protocol) -> Bool {
        return protocol_isEqual(a, b)
    }
}