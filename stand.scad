$fn=30;

top_len=43;
top_width=25;
top_thick=2;
pin_rad=1.5;

module base() {
    base_thick=2;
    base_rad=20;
    union() {
        translate([0,0,base_thick/2]) cylinder(h=base_thick, r=base_rad, center=true);
        translate([0,0,5]) cylinder(h=6, r1=base_rad, r2=7, center=true);
    }
}

module shaft() {
    pole_height=45;
    pole_rad=5;
    union() {
        // pole
        translate([0,0,pole_height/2]) cylinder(h=pole_height, r=pole_rad, center=true);
        // pin
        translate([0,0,pole_height]) translate([0,0,1]) cylinder(h=top_thick+1,r=pin_rad,center=true);
    }
}

module top() {
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
