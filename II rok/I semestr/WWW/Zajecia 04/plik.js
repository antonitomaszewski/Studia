function f(a) {
    return arguments;
}
console.log(f(1,2));
function add() { console.log(arguments.length); }
add(1,3);
function multiply(multiplier, ...theArgs) {
    return theArgs.map(x => multiplier * x);
    }
var arr = multiply(2, 1, 2, 3);
console.log(arr);
"use strict";
a = 4;
console.log(a);
person = {
    imie : "Jan", 
    nazwisko : "Kowalski",
    adres : { ulica: "Mala 7", miasto: "Wroclaw" },
    stan : ["wolny", "niewolny"],
    pokaz : function() { alert(imie+" "+nazwisko); }
    };