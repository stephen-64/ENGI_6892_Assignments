import haxe.ds.ArraySort;

/**
 * A class implementing assignment 4 question 2
 */
class A4Q2{

    /**
     * A test of the max_payoff function
     */
    public static function main(){
        var A:Array<Int>;
        var B:Array<Int>;
        A = [1,2,3,4,5,6,7,8,9,10];
        B = [1,2,3,4,5,6,7,8,9,10];
        var payoff = max_payoff(A,B);
        trace(payoff);
    }

    /**
     * This function will calculate the max payoff of 
     * the two given arrays and return it's values
     * This method has a complexity of theta(n^3) where n is the size of A and B
     * since in the worst case it will have to run through the array in it's interity 
     * 3 times. Once for each of the sorts and a final time for the payoff calculation
     * @param A The first array of values to be used in calculating payoff
     * @param B The second array of values to be used in calculating payoff
     * @return The max_payoff acheived by combining the two given arrays
     */
    public static function max_payoff(A:Array<Int>,B:Array<Int>):Float{
        var payoff:Float = 1;
        /**
         * This comparison function when given to the 
         * sort function will sort the array in decending order
         * with the largest values first 
         * and the smallest last
         */
        var cmp = function(a,b):Int{
            if(a<b){
                return 1;
            }else if(a>b){
                return -1;
            }
            return 0;
        };
        /**
         * This will sort Array A and B using a merge sort 
         * approach O(nlogn) and the comparison function given above
         */
        ArraySort.sort(A,cmp);
        ArraySort.sort(B,cmp);

        /**
         * This will loop through both arrays since we know they are both the 
         * same size based on the problem specification we can assume we only need to loop 
         * through the size of the loop once making this O(n). This can be proven as the max
         * payoff since we know that as long as both arrays are sorted such that there smallest values 
         * and largest values share the same index the largest value in the first array
         * will be raised to the power of the largest value in the second array and this will continue
         * for all the values. Since raising to a power has a much greater effect than multiplication 
         * this will insure max payoff
         */
        for (i in 0...A.length){
            payoff *= Math.pow(A[i],B[i]);
        }
        /**
         * Returns the max payoff 
         */
        return payoff;
    }

}