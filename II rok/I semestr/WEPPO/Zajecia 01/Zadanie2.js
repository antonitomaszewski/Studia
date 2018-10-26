function divisible(n, m) {
    return (n%m === 0);
}
function is_ok(n) {
    var s = "" + n;
    var sum = 0;
    var i;
    for (i = 0; i <= s.length-1; i++) {
        var m = parseInt(s.charAt(i));
        if (!divisible(n,m))
            return false;
        sum += m;
    }
    if (!divisible(n,sum))
        return false;
    return true;


}
function setofnaturals(n) {
    let S = new Set();
    var i;
    for (i = 0; i < n; i++)
        if (is_ok(i))
            S.add(i);
    return S;
}
console.log(parseInt("1") + parseInt("2"));

S = setofnaturals(100);
console.log(S);
console.log(!(10%0));