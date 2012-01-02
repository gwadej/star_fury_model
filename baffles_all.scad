$fn=30;
use <baffle.scad>

translate([  5,  10, 0]) baffle_pair();
translate([  5, -35, 0]) baffle_pair();
translate([-40,  10, 0]) baffle_pair();
translate([-40, -35, 0]) baffle_pair();

