// Main driver file for the creation of the Star Fury Model
use <baffle.scad>;
use <engine.scad>;
use <side_thruster.scad>;
use <body.scad>;
use <stand.scad>;
use <struts.scad>;

plate="struts";

if( plate == "baffle" )
{
    baffle_pair();
}
if( plate == "baffles_all" )
{
    translate([  5,  10, 0]) baffle_pair();
    translate([  5, -35, 0]) baffle_pair();
    translate([-40,  10, 0]) baffle_pair();
    translate([-40, -35, 0]) baffle_pair();
}
if( plate == "body" )
{
    complete_body();
}
if( plate == "engine" )
{
    engine();
}
if( plate == "engines4" )
{
    translate( [-20, -20, 0] ) engine();
    translate( [ 20, -20, 0] ) mirror( [1, 0, 0] ) engine();

    translate( [-20,  20, 0] ) engine();
    translate( [ 20,  20, 0] ) mirror( [1, 0, 0] ) engine();
}
if( plate == "stand" )
{
    translate([25,0,0]) union() {
        base();
        shaft();
    }
    translate([-15,0,0]) top();
}
if( plate == "struts" )
{
    all_struts();
}
if( plate == "thrusters" )
{
    for( x = [-30, -10, 10, 30] )
    {
        translate( [x, -10, 0] ) thruster();
        translate( [x,  10, 0] ) thruster();
    }
}
