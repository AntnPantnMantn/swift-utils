import Cocoa

class TempNSView :FlippedView{
    override var wantsDefaultClipping:Bool{return false}//avoids clipping the view
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        let trackingArea:NSTrackingArea = NSTrackingArea(rect: bounds, options: [NSTrackingAreaOptions.ActiveAlways, NSTrackingAreaOptions.MouseMoved,NSTrackingAreaOptions.MouseEnteredAndExited], owner: self, userInfo: nil)
        
       addTrackingArea(trackingArea)
        
        
        //addTrackingRect(self.bounds, owner: self, userData: nil, assumeInside: true)//This enables entered and exited events to fire //let focusTrackingAreaOptions:NSTrackingAreaOptions = [NSTrackingActiveInActiveApp,NSTrackingMouseEnteredAndExited,NSTrackingAssumeInside,NSTrackingInVisibleRect,NSTrackingEnabledDuringMouseDrag]//NSTrackingEnabledDuringMouseDrag to mine to make sure the rollover behaves still when dragging in and out of the area.//TODO: you may need to update trackingarea: - (void)updateTrackingAreas
    }
    override func hitTest(aPoint: NSPoint) -> NSView? {
        Swift.print("hitTest")
        let pos = convertPoint(aPoint, toView: self)/*converts the p to local coordinates*/
        Swift.print("pos: " + "\(pos)")
        Swift.print("containsPoint(p): " + String(NSPointInRect(pos + frame.origin, frame)))
        
        return NSPointInRect(pos + frame.origin, frame) ? self : nil

    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
      override var acceptsFirstResponder: Bool { return true }
    
    override func mouseMoved(theEvent: NSEvent) {
        //Swift.print("mouseMoved")
    }
    
    override func drawRect(dirtyRect: NSRect) {
        Swift.print("TempNSView.drawRect()")
        let graphicsContext = NSGraphicsContext.currentContext()!
        let context = graphicsContext.CGContext/* Get the handle to the current context */
        let path = CGRect(0,0,100,100).path
        CGContextAddPath(context, path)
        CGContextSetFillColorWithColor(context,NSColor.random.CGColor)
        CGContextDrawPath(context, CGPathDrawingMode.Fill)
    }
    override func mouseDown(theEvent: NSEvent) {
        Swift.print("TempNSView.mouseDown()")
    }
    override func mouseEntered( event: NSEvent){
        Swift.print("TempNSView.mouseEntered: ")
    }
    override func mouseExited(event: NSEvent){
        Swift.print("TempNSView.mouseExited:")
    }
}
