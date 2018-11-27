var objekt = (() => {
  var pub = {
    setPrivVal: function(x) {
      privVal = x;
      return;
    },
    getPrivVal: function() {
      return privVal;
    },
    pubVal: "Antoni"
  };

  var privVal = "Tomaszewski";

  function privFun(i) {
    var privVal = 2 * i;
    pub.pubVal = 2 * privVal;
  }

  return pub;
})();

console.log(objekt);

console.log(objekt.pubVal);
console.log(objekt.getPrivVal());
objekt.setPrivVal(17);
console.log(objekt.getPrivVal());
console.log(objekt.privVal);
console.log(objekt.privFun);