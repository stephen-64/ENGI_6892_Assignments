import Assertion.*;
/**
 * The implementation of Question2a with several assertions
 * (assertions have been used to represnet the requires,ensures,invariants that 
 * would normally be used in Dafny)
 * static is used here to allow all function to run from main (this is 
 * a language thing I didn't want to make a class solely to run MaxHeapify)
 * 
 */
class Question2a{

    static function MaxHeapify(a:Array<Int>,s:Int,i:Int){
        assert(a.length == s);
        assert(a.length>=3);
        var copy_of_array:Array<Int> = new Array<Int>();
        for (value in a) {
            copy_of_array.push(value);
        }
        var loc_in_array,left_side,right_side :Int;
        loc_in_array = i;
        left_side = 2*i+1;
        right_side = 2*i+2;

        assert(loc_in_array==i);
        if(left_side<s && a[left_side]>a[loc_in_array]){
            assert(left_side<s);
            assert(a[left_side]>a[loc_in_array]);
            loc_in_array = left_side;
        }

        assert(loc_in_array==i || loc_in_array==left_side);
        if(right_side<s && a[right_side]>a[loc_in_array]){
            assert(right_side<s);
            assert(a[right_side]>a[loc_in_array]);
            loc_in_array = right_side;
        }
        assert(loc_in_array==i || loc_in_array==left_side || loc_in_array==right_side);

        if(loc_in_array == i){
            assert(loc_in_array==i);
            assert(compare_array(copy_of_array,a));
            assert(check_max_heap(a));
            return;
        }

        var old_val:Int;
        old_val = a[i];
        a[i] = a[loc_in_array];
        a[loc_in_array] = old_val;
        assert(compare_array(copy_of_array,a));
        MaxHeapify(a,s,loc_in_array);
    }

    /**
     * Helper Function which checks wether the contents of both arrays are the same
     * @param a1 The first array to compare
     * @param a2 The second array to compar
     * @return Bool False if the array's don't contain the same data;True if they do
     */
    static function compare_array(a1:Array<Int>,a2:Array<Int>):Bool{
        for(value in a1){
            if(a2.indexOf(value) == -1){
                return false;
            }
        }
        return true;
    }

    /**
     * Helper function which checks that the array actually does contain a max heap
     * @param a The array to check
     * @return Bool False if the array is not a max heap; True if it is
     */
    static function check_max_heap(a:Array<Int>):Bool{
        var checker:Bool = true;
        var left,right:Int;
        for(runner in 0...a.length){
            left=2*runner+1;
            right=left+1;
            if(left>=a.length){
                break;
            }
            if(right>=a.length){
                break;
            }
            if(runner>=a.length){
                break;
            }
            if(!(a[runner]>=a[left])){
                checker = false;
            }
            if(!(a[runner]>=a[right])){
                checker = false;
            }
        }

        return checker;
    }
    
    /**
     * Entry Point for the program
     */
    static function main(){
        var array = [18,19,36,17,3,2,7,16,1];
        trace(array);
        MaxHeapify(array,array.length,0);
        trace(array);
        array = [1,8,7,6,5,4,3];
        trace(array);
        MaxHeapify(array,array.length,0);
        trace(array);
        array = [8,1,7,6,5,4,3];
        trace(array);
        MaxHeapify(array,array.length,1);
        trace(array);
    }
}