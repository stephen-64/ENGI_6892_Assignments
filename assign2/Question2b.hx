/**
 * Non recursive implementation of Question2a
 */
class Question2b{

    static function MaxHeapify(a:Array<Int>,s:Int,i:Int){
        var loc_in_array,left_side,right_side : Int;
        while(i<s){
            loc_in_array = i;
            left_side = 2*i+1;
            right_side = 2*i+2;
            if(left_side <s  && a[left_side]>a[loc_in_array]){
                loc_in_array = left_side;
            }

            if(right_side<s && a[right_side]>a[loc_in_array]){
                loc_in_array = right_side;
            }

            if(loc_in_array == i){
                return;
            }

            var old_val = a[i];
            a[i]=a[loc_in_array];
            a[loc_in_array] = old_val;

            i = loc_in_array;

        }
    }
    
    /**
     * Entry Point for the program with a small test
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