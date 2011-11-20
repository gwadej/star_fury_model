$fn=30;
mainlen=21.5;
fwdlen=4.5;
fwdgap=1.75;
rearlen=8.75;
reargap=2;
rearnoz=1;
fwdnoz=0.6;
mainoffset=reargap+rearlen+rearnoz;
fwdoffset=mainlen+mainoffset;
eng_rad=6;

union() {
    forward_assembly();
    main_body();
    rear_assembly(eng_rad);
}

module forward_assembly() {
    translate([0,0,fwdoffset]) difference () {
       union() {
            translate([0,0,fwdgap+fwdlen]) cylinder(h=fwdnoz,r1=3,r2=2.25); //fwd nozzle
            translate([0,0,fwdgap]) cylinder(h=fwdlen,r1=3.75,r2=3); // fwd cyl
            coupler(len=fwdgap,radl=4.375,radm=3.375,radr=3.75);
        }
        translate([0,0,fwdlen+fwdgap]) rotate([0,180,0]) nozzle(fwdlen,2);
    }
}
module main_body() {
    translate([0,0,mainoffset]) cylinder(h=mainlen, r1=eng_rad, r2=4.375);
}
module rear_assembly(cylbig) {
    cylsmall=5;
    pinch=4;
    difference() {
        union() {
            translate([0,0,rearlen+rearnoz]) coupler(len=reargap,radl=cylbig,radm=pinch,radr=cylbig);
            translate([0,0,rearnoz]) cylinder(h=rearlen,r1=cylsmall,r2=cylbig); //rear cyl
            translate([0,0,0]) cylinder(h=rearnoz,r1=pinch,r2=cylsmall); //rear nozzle
        }
        nozzle( rearlen, 3.8 );
    }
}

module coupler(len,radl,radm,radr) {
    maxr = max(radl,radr);
    union() {
        cylinder(h=len/2,r1=radl,r2=radm );
        translate([0,0,len/2]) cylinder(h=len/2,r1=radm,r2=radr );
//        for (i = [0:5])
//            rotate(i*60) translate([radm,0,-len*0.1]) cube([maxr-radm,0.4,len*1.2]);
    }
}
module nozzle(len,rad) {
        union() {
            cylinder(h=len,r1=rad,r2=rad,center=true);
            translate([0,0,len/2]) sphere(rad);
        }
}