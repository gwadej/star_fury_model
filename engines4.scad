use <engine.scad>
$fn=30;

translate( [-20, -20, 0] ) engine();
translate( [ 20, -20, 0] ) mirror( [1, 0, 0] ) engine();

translate( [-20,  20, 0] ) engine();
translate( [ 20,  20, 0] ) mirror( [1, 0, 0] ) engine();
