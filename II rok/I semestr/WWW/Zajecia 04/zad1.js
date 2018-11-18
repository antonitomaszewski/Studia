document.body.innerHTML += '<div id="menu"> to jest div o id=menu </div>';
var men = document.getElementById("menu");
men.style.cssText = "width: 190px; height: 100px;";
document.getElementById("menu").style.border = "5px solid blue";

function funa(id) {
  document.getElementById("menu").style.borderColor = "red";
}
var linka = '<a id="r" href="plik.jpg" onclick="funa(this)" target="_blank"> czerwień</a>';

function funb(id) {
  document.getElementById("menu").style.borderColor = "green";
}
var linkb = '<a id="g" href="plik.jpg" onclick="funb(this)" target="_blank"> zieleń</a>';

function func(id) {
  document.getElementById("menu").style.borderColor = "brown";
}
var linkc = '<a id="b" href="" onclick="func(this)" target="_blank"> brąz</a>';

document.getElementById("menu").innerHTML += linka + linkb + linkc;
document.getElementById("r").style.color = "red";
document.getElementById("b").style.color = "green";
document.getElementById("g").style.color = "brown";
