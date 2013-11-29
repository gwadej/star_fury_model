// Utility methods for building star fury model

module nozzle(len,rad)
{
    union() {
        cylinder(h=len,r=rad,center=true);
        translate([0,0,len/2]) sphere(rad);
    }
}

module x_mirrored()
{
    for( i = [ 0:$children-1 ] )
    {
        child( i );
        mirror( [ 1, 0, 0 ] ) child( i );
    }
}
