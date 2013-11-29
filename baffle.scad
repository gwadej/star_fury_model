// File: baffle.scad
// Author: G. Wade Johnson
// Copyright: 2013 G. Wade Johnson, Some Rights Reserved.
// Define the baffles that mount on the back of the starfury engines.

$fn=30;
lwidth=18; // Based on engine large radius
llength=37.77; //based on engine length
notch=1;
thickness=1;
flat=7/22*lwidth;
gap=0.4*flat;

slength=56/94*llength;
swidth=0.75*lwidth;

// Create a small and a big baffle pair
//
module baffle_pair() {
    translate([0, 20, 0]) big_baffle();
    small_baffle();
}

// Generic module for creating the shape of the baffles.
//
//  len - length of the baffle
//  wid - width of the baffle
module baffle( len, wid ) {
    groove_offset=flat/2+thickness/2;
    difference() {
        linear_extrude( height=thickness ) polygon(
            points = [
                // front: 0, 1
                [0, -flat/2], [0, flat/2],
                // right: 2:9
                [len*0.149, wid/2], [len*0.17,wid/2], [len*0.17, wid/2-notch], [len*0.457,wid/2-notch], [len*0.457, wid/2], [len*0.564,wid/2], [len*0.878, flat/2], [len, flat/2],
                // back: 10:13
                [len, gap/2], [len*0.564, gap/2], [len*0.564, -gap/2], [len, -gap/2],
                // left: 14:21
                [len, -flat/2], [len*0.878, -flat/2], [len*0.564,-wid/2], [len*0.457, -wid/2], [len*0.457, -wid/2+notch], [len*0.17, -wid/2+notch], [len*0.17, -wid/2], [len*0.149, -wid/2],
            ]
        );
        translate([0,0,0.9*thickness]) rotate([0, 90, 0]) translate([0, groove_offset,len*0.872/2-0.1] ) cube( [thickness, thickness, len*0.872], center=true );
        translate([0,0,0.9*thickness]) rotate([0, 90, 0]) translate([0,-groove_offset,len*0.872/2-0.1] ) cube( [thickness, thickness, len*0.872], center=true );
        translate([len*0.872,0,thickness]) rotate([90,0,0]) cube( [thickness, thickness, wid], center=true );
    }
}

// Create the larger baffle
module big_baffle() {
    rad=1.5;
    union() {
        baffle(llength, lwidth);
        translate([0,0,thickness-0.1]) rib(llength*0.5, rad, 0.75*gap/2);
        translate([llength/6,0,thickness+rad]) rotate([90,0,0]) cylinder(r=rad, h=2*flat/3, center=true);
        translate([llength/6,0,thickness+2*rad]) cube([1,2,1.5], center=true);
    }
}

// Create the smaller baffle
module small_baffle() {
    rad=1;
    union() {
        baffle(slength, swidth);
        translate([0,0,thickness-0.1]) rib(slength*0.5, rad, gap/4);
        translate([slength/6,0,thickness+rad]) rotate([90,0,0]) cylinder(r=rad, h=flat/3, center=true);
        translate([slength/6,0,thickness+2*rad]) cube([1,1.5,1.5], center=true);
    }
}

// Define the support rib that runs down the middle of the baffle.
//
//  len    - length of the rib
//  height - height of the rib
//  thick  - thickness of the rib
module rib(len, height, thick) {
   translate([0,thick/2, 0]) rotate([90,0,0]) linear_extrude(height=thick) polygon(
        points = [
            [0, 0], [len/4, 1.5*height], [len/3, 1.5*height], [len, 0]
        ],
        paths = [ [ 0, 1, 2, 3 ] ]
    );
}

// Generate a version of the small baffle that approximates the look when it is
//  folded.
//  Not printable, but useful for the assembled model.
module folded_small_baffle()
{
    xoff=swidth/2+flat-1.25*thickness;
    union()
    {
        difference()
        {
            small_baffle();
            translate( [ slength/2, -xoff, 0 ] ) rotate( [-30, 0, 0 ] ) cube( [slength, swidth, swidth], center=true );
            translate( [ slength/2, xoff, 0 ] )  rotate( [ 30, 0, 0 ] ) cube( [slength, swidth, swidth], center=true );
            translate( [ 0.93*slength+swidth/2, 0, 0 ] ) rotate( [ 0,-30, 0 ] ) cube( swidth, center=true );
        }
        translate( [0,-0.25,-sin(30)*(flat/2+0.6*thickness)] ) rotate( [-30,0,0] ) intersection()
        {
            small_baffle();
            translate( [ slength/2, -xoff, 0 ] ) rotate( [-30, 0, 0 ] ) cube( [slength, swidth, swidth], center=true );
        }
        translate( [0,0.25,-sin(30)*(flat/2+0.6*thickness)] ) rotate( [30,0,0] ) intersection()
        {
            small_baffle();
            translate( [ slength/2, xoff, 0 ] ) rotate( [30, 0, 0 ] ) cube( [slength, swidth, swidth], center=true );
        }
        translate( [0.2*sin(30)*slength,0,-sin(30)*(0.9*slength)] ) rotate( [0,-30,0] ) intersection()
        {
            small_baffle();
            translate( [ 0.95*slength+swidth/2, 0, 0 ] ) rotate( [ 0,-30, 0 ] ) cube( swidth, center=true );
        }
    }
}

// Generate a version of the big baffle that approximates the look when it is
//  folded.
//  Not printable, but useful for the assembled model.
module folded_big_baffle()
{
    xoff=lwidth/2+flat-0.6*thickness;
    union()
    {
        difference()
        {
            big_baffle();
            translate( [ llength/2, -xoff, 0 ] ) rotate( [-30, 0, 0 ] ) cube( [llength, lwidth, swidth], center=true );
            translate( [ llength/2, xoff, 0 ] )  rotate( [ 30, 0, 0 ] ) cube( [llength, lwidth, swidth], center=true );
            translate( [ 0.93*llength+lwidth/2, 0, 0 ] ) rotate( [ 0,-30, 0 ] ) cube( lwidth, center=true );
        }
        translate( [0,-0.3,-sin(30)*(flat/2+0.9*thickness)] ) rotate( [-30,0,0] ) intersection()
        {
            big_baffle();
            translate( [ llength/2, -xoff, 0 ] ) rotate( [-30, 0, 0 ] ) cube( [llength, lwidth, swidth], center=true );
        }
        translate( [0,0.3,-sin(30)*(flat/2+0.9*thickness)] ) rotate( [30,0,0] ) intersection()
        {
            big_baffle();
            translate( [ llength/2, xoff, 0 ] ) rotate( [30, 0, 0 ] ) cube( [llength, lwidth, swidth], center=true );
        }
        translate( [0.2*sin(30)*llength,0,-sin(30)*(0.91*llength)] ) rotate( [0,-30,0] ) intersection()
        {
            big_baffle();
            translate( [ 0.95*llength+lwidth/2, 0, 0 ] ) rotate( [ 0,-30, 0 ] ) cube( lwidth, center=true );
        }
    }
}
