// File: engine.scad
// Author: G. Wade Johnson
// Copyright: 2013 G. Wade Johnson, Some Rights Reserved.
// Definition for the starfury engines.

use <utils.scad>

$fn=30;
mainlen=32.25;
fwdlen=6.75;
fwdgap=2.6;
rearlen=13;
reargap=3;
rearnoz=1.5;
fwdnoz=1;
mainoffset=reargap+rearlen+rearnoz;
fwdoffset=mainlen+mainoffset;
eng_rad=9;
eng_smrad=6.6;
tip_len=30.3;
tip_thick=4.32;
mount_edge=2;

topoff=10.26;
mount_width=34.89;
adj=mount_width*(sin(28)-sin(34));

// Combine the parts of the engine assembly into a single model.
module engine() {
    difference() {
        union() {
            forward_assembly();
            engine_body();
            rear_assembly(eng_rad);
            translate([-0.44*eng_smrad,1.8,mainoffset]) rotate( [0,-90,-90-23] ) mirror([0,1,0]) mount();
        }
        rotate([0,0,-23]) translate([0,-9,9.5]) rotate([90,0,0]) cube( [2.5,1.5,5], center=true );
        rotate([0,0,-23]) translate([0,9,10]) rotate([90,0,0]) cube( [1.75,1.5,5], center=true );
    }
}

// Define the forward portion of the engine assembly
module forward_assembly() {
    bevel=3.4;
    fwd_sm=4.5;
    fwd_lg=5.8;
    fwd_pinch=5.1;
    translate( [0,0,fwdoffset] ) difference() {
       union() {
            translate( [0,0,fwdgap+fwdlen] ) cylinder( h=fwdnoz, r1=fwd_sm, r2=bevel ); //fwd nozzle
            translate( [0,0,fwdgap] ) cylinder( h=fwdlen, r1=fwd_lg, r2=fwd_sm ); // fwd cyl
            coupler( len=fwdgap, radl=eng_smrad, radm=fwd_pinch, radr=fwd_lg );
        }
        translate( [0,0,fwdlen+fwdgap] ) rotate( [0,180,0] ) nozzle( fwdlen, 3 );
    }
}

// Define the core portion of the engine assembly
module engine_body() {
    translate( [0,0,mainoffset] ) union() {
        cylinder( h=mainlen, r1=eng_rad, r2=eng_smrad );
        translate( [-eng_smrad,0,mainlen] ) side_nozzle_support();
        rotate( [0,0,90] ) translate( [-eng_smrad,0,mainlen] ) side_nozzle_support();
    }
}

// Define the rear structure of the engine.
//
//  cylbig - the larger radius of the rear assembly.
module rear_assembly( cylbig ) {
    cylsmall=7.5;
    pinch=6;
    difference() {
        union() {
            translate([0,0,rearlen+rearnoz]) coupler(len=reargap,radl=cylbig,radm=pinch,radr=cylbig);
            translate([0,0,rearnoz]) cylinder(h=rearlen,r1=cylsmall,r2=cylbig); //rear cyl
            translate([0,0,0]) cylinder(h=rearnoz,r1=pinch,r2=cylsmall); //rear nozzle
        }
        nozzle( rearlen, 5.5 );
    }
}

// Define the structure where the thruster nozzle will mount to the engine.
module side_nozzle_support() {
	translate([-4.2,0,-6.3]) rotate([0,90,0]) difference() {
        union() {
            cylinder(h=6,r1=3.3,r2=3.7);
            translate([0,0,-0.45]) cylinder(h=0.45,r2=3.3,r1=2.9); //bezel
            translate([0.4,0,0.3]) scale([1.2,1,1]) intersection() {
                cylinder(h=6,r1=3.15,r2=5.1);
                translate([-7.5,0,0]) cube([15,15,15], center=true);
            }
            translate([0.4,0,0.3]) intersection() {
                translate([-1.5,0,0]) cylinder(h=6,r1=3.3,r2=18);
                translate([7.5,0,0]) cube([15,15,15], center=true);
                translate([0,0,-2.7]) scale([2,0.69,1]) cylinder(h=9,r1=3.3,r2=7.5);
            }
        }
        translate([0,0,-1.5]) cylinder(h=4,r=2.25);
    }
}

// Define the connector between different sections of the engine.
//
//  len - length of the coupling
//  radl - radius of the larger part
//  radm - radius of the center of the coupling
//  radr - radius of the smaller part
module coupler(len,radl,radm,radr) {
    maxr = max(radl,radr);
    union() {
        cylinder(h=len/2,r1=radl,r2=radm );
        translate([0,0,len/2]) cylinder(h=len/2,r1=radm,r2=radr );
        for (i = [0:5])
            rotate(i*60) translate([0,0,-len*0.1]) cube([maxr,1,len*1.2]);
    }
}

// Define the connector between the engine and the mounting strut.
module mount() {
    depth=8;
    union() {
        translate( [tip_len+adj, 0, 0] )
        rotate([-90,0,0])
        linear_extrude( height=mount_edge ) polygon(
            points = [
                [0, 0], [0.65*depth,-0.35*depth], [0, -depth]
            ],
            paths = [ [0, 1, 2] ]
        );
        linear_extrude( height=depth ) polygon(
            points = [
                [0, 0],
                [0, mount_edge],
                [topoff, tip_thick],
                [tip_len-topoff+adj, tip_thick],
                [tip_len+adj, mount_edge],
                [tip_len+adj, 0]
            ]
        );
    }
}
