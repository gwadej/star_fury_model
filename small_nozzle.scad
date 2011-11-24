$fn=30;
noz=0.3;
cyllen=1.774;
smdiam=1.719;
lgdiam=2.188;
inner=1;
difference() {
    union() {
        translate([0,0,0]) cylinder(h=noz,r2=smdiam,r1=1.5);  // outer bevel
        translate([0,0,noz]) cylinder(h=cyllen,r1=smdiam,r2=lgdiam);  // main
        translate([0,0,noz+cyllen]) cylinder(h=noz,r1=lgdiam,r2=2.1); //inner bevel
        translate([0,0,2*noz+cyllen]) cylinder(h=2.5,r=1.2);  // shaft
    }
    union() {
        cylinder(h=cyllen,r=inner,center=true);
        translate([0,0,cyllen/2]) sphere(inner);
    }
}

