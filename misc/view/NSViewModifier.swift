import Cocoa
/**
 * TODO: make a method with the NSView.sortSubviewsUsingFunction method. 
 */
class ViewModifier {//<----rename to NSViewModifier
    /**
     *
     */
    class func applyColor(view:NSView,_ nsFillColor:NSColor = NSColor.clearColor(),_ nsLineColor:NSColor = NSColor.clearColor(),_ lineWidth:Int = 0){
        let cgFillColor:CGColor = CGColorParser.cgColor(nsFillColor)
        if(nsFillColor != NSColor.clearColor()){/*clearColor: 0.0 white, 0.0 alpha */
            //Swift.print("fill")
            view.layer!.backgroundColor = cgFillColor
            
        }
        let cgLineColor:CGColor = CGColorParser.cgColor(nsLineColor)
        //Swift.print(nsLineColor)
        if(nsLineColor != NSColor.clearColor()){/*clearColor: 0.0 white, 0.0 alpha */
            //Swift.print("line")
            view.layer!.borderColor = cgLineColor
            view.layer!.borderWidth = CGFloat(lineWidth)
        }
    }
    /**
     * Sets the position of an NSView instance
     * TODO: make the same method for size
     */
    class func position(view:NSView,_ point:CGPoint){
        view.frame.origin = point
    }
    /**
     *
     */
    class func removeAll(view:NSView){
        for subView in view.subviews {
            subView.removeFromSuperview()
        }
    }
    /**
     * Removes all children in a Sprite
     * // :TODO: rename to removeAll
     * // :TODO: it could actually be faster to define the number of children first and then just deleting index 0
     * view.subviews.forEach({ $0.removeFromSuperview() }) // this gets things done
     * view.subviews.map({ $0.removeFromSuperview() }) // this returns modified array
     */
    class func removeAllChildren(view:NSView){
        while(view.subviews.count > 0) {(view.subviews[0] as NSView).removeFromSuperview()}
    }
    /**
     *
     */
    class func addSubviewAt(view: NSView,_ subView:NSView, _ i:Int){
        if(i == 0 || view.subviews.count == 0){
            view.addSubview(subView)
        }else{
            let relativeView = view.getSubviewAt(i-1)
            Swift.print("relativeView: " + "\(relativeView)")
            view.addSubview(subView, positioned: NSWindowOrderingMode.Above, relativeTo: relativeView)
        }
    }
    /**
     *
     */
    class func removeSubviewAt(view: NSView, _ i:Int){
        let item = view.getSubviewAt(i)
        item.removeFromSuperview()
    }
    
    class func childrenOfType<T>(view:NSView, _ type:T.Type)->Array<T> {
        var children:Array<T> = []
        for subView in view.subviews {
            if(subView as? T != nil){children.append(subView as! T)}
        }
        return children;
    }
    /**
     * Beta (not tested, but similar code will work, use pen and paper if it doesnt)
     * @Note: remove children in a backward direction over the array
     */
    class func removeAllOfType<T>(view:NSView, _ type:T.Type) {
        let childrenLength:Int = view.subviews.count
        for (var i : Int = childrenLength-1; i >= 0; i--) {
            if(view.subviews[i] as? T != nil) {
                view.subviews[i].removeFromSuperview()
            }
        }
    }
}