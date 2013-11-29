use <baffle.scad>;
use <engine.scad>;

plate="baffle";

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
