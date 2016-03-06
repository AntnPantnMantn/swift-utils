import Cocoa
import QuartzCore
/**
 * TODO: Write an example
 * NOTE: Example is in the Graphics class
 * NOTE: you can set the position by calling: graphic.frame.origin = CGPoint()
 * IMPORTANT: You need to set the size of the frame to something, or else the graphics will be clipped. You can get a rect for For Paths and lines by using the native boundingbox methods or custom boundingbox methods
 */
class Graphic:InteractiveView2,IGraphic{
    lazy var fillShape:Shape = Shape()//TODO:Graphic.init(): dont use lazy, they could be the problem to alot of things, casting problems etc
    lazy var lineShape:Shape = Shape()//{get{return fillShape}set{fillShape = newValue}}/*Shape()*/
    var fillStyle:IFillStyle? //{get{return fillShape.fillStyle}set{fillShape.fillStyle = newValue}}
    var lineStyle:ILineStyle?
    var lineOffsetType:OffsetType;
    var selector: ((layer: CALayer, ctx:CGContext) -> ())?/*this holds any method assigned to it that has its type signature*/
    var trackingArea:NSTrackingArea?
    
    
    
    //override var wantsDefaultClipping:Bool{return false}//avoids clipping the view, not needed when you use layer-hosted
    //override var wantsUpdateLayer:Bool {return true}
    init(_ fillStyle:IFillStyle? = nil, _ lineStyle:ILineStyle? = nil, _ lineOffsetType:OffsetType = OffsetType()){
        //Swift.print("Graphic.init()")
        self.fillStyle = fillStyle
        //self.fillShape = FillShape(fillStyle)
        self.lineStyle = lineStyle
        self.lineOffsetType = lineOffsetType
        super.init(frame:NSRect(0,0,0/*<- was 1*/,0/*<- was 1*/))//<---move this into the arguments/*the width and the height arent clipped*/
        //layerContentsRedrawPolicy = NSViewLayerContentsRedrawPolicy.OnSetNeedsDisplay//this is new, but apple recomends it, more about it here: https://developer.apple.com/library/ios/documentation/Cocoa/Conceptual/CoreAnimation_guide/SettingUpLayerObjects/SettingUpLayerObjects.html#//apple_ref/doc/uid/TP40004514-CH13-SW4
        //wantsLayer = true//this avoids calling drawLayer() and enables drawingRect()
        //layer = CALayer()//TempCALayer(layer: layer!)
        //layer!.masksToBounds = false//this is needed!!!
        layer?.addSublayer(fillShape)
        layer?.addSublayer(lineShape)
        self.fillShape.delegate = self/*this is needed in order to be able to retrive the context and use it whithin the decoratable methods, or else the context would reside isolated inside the Graphic.fillShape, and Graphic.lineShape*/
        self.lineShape.delegate = self
        //self.setDelegate(self)
        
        
        /*
        
        let actions = ["transform": NSNull(),"position":NSNull(),"frame": NSNull(),"bounds": NSNull(),"frame.position":NSNull()]
        
        
        self.fillShape.actions = actions;
        self.layer!.actions = actions;
        self.lineShape.actions = actions;
        
        */
        
        //continue here: it seems CVDisplayLink uses its own CGContext. so either add this to the graphic, or use NSTimer.
        //you may want to do more research, if you have to change the context then NSText may not work at all. Maybe NStimer or GDC is better
        
    }
    /**
     * Stops implicit animation from happening
     * NOTE: Remember to set the delegate of your CALayer instance to an instance of a class that at least extends NSObject. In this example we extend NSView.
     * NOTE: this is a delegate method for the shapes in Graphic
     * NOTE: this method is also called on every frame of the animation it seems
     */
    override func actionForLayer(layer: CALayer, forKey event: String) -> CAAction? {
        //Swift.print("actionForLayer layer: " + "\(layer)" + " event: " + "\(event)")
        return NSNull()//super.actionForLayer(layer, forKey: event)//
    }
    /*override func animationForKey(key: String) -> AnyObject? {
    Swift.print("animationForKey")
    return super.animationForKey(key)
    }
    override func animationDidStart(anim: CAAnimation) {
    Swift.print("animationDidStart: " + "\(anim)")
    }
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
    Swift.print("animationDidStop: " + "\(anim)")
    }*/
    
    /*override func mouseDown(theEvent: NSEvent) {
        Swift.print("Graphic.down")
        super.mouseDown(theEvent)
    }*/
    /**
     * This is the last NSView so we dont forward the hitTest to further descendants, however we could forward the hit test one more step to the CALayer
     * TODO: the logic inside this method should be in the Shape, and this method should just forward to the shape
     */
    override func hitTest(aPoint: NSPoint) -> NSView? {
        //Swift.print("hitTest in graphic" + "\(aPoint)")
        //you have to convert the aPoint to localspace
        
        let localPoint = localPos()//convertPoint(aPoint, fromView: self.window?.contentView)//convertPoint(winMousePos, fromView: nil)//
        //Swift.print("localPoint: " + "\(localPoint)")
        
        let isPointInside:Bool = CGPathContainsPoint(fillShape.path,nil,localPoint,true)
        //Swift.print("isPointInside: " + "\(isPointInside)")
        
        return isPointInside ? self : super.hitTest(aPoint)/*return nil will tell the parent that there was no hit on this view*/
        
        //continue here, you need to check for subViews, since assetDecorator uses this view to add it self to
    }
    /*var winMousePos:CGPoint {
    var pos = (window?.mouseLocationOutsideOfEventStream)!//convertPoint((window?.mouseLocationOutsideOfEventStream)!, fromView: nil)/*converts the p to local coordinates*/
    pos.y = window!.frame.height - pos.y/*flips the window coordinates*/
    return pos
    }*/
    /**
     * This is a delegate handler method
     * NOTE: using the other delegate method "displayLayer" does not provide the context to work with. Trying to get context other ways also fail. This is the only method that works with layer contexts
     * NOTE: this is a delegate method for the shapes in Graphic
     */
    override func drawLayer(layer: CALayer, inContext ctx: CGContext) {
        //Swift.print("Graphic.drawLayer(layer,inContext)")
        selector!(layer: layer,ctx: ctx)/*call the selector*/
        updateTrackingArea()
    }
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}/*Required by super class*/
}
extension Graphic{
    /**
     * Convenince implicit setter
     */
    func setProperties(fillStyle:IFillStyle? = nil, lineStyle:ILineStyle? = nil){// :TODO: remove this and replace with setLineStyle and setFillStyle ?
        //self.fillShape.fillStyle = fillStyle;
        self.fillStyle = fillStyle;
        self.lineStyle = lineStyle;
    }
    /**
     * NOTE: you should use bounds for the rect but we dont rotate the frame so we dont need to use bounds.
     * NOTE: the only way to update trackingArea is to remove it and add a new one
     * PARAM: owner is the instance that receives the interaction event
     * NOTE: we could keep the trackingArea in graphic so its always easy to access, but i dont think it needs to be easily accesible atm.
     */
    func updateTrackingArea() {
        //Swift.print("updateTrackingArea")
        //Swift.print("\(NSViewParser.parents(self))" + ".updateTrackingArea: " + "\(fillShape.frame)")
        if(trackingArea != nil) {//these 3 lines needs to be inside this if clause, if they arent an error may surface when you do animation with the CVDisplayLink
            self.removeTrackingArea(trackingArea!)
            trackingArea = NSTrackingArea(rect: fillShape.frame, options: [NSTrackingAreaOptions.ActiveAlways, NSTrackingAreaOptions.MouseMoved,NSTrackingAreaOptions.MouseEnteredAndExited], owner: self, userInfo: nil)
            self.addTrackingArea(trackingArea!)//<---this will be in the Skin class in the future and the owner will be set to Element to get interactive events etc
        }//remove old trackingArea if it exists
        super.updateTrackingAreas()
    }

}