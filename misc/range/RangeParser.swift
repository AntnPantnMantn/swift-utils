/**
 * NOTE: Swift has some of these methods built in but its nice to have them in one place, and also so that you can create other methods with similar DNA
 */
class RangeParser {
    /**
     * Returns the minimum or smallest value in the range.
     */
    class func min<T:Comparable>(range:Range<T>)->T {
        return Swift.min(range.start, range.end);
    }
    /**
     *
     */
    class func describe<T>(range:Range<T>) {
        Swift.print("range.start: " + "\(range.start)")
        Swift.print("range.end: " + "\(range.end)")
    }
    /**
     * Returns The maximum or largest value in the range.
     */
    class func max<T:Comparable>(range:Range<T>)->T {
        return Swift.max(range.start, range.end);
    }
    
}