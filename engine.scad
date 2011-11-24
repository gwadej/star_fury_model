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
    translate([0,0,mainoffset]) union() {
        cylinder(h=mainlen, r1=eng_rad, r2=4.375);
        translate([-4.375,0,mainlen]) side_nozzle_support();
        rotate([0,0,90]) translate([-4.375,0,mainlen]) side_nozzle_support();
    }
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
        nozzle( rearlen, 3.2 );
    }
}

module side_nozzle_support() {
	translate([-2.756,0,-4.177]) rotate([0,90,0]) difference() {
        union() {
            cylinder(h=4,r1=2.188,r2=2.467);
            translate([0,0,-0.3]) cylinder(h=0.3,r2=2.188,r1=1.915);
            translate([0.25,0,0.561]) scale([1.2,1,1]) intersection() {
                cylinder(h=4,r1=2.1,r2=3.4);
                translate([-5,0,0]) cube([10,10,10], center=true);
            }
            translate([0.25,0,0.561]) intersection() {
                translate([-1,0,0]) cylinder(h=4,r1=2.2,r2=12);
                translate([5,0,0]) cube([10,10,10], center=true);
                translate([0,0,-1.8]) scale([2,0.69,1]) cylinder(h=6,r1=2.2,r2=5);
            }
        }
        translate([0,0,-1]) cylinder(4,r=1.5);
    }
}

module coupler(len,radl,radm,radr) {
    maxr = max(radl,radr);
    union() {
        cylinder(h=len/2,r1=radl,r2=radm );
        translate([0,0,len/2]) cylinder(h=len/2,r1=radm,r2=radr );
        for (i = [0:5])
            rotate(i*60) translate([0,0,-len*0.1]) cube([maxr,1,len*1.2]);
    }
}
module nozzle(len,rad) {
        union() {
            cylinder(h=len,r=rad,center=true);
            translate([0,0,len/2]) sphere(rad);
        }
}
