trait Stack{

    ghost var stack: array<int>;
    
    predicate Invariant()
    reads this
    {
        stack.Length >= 0
    }

    method Push(x:int)
    requires Invariant()
    ensures Invariant()
    ensures x in stack[..]

    method Pop()
    requires Invariant()
    requires stack.Length >= 1
    ensures Invariant()
    ensures stack.Length == old(stack).Length-1


    method Top() returns(y:int)
    requires Invariant()
    requires stack.Length >= 1
    ensures Invariant()
    ensures y==stack[stack.Length-1]

    method Depth() returns(d:int)
    requires Invariant()
    ensures Invariant()
    ensures d == stack.Length
}