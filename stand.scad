$fn=30;

base_rad=20;
pole_height=50;
pole_rad=5;
pin_rad=1.5;

translate([25,0,0]) union() {
    translate([0,0,1]) cylinder(h=2, r=base_rad, center=true);
    translate([0,0,5]) cylinder(h=6, r1=base_rad, r2=7, center=true);
    difference() {
        translate([0,0,pole_height/2]) cylinder(h=pole_height, r=pole_rad, center=true);
        translate([0,0,pole_height]) rotate([10,0,0]) cube([pole_rad*4, pole_rad*4,10], center=true );
    }
    translate([0,0,pole_height-pole_rad]) rotate([10,0,0]) translate([0,0,1]) cylinder(h=4,r=pin_rad,center=true);
}

translate([-15,0,0]) difference() {
    union() {
        translate([0,0,1.5]) cube([25, 45, 3], center=true);
        translate([ 5.5,0,4]) cube([5,45,4], center=true);
        translate([-5.5,0,4]) cube([5,45,4], center=true);
        translate([0,45/2-1.5,6]) cube([10,3,8], center=true);
    }
    cylinder( h=10, r=pin_rad+0.25, center=true );
}
