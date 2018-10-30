method array_sort(a: array<int>)
modifies a
ensures a.Length == old(a.Length)
requires a.Length >= 2
ensures check_sort(a)
ensures forall i::0<=i<a.Length ==> a[i] in old(a[..])
{
    var len :int := a.Length;
    var i :int := 0;
    while i<len-1
    invariant 0<=i<=len-1
    invariant forall i::0<=i<a.Length ==> a[i] in old(a[..])
    decreases len-1 - i
    {
        var min : int := i;
        var j : int :=i+1;
        while j<len
        invariant 0<=min < len
        invariant 0<= j <= len
        decreases len - j
        {
            if (a[i]<a[min]){
                min := j;
            }
            j:=j+1;
        }
        if(i!=min){
            assert sortedsubset(a,min-1);
            swap_pos(a,i,min);
        }
        i:=i+1;
    }
}

method swap_pos(a:array<int>,i:int,j:int)
requires 0<=j<a.Length
requires 0<=i<a.Length
requires i<j
requires sortedsubset(a,j-1)
ensures  sortedsubset(a,j)
ensures forall i::0<=i<a.Length ==> a[i] in old(a[..])
modifies a
{
    assert(sortedsubset(a,j-1));
    var temp:int := a[i];
    if(temp<a[i]){
        a[i]:=a[j];
        a[j]:=temp;
        assert(a[i]in old(a[..]));
        assert(a[j]in old(a[..]));
        assert (a[i]<a[j]);
        assert(sortedsubset(a,j));
    }


}

// Taken from Notes
predicate check_sort(a:array<int>)
reads a
{
    forall i,j::0<=i<=j<a.Length ==> a[i]<=a[j]
}

predicate sortedsubset(a:array<int>,j:int)
requires j<a.Length
reads a
{
    forall i,k::0<=i<=k<=j ==> a[i]<=a[k]
}