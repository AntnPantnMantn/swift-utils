import Foundation

class Path {
    var commands:Array<Int>/* = Array<Int>();*/// :TODO: does this need to be created? isnt it passed through argument
    var pathData:Array<CGFloat>/* = Array<CGFloat>();*/// :TODO: does this need to be created? isnt it passed through argument
    var rotation:CGFloat;/*in degrees*/// :TODO: is this much used?// :TODO: if we can have roation why cant we have matrix?
    var name:String = "";/*temp*/// :TODO: why is this temp?
    init(commands:Array<Int>,pathData:Array<CGFloat>,rotation:CGFloat = 0) {
        self.commands = commands;
        self.pathData = pathData;
        self.rotation = rotation;
    }
}
