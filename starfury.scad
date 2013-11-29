use <baffle.scad>;

plate="baffle";

if( plate == "baffle" )
{
    baffle_pair();
}
if( plate == "all_baffles" )
{
    translate([  5,  10, 0]) baffle_pair();
    translate([  5, -35, 0]) baffle_pair();
    translate([-40,  10, 0]) baffle_pair();
    translate([-40, -35, 0]) baffle_pair();
}
