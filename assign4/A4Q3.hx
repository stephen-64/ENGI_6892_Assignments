
/**
 * Implementation of the specification provided by Assignment 4
 * Question 3 
 */
class A4Q3{

    /**
     * Runs a simple test case to verify that the algorithm is working 
     */
    public static function main(){
        var S:Array<Int>;
        var goal:Int;
        var val = function(a:Array<Int>):Int{
            var holder:Int = 0;
            for (i in a){
                holder+=i;
            } 
            return holder;
        };
        S = [1,2,3,4];
        goal = 6;
        trace(subset_generator(S));
        trace(subset_checker(S,val,goal));
    }

    /**
     * Used to check if there exists a subset within S that will satisfy the goal given 
     * using the val function provided as an argument
     */
    @:generic public static function subset_checker<T>(S:Array<T>,val:Array<T>->Int,goal:Int):Bool{
        // Holds the result of if there was a valid subset
        var return_bool:Bool = false;
        // Holds all valid subsets for debugging purposes since the question
        // only asks to determine if a subset exists 
        var valid_subsets:Array<Array<T>> = new Array<Array<T>>();
        // Generates all subsets of S and stores them in their own array
        var subsets_S = subset_generator(S);
        //Parses through each subset in S checking it's value and seeing if it equals the goal
        for (array in subsets_S){
            if(val(array) == goal){
                // If there exists a subset that matches the goal this will set the return value to true
                return_bool = true;
                //Adds the valid subset to the storage array
                valid_subsets.push(array);
            }
        } 
        // Prints all valid subsets not required but nice for visualisation
        trace(valid_subsets);
        // Returns wether a valid subset exists
        return return_bool;

    }

    /**
     * Generates all the subsets of the given array S and returns an array containing all subsets
     */
    @:generic public static function subset_generator<T>(S:Array<T>):Array<Array<T>>{
        var return_val:Array<Array<T>> = new Array<Array<T>>();
        var lenght = S.length;
        var i:Int = 0;
        while(i<(1<<lenght)){
            var temp_holder:Array<T> = new Array<T>();
            var j:Int = 0;
            while(j<lenght){
                if( (i&(1<<j)) >0 ){
                    temp_holder.push(S[j]);
                }
                j++;
            }
            return_val.push(temp_holder);
            i++;
        }
        return return_val;
    }

}