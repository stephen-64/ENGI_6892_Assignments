
/**
 * A Simple Structure that holds
 * an Interval in the set S
 */
typedef Interval = {
    var a:Float;
    var b:Float;
}

/**
 * Solution to problem 1 in assignment 4
 * 
 */
class A4Q1{

    /**
     * Main entry point for the solution code
     */
    public static function main(){
        var P:Array<Float>;
        var S:Array<Interval>;
        var results:Array<Interval>;

        P = [1,2,3,4,5,6];
        S = [{a:1,b:3},{a:4,b:6},{a:1,b:4},{a:1,b:6},{a:2,b:7}];

        results = smallest_set(P,S);
        trace(results);
    }
    /**
     * Greedy algorithm used to calculate the smallest subset of S that will
     * cover every point in P
     * @param P An array containg all the points to be matched
     * @param S The set of available Intervals 
     * @return An array contianing the list of intervals that cover the range of given points
     */
    public static function smallest_set(P:Array<Float>,S:Array<Interval>):Array<Interval>{
        // Variable to hold the max intervale
        var interval_holder = new Array<Interval>();
        /**
         * Loops through all the points in the array making sure each point is covered
         */
        for (point in P){
            var checker:Bool = true;
            /**
            * This first loop checks that the value isn't already contained within the intervals covered by
            * the selected interval assuring we aren't taking a new interval for a value already covered
            * by intervals we already have
            */
            for (set in interval_holder){
                if( (set.a<=point) && (set.b>=point) ){
                    checker = false;
                }
            }
            /**
             * This seond loop will only run when there doesn't exist a point within the intervals that already 
             * contains the curent point being processed assuring that no extra points are taken
             */
            if(checker){
                // Used to hold the location of the next best interval
                var p_max:Int = 0;
                /**
                 * This loop will check that not only does the current interval represent the best possible interval but 
                 * that it also covers more points than the next possible interval. If there exists a interval that 
                 * both holds the point and covers a greater range of points than the current interval we will
                 * take that interval ensuring we have an optimal solution and a greedy algorithm by taking the 
                 * interval that covers the most points first. 
                 */
                for (i in 0...S.length){
                    if( (S[i].a <= point) && (S[i].b >= point) && ( (S[i].b - S[i].a) > (S[p_max].b - S[p_max].a) ) ){
                        p_max = i;
                    }
                }
                /**
                 * Loads the value into out interval list ot be returned
                 */
                interval_holder.push(S[p_max]);
            }
        } 
        // Returns the best intervals
        return interval_holder;
    }
}