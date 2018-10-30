import Assertion.*;
/**
 * The implementation of the class described in Question 1a.
 * The requires,ensures, and Invariant in use in the Dafny trait 
 * replaced with asserts using the Assertion library.
 * 
 * The linking invariant in this case is stack.Length >= 0
 * 
 */
class My_Stack{

    var stack = new Array<Int>();

    public function new(){
        
    }

    inline function Invariant(){
        assert(stack.length>=0);
    }

    public function Push(x:Int){
        Invariant();
        stack.push(x);
        assert(stack.indexOf(x)!=-1);
        Invariant();
    }

    public function Pop(){
        Invariant();
        var old_length = stack.length;
        assert(stack.length>=1);
        if(stack.length>0){
            stack.pop();
        }
        assert(stack.length==old_length-1);
        Invariant();
    }

    public function Top():Int{
        Invariant();
        assert(stack.length>=1);
        var holder = 0;
        if(stack.length>0){
            holder = stack[stack.length-1];
        }
        assert(holder == stack[stack.length-1]);
        Invariant();
        return holder;
    }

    public function Depth():Int{
        Invariant();
        var d = stack.length;
        assert(d==stack.length);
        Invariant();
        return d;
    }

}

/**
 * Class used to test My_Stack checking the asserts function
 * and prevent the code from running.
 * 
 */
class Question1b{

    /**
     * Entry point of the program
     * 
     */
    static function main(){
        var test_stack = new My_Stack();
        test_stack.Push(2);
        test_stack.Push(1);
        trace(test_stack.Top());
        test_stack.Pop();
        trace(test_stack.Top());
        //Used to test assertions 
        //test_stack.Pop();
        //trace(test_stack.Top());
        //test_stack.Pop();
        //trace(test_stack.Top());


    }
    
}