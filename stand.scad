// File: stand.scad
// Author: G. Wade Johnson
// Copyright: 2013 G. Wade Johnson, Some Rights Reserved.
// Definition of the stand to support the starfury model.

$fn=30;

top_len=43;
top_width=25;
pin_rad=1.5;
pole_height=45;

module assembled_stand()
{
    union()
    {
        stand_main();
        translate( [0, 0, pole_height] ) stand_top();
    }
}

module stand_main()
{
    pole_rad=5;
    top_thick=2;
    union()
    {
        base();
        shaft( pole_height, pole_rad, top_thick, pin_rad );
    }
}

module base() {
    height=6;
    base_thick=2;
    r_base_max=20;
    r_base_min=7;
    union() {
        translate([0,0,base_thick/2]) cylinder(h=base_thick, r=r_base_max, center=true);
        translate([0,0,height-base_thick/2]) cylinder(h=height, r1=r_base_max, r2=r_base_min, center=true);
    }
}

module shaft( pole_height, pole_rad, top_thick, pin_rad ) {
    union() {
        // pole
        translate([0,0,pole_height/2]) cylinder(h=pole_height, r=pole_rad, center=true);
        // pin
        translate([0,0,pole_height]) translate([0,0,1]) cylinder(h=top_thick+1,r=pin_rad,center=true);
    }
}

module stand_top() {
    difference() {
        union() {
            translate([0,-4,1]) cube([10,top_len,2], center=true);
            translate([0,6,1]) cube([top_width,10,2], center=true);
            translate([top_width/2-1,6,4]) cube([2,10,4], center=true);
            translate([-top_width/2+1,6,4]) cube([2,10,4], center=true);
            rail();
            mirror([1,0,0]) rail();
        }
        cylinder( h=10, r=pin_rad+0.4, center=true );
        translate([0,-2,5]) cube([top_width,5,5], center=true);
        translate([0,-20,5]) cube([top_width,5.2,5], center=true);
    }
}

module rail() {
    difference() {
        translate([4,-4,4]) cube([2,top_len,4], center=true);
        translate([6,-4,6]) rotate([0,60,0]) cube([4,top_len+2,4], center=true);
    }
}
