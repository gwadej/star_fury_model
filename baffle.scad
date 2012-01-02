$fn=30;
lwidth=18; // Based on engine large radius
llength=37.77; //based on engine length
notch=1;
thickness=1;
flat=7/22*lwidth;
gap=0.4*flat;

slength=56/94*llength;
swidth=0.75*lwidth;

baffle_pair();

module baffle_pair() {
    translate([0, 20, 0]) big_baffle();
    small_baffle();
}

module baffle( len, wid ) {
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
            ],
            paths = [
                [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21]
            ]
        );
        translate([0,0,thickness]) rotate([0, 90, 0]) translate([0, flat/2,len*0.872/2-0.1] ) cube( [thickness, thickness, len*0.872], center=true );
        translate([0,0,thickness]) rotate([0, 90, 0]) translate([0,-flat/2,len*0.872/2-0.1] ) cube( [thickness, thickness, len*0.872], center=true );
        translate([len*0.872,0,thickness]) rotate([90,0,0]) cube( [thickness, thickness, wid], center=true );
    }
}

module big_baffle() {
    rad=1.5;
    union() {
        baffle(llength, lwidth);
        translate([0,0,thickness-0.1]) rib(llength*0.5, rad, 0.75*gap/2);
        translate([llength/6,0,thickness+rad]) rotate([90,0,0]) cylinder(r=rad, h=2*flat/3, center=true);
        translate([llength/6,0,thickness+2*rad]) cube([1,2,1.5], center=true);
    }
}

module small_baffle() {
    rad=1;
    union() {
        baffle(slength, swidth);
        translate([0,0,thickness-0.1]) rib(slength*0.5, rad, gap/4);
        translate([slength/6,0,thickness+rad]) rotate([90,0,0]) cylinder(r=rad, h=flat/3, center=true);
        translate([slength/6,0,thickness+2*rad]) cube([1,1.5,1.5], center=true);
    }
}

module rib(len, height, thick) {
   translate([0,thick/2, 0]) rotate([90,0,0]) linear_extrude(height=thick) polygon(
        points = [
            [0, 0], [len/4, 1.5*height], [len/3, 1.5*height], [len, 0]
        ],
        paths = [ [ 0, 1, 2, 3 ] ]
    );
}
