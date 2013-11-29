// File: side_thruster.scad
// Author: G. Wade Johnson
// Copyright: 2013 G. Wade Johnson, Some Rights Reserved.
// Description of the thruster nozzles on the sides of the starfury engines.

$fn=30;

// nozzle for the thrusters on the sides of the engines
module thruster() {
    noz=0.45;
    cyllen=2.66;
    smrad=2.58;
    lgrad=3.28;
    inner=1.6;
    difference() {
        union() {
            translate([0,0,0]) cylinder(h=noz,r2=smrad,r1=2.25);  // outer bevel
            translate([0,0,noz]) cylinder(h=cyllen,r1=smrad,r2=lgrad);  // main
            translate([0,0,noz+cyllen]) cylinder(h=noz,r1=lgrad,r2=3.2); //inner bevel
            translate([0,0,2*noz+cyllen]) cylinder(h=2.5,r=1.85);  // shaft
        }
        union() {
            cylinder(h=cyllen,r=inner,center=true);
            translate([0,0,cyllen/2]) sphere(inner);
        }
    }
}
