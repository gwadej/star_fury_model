$fn=30;
noz=0.45;
cyllen=2.66;
smdiam=2.58;
lgdiam=3.28;
inner=1.6;
difference() {
    union() {
        translate([0,0,0]) cylinder(h=noz,r2=smdiam,r1=2.25);  // outer bevel
        translate([0,0,noz]) cylinder(h=cyllen,r1=smdiam,r2=lgdiam);  // main
        translate([0,0,noz+cyllen]) cylinder(h=noz,r1=lgdiam,r2=3.2); //inner bevel
        translate([0,0,2*noz+cyllen]) cylinder(h=3.75,r=1.8);  // shaft
    }
    union() {
        cylinder(h=cyllen,r=inner,center=true);
        translate([0,0,cyllen/2]) sphere(inner);
    }
}

