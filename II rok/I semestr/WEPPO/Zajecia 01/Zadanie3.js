function sqr(n) {
    return n*n;
}
function isdivisible(n, m) {
    return (n%m === 0);
}
function is_prime(n) {
    if (n < 2)
        return false;
    if (n===2)
        return true;
    if (isdivisible(n,2))
        return false;
    var i=3;
    while (sqr(i) <= n) {
        if (isdivisible(n,i))
            return false;
        i+=2;
    }
    return true;
}
function test(n){
    for (var i = 0; i < n; i++)
        console.log(i, " ", is_prime(i));
}

debugger;
test(10);
// a = (k => {k*k});
// console.log(a(10));
// console.log(sqr(2));
// console.log(is_prime(4));
