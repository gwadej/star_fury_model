rotate([0,-90,0]) cylinder(h=2*8.6, r1=3.5, r2=4.9, $fn=30);
translate([2.4*2,0,0]) rotate([0,-90,0]) cylinder(h=2*1.8,r1=2.5,r2=3,$fn=30);
translate([2.7*2,0,0]) rotate([0,-90,0]) cylinder(h=0.6,r1=1.8,r2=2.5);
translate([1.4,0,0]) coupler(len=1.4,radl=3,radm=2.7,radr=3.5);
translate([-2*9.4,0,0]) rotate([0,-90,0]) cylinder(h=2*3.5,r1=4.9,r2=4.1, $fn=30);
translate([-2*8.6,0,0]) coupler(len=1.6,radl=4.9,radm=3.3,radr=4.9);

translate([-2*9.4-2*3.5,0,0]) rotate([0,-90,0]) cylinder(h=0.8,r1=4.1,r2=3.3);

module coupler(len,radl,radm,radr) {
      rotate([0,-90,0]) union() {
             cylinder(h=len/2,r1=radl,r2=radm );
             translate([0,0,len/2]) cylinder(h=len/2,r1=radm,r2=radr );
      }
}