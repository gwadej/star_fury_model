$fn=30;
mainlen=17.2;
fwdlen=3.6;
fwdgap=1.4;
rearlen=7;
reargap=1.6;
rearnoz=0.8;
mainoffset=reargap+rearlen+rearnoz;
fwdoffset=mainlen+mainoffset;

union() {
    forward_assembly();
    main_body();
    rear_assembly();
}

module forward_assembly() {
    translate([0,0,fwdoffset]) difference () {
        union() {
            translate([0,0,fwdgap+fwdlen]) cylinder(h=0.6,r1=2.5,r2=1.8); //fwd nozzle
            translate([0,0,fwdgap]) cylinder(h=fwdlen,r1=3,r2=2.5); // fwd cyl
            coupler(len=fwdgap,radl=3.5,radm=2.7,radr=3);
        }
        translate([0,0,fwdlen/2+fwdgap]) union() {
            cylinder(h=fwdlen,r1=1.6,r2=1.6);
            sphere(r=1.6);
        }
    }
}
module main_body() {
    translate([0,0,mainoffset]) cylinder(h=mainlen, r1=4.9, r2=3.5);
}
module rear_assembly() {
    difference() {
        union() {
            translate([0,0,rearlen+rearnoz]) coupler(len=reargap,radl=4.9,radm=3.3,radr=4.9);
            translate([0,0,rearnoz]) cylinder(h=rearlen,r1=4.1,r2=4.9); //rear cyl
            translate([0,0,0]) cylinder(h=rearnoz,r1=3.3,r2=4.1); //rear nozzle
        }
        union() {
            cylinder(h=rearlen,r1=3.1,r2=3.1,center=true);
            translate([0,0,rearlen/2]) sphere(3.1);
        }
    }
}
module coupler(len,radl,radm,radr) {
      union() {
             cylinder(h=len/2,r1=radl,r2=radm );
             translate([0,0,len/2]) cylinder(h=len/2,r1=radm,r2=radr );
      }
}
