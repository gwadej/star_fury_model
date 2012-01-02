$fn=30;

use <body.scad>

offset=45.3-12.3/2 -2;  //midback -2
height=20;
thick=1;
top_angle=57;
middlewidth=4.9;
tl_angle1=70;

difference() {
    intersection() {
        translate([0,0,-offset]) body();
        translate([0,0,height/2]) cube([24,24,height],center=true );
    }
    translate( [0,-2*thick*sin(top_angle),height-thick*cos(top_angle)] )
        rotate([top_angle,0,0]) top_front_pane();
    top_left_pane();
    mirror([1,0,0]) top_left_pane();
}


module top_left_pane() {
    translate( [middlewidth/2+thick*sin(7),-1,height-1.5*thick*cos(tl_angle1)] )
        rotate([0,0,-7]) rotate([0,tl_angle1,0]) top_side_pane();
}

module top_front_pane() {
    topwid=11-2;
    botwid=5.5-2;
    len=15-2;
    translate([0,0,-thick/2]) linear_extrude(height=thick) polygon(
        points= [
            [-topwid/2,-len],
            [topwid/2,-len],
            [botwid/2,0],
            [-botwid/2,0]
        ],
        paths = [ [ 0,1,2,3] ]
    );
}

module top_side_pane() {
    length=19-2;
    mid=5;
    height=8.5-2;
    translate([0,0,-thick/2]) linear_extrude(height=thick) polygon(
        points = [
            [0,0], [length,0], [length-mid,-height],
        ],
        paths = [ [0,1,2] ]
    );
}
