// File: utils.scad
// Author: G. Wade Johnson
// Copyright: 2013 G. Wade Johnson, Some Rights Reserved.
// Utility methods for building star fury model

module nozzle(len,rad)
{
    union() {
        cylinder(h=len,r=rad,center=true);
        translate([0,0,len/2]) sphere(rad);
    }
}

// Mirror all of the children of this module around the x axis.
module x_mirrored()
{
    for( i = [ 0:$children-1 ] )
    {
        child( i );
        mirror( [ 1, 0, 0 ] ) child( i );
    }
}
