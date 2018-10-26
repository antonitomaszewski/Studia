function fib(n) {
    if (n < 2)
        return n;
    return fib(n-1) + fib(n-2);
}
function _fib(n) {
    function a(i,b,c) {
        if (i==n)
            return b;
        return a((i+1),(b+c),b);
    }
    return a(1,1,0);
}
function _fib2(n) {
    a = 0;
    b = 1;
    aux = 0;
    while (n!=0) {
        aux = a;
        a = b;
        b += aux;
        n--;
    }
    return a;
}
function _fib3(n) {
    a = 0;
    b = 1;
    aux = 0;
    for (i=0;i<n;i++) {
        aux = a;
        a = b;
        b += aux;
    }
    return a;
}
console.log(fib(6));
console.log(_fib(6));
console.time("rekurencyjne");
console.log(fib(40));
console.timeEnd("rekurencyjne");
console.time("iteracyjne");
console.log(_fib(40));
console.timeEnd("iteracyjne");
console.time("iteracyjne2");
console.log(_fib2(40));
console.timeEnd("iteracyjne2");
console.time("iteracyjne3");
console.log(_fib3(40));
console.timeEnd("iteracyjne3");
