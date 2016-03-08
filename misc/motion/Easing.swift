import Cocoa
/**
 * t: time (current frame) this can also be actual time
 * b: begin (the value it is at the begining)
 * c: change (end value - begining value) sort of the amount to change, this can also be described as the difference between two values
 * d: duration (total frames in anim) this can also be actual time
 * TODO://Elastic, Circular, Back, bounce, Quibic +++
 */
class Easing{
    //No easing, linear animation
    class func easeLinear (t:CGFloat, _ b:CGFloat, _ c:CGFloat, _ d:CGFloat)->CGFloat{//Think line in graph: y = x
        return c*t/d + b
    }
    //Sine SINUSOIDAL EASING: sin(t)
    class func easeInSine (t:CGFloat, _ b:CGFloat, _ c:CGFloat, _ d:CGFloat)->CGFloat{
        return -c * cos(t/d * π2) + c + b
    }
    class func easeOutSine (t:CGFloat, _ b:CGFloat, _ c:CGFloat, _ d:CGFloat)->CGFloat{
        return c * sin(t/d * π2) + b
    }
    class func easeInOutSine (t:CGFloat, _ b:CGFloat, _ c:CGFloat, _ d:CGFloat)->CGFloat{
        return -c/2 * (cos(π*t/d) - 1) + b
    }
    //Quintic - QUINTIC EASING: t^5
    class func easeInQuint (var t:CGFloat, _ b:CGFloat, _ c:CGFloat, _ d:CGFloat)->CGFloat{
        t = t/d
        return c*t*t*t*t*t + b
    }
	class func easeOutQuint (var t:CGFloat, _ b:CGFloat, _ c:CGFloat, _ d:CGFloat)->CGFloat{
		t = t/d-1
		return c*(t*t*t*t*t + 1) + b
	}
	class func easeInOutQuint(var t:CGFloat, _ b:CGFloat, _ c:CGFloat, _ d:CGFloat)->CGFloat {
        t = t/(d/2)//<--the brackets are important
		if (t < 1) {return c/2*t*t*t*t*t + b}
        t = t-2
		return c/2*(t*t*t*t*t + 2) + b
	}
    //Quartic
    class func easeInQuart(var t:CGFloat, _ b:CGFloat, _ c:CGFloat, _ d:CGFloat)->CGFloat{
        t = t/d
        return c*t*t*t*t + b
    }
    class func easeOutQuart(var t:CGFloat, _ b:CGFloat, _ c:CGFloat, _ d:CGFloat)->CGFloat{
		t = (t/d)-1//<--the brackets are important
		return -c * (t*t*t*t - 1) + b
	}
    class func easeInOutQuart(var t:CGFloat, _ b:CGFloat, _ c:CGFloat, _ d:CGFloat) -> CGFloat{
		t = t/(d/2)//<--the brackets are important
		if (t < 1) {return c/2*t*t*t*t + b}
		t = t-2
		return -c/2 * (t*t*t*t - 2) + b;
	}
	//Quadratic
	class func easeInQuad (var t:CGFloat, _ b:CGFloat, _ c:CGFloat, _ d:CGFloat)-> CGFloat{
		t = t/d
		return c*t*t + b;
	}
	class func easeOutQuad (var t:CGFloat, _ b:CGFloat, _ c:CGFloat, _ d:CGFloat)-> CGFloat{
		t = t/d
		return -c*t*(t-2) + b;
	}
	class func easeInOutQuad (var t:CGFloat, _ b:CGFloat, _ c:CGFloat, _ d:CGFloat)-> CGFloat{
		t = t/(d/2)//<--the brackets are important
		if (t < 1) {return c/2*t*t + b}
		return -c/2 * ((--t)*(t-2) - 1) + b;
	}
    //Exponential
    class func easeInExpo(t:CGFloat, _ b:CGFloat, _ c:CGFloat, _ d:CGFloat)-> CGFloat{
       return (t==0) ? b : c * pow(2, 10 * (t/d - 1)) + b;
    }
    class func easeOutExpo(t:CGFloat, _ b:CGFloat, _ c:CGFloat, _ d:CGFloat)-> CGFloat{
        return (t==d) ? b+c : c * (-pow(2, -10 * t/d) + 1) + b;
    }
    private class func easeInOutExpo(t:CGFloat, _ b:CGFloat, _ c:CGFloat, _ d:CGFloat)-> CGFloat{
        /*if (t==0) return b;
        if (t==d) return b+c;
        if ((t/=d/2) < 1) return c/2 * Math.pow(2, 10 * (t - 1)) + b;
        return c/2 * (-Math.pow(2, -10 * --t) + 2) + b;*/
    }
   
    //Elastic
    private class func easeInElastic(){
        /*var s:Number;
        if (t==0) return b;  if ((t/=d)==1) return b+c;  if (!p) p=d*.3;
        if (!a || a < Math.abs(c)) { a=c; s=p/4; }
        else s = p/PI_M2 * Math.asin (c/a);
        return -(a*Math.pow(2,10*(t-=1)) * Math.sin( (t*d-s)*PI_M2/p )) + b;*/
    }
    private class func easeOutElastic(){
        /*var s:Number;
        if (t==0) return b;  if ((t/=d)==1) return b+c;  if (!p) p=d*.3;
        if (!a || a < Math.abs(c)) { a=c; s=p/4; }
        else s = p/PI_M2 * Math.asin (c/a);
        return (a*Math.pow(2,-10*t) * Math.sin( (t*d-s)*PI_M2/p ) + c + b);*/
    }
    private class func easeInOutElastic(){
        /*var s:Number;
        if (t==0) return b;  if ((t/=d/2)==2) return b+c;  if (!p) p=d*(.3*1.5);
        if (!a || a < Math.abs(c)) { a=c; s=p/4; }
        else s = p/PI_M2 * Math.asin (c/a);
        if (t < 1) return -.5*(a*Math.pow(2,10*(t-=1)) * Math.sin( (t*d-s)*PI_M2/p )) + b;
        return a*Math.pow(2,-10*(t-=1)) * Math.sin( (t*d-s)*PI_M2/p )*.5 + c + b;*/
    }
    //Circular
    //
    private class func easeInCircular(){
        //return -c * (Math.sqrt(1 - (t/=d)*t) - 1) + b;
    }
    private class func easeOutCircular(){
        //return c * Math.sqrt(1 - (t=t/d-1)*t) + b;
    }
    private class func easeInOutCircular(){
        /*
        if ((t/=d/2) < 1) return -c/2 * (Math.sqrt(1 - t*t) - 1) + b;
        return c/2 * (Math.sqrt(1 - (t-=2)*t) + 1) + b;
        */
    }
    //Back
    private class func easeInBack(){
        //return c*(t/=d)*t*((s+1)*t - s) + b;
    }
    private class func easeOutBack(){
        //return c*((t=t/d-1)*t*((s+1)*t + s) + 1) + b;
    }
    private class func easeInOutBack(){
        /*if ((t/=d/2) < 1) return c/2*(t*t*(((s*=(1.525))+1)*t - s)) + b;
        return c/2*((t-=2)*t*(((s*=(1.525))+1)*t + s) + 2) + b;*/
    }
    //Bounce
    private class func easeInBounce(){
        //return c - easeOutBounce (d - t, 0, c, d) + b;
    }
    private class func easeOutBounce(){
        /*if ((t/=d) < (1/2.75)) {
        return c*(7.5625*t*t) + b;
        } else if (t < (2/2.75)) {
        return c*(7.5625*(t-=(1.5/2.75))*t + .75) + b;
        } else if (t < (2.5/2.75)) {
        return c*(7.5625*(t-=(2.25/2.75))*t + .9375) + b;
        } else {
        return c*(7.5625*(t-=(2.625/2.75))*t + .984375) + b;
        }*/
    }
    private class func easeInOutBounce(){
        /*if (t < d/2) return easeInBounce (t*2, 0, c, d) * 0.5 + b;
        else return easeOutBounce (t*2-d, 0, c, d) * 0.5 + c*.5 + b;*/
    }
    
    
}

/*
/**
* NOTE: If you decrease the decimal variable you increase the friction effect
*/
class func easeOut(value : CGFloat, _ from:CGFloat, _ to:CGFloat) -> CGFloat {
let distToGoal:CGFloat = NumberParser.relativeDifference(value, to)
let val:CGFloat = 0.2 * distToGoal
return val
}

*/