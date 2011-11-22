$fn=30;
noz=0.3;
cyllen=1.774;
smdiam=1.719;
lgdiam=2.188;
difference() {
    union() {
        translate([0,0,0]) cylinder(h=noz,r2=smdiam,r1=1.6);
        translate([0,0,noz]) cylinder(h=cyllen,r1=smdiam,r2=lgdiam);
        translate([0,0,noz+cyllen]) cylinder(h=noz,r1=lgdiam,r2=2.1);
        translate([0,0,2*noz+cyllen]) cylinder(h=2.5,r=1.2);
    }
    union() {
        cylinder(h=cyllen,r=0.9,center=true);
        translate([0,0,cyllen/2]) sphere(0.9);
    }
}

