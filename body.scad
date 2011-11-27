include <utils.scad>
$fn=30;
height=23.73;
width=18;
topwidth=11.45;
bottomwidth=7.57;
middlewidth=4.9;
middleheight=14.73;
topwind=height-middleheight;
mid=29.93;
point=7.94;
depth=mid+point;

toplt=-topwidth/2;
toprt=topwidth/2;
midlt=-width/2;
midrt=width/2;
botlt=-bottomwidth/2;
botrt=bottomwidth/2;
top=-topwind;
midback=mid-point/2;
bot=middleheight;
frntlt=-middlewidth/2;
frntrt=middlewidth/2;

barrel_diam=2.5;
flash=3.5;
barrel_len=(depth+barrel_diam)/2;
barrel_xoffset=width/2+barrel_diam;
barrel_yoffset=-3*barrel_diam/2;
barrel_zoffset=barrel_diam/2;

union() {
    body();
    top_guns();
}

module body() {
    off=2;
    bev=off/2;
    union() {
        polyhedron(
            points = [
                [toplt, top, off],   [toprt, top, off],   [midrt, 0, off],       [botrt, bot, off],   [botlt, bot, off],   [midlt, 0, off],
                [toplt, top, mid], [toprt, top, mid], [midrt, 0, midback], [botrt, bot, mid], [botlt, bot, mid], [midlt, 0, midback],
                [frntlt, -1, depth], [frntrt, -1, depth], [frntrt, 1, depth], [frntlt, 1, depth]
            ],
            triangles = [
                [0, 4, 5], [1, 2, 3], [0, 3, 4], [0, 1, 3], //back
                [0, 6, 1], [1, 6, 7],       //top
                [6, 0, 5], [6, 5, 11],      //top left
                [8, 1, 7], [1, 8, 2],       //top right
                [9, 2, 8], [2, 9, 3],       //bottom right
                [10, 3, 9], [3, 10, 4],     //bottom
                [11, 4, 10], [4, 11, 5],    //bottom left
                [15, 11, 10], [15, 12, 11], [11, 12, 6],    //front left
                [12, 7, 6], [13, 7, 12],    // front top
                [12, 14, 13], [15, 14, 12], //front
                [13, 8, 7], [8, 13, 14], [14, 9, 8],        //front right
                [14, 10, 9], [15, 10, 14]   // front bottom
            ]
        );
        polyhedron(
            points = [
                [toplt, top, off],   [toprt, top, off],   [midrt, 0, off],       [botrt, bot, off],   [botlt, bot, off],   [midlt, 0, off],
                [toplt+bev, top+bev, 0], [toprt-bev, top+bev, 0], [midrt-bev, 0, 0], [botrt-bev, bot-bev, 0], [botlt+bev, bot-bev, 0], [midlt+bev, 0, 0],
            ],
            triangles = [
                [0, 4, 5], [1, 2, 3], [0, 3, 4], [0, 1, 3], //back
                [0, 6, 1], [1, 6, 7],       //top
                [6, 0, 5], [6, 5, 11],      //top left
                [8, 1, 7], [1, 8, 2],       //top right
                [9, 2, 8], [2, 9, 3],       //bottom right
                [10, 3, 9], [3, 10, 4],     //bottom
                [11, 4, 10], [4, 11, 5],    //bottom left
                [11, 10, 6], [9, 8, 7], [10, 9, 6], [9, 7, 6], //back
            ]
        );
    }
}

module top_guns() {
    // forward gun support
    translate( [0, barrel_yoffset, barrel_len-flash-barrel_diam] ) cube( [barrel_xoffset*2+3*barrel_diam/2, 1.25*barrel_diam, flash],center=true );
    // rear gun support
    translate( [0, barrel_yoffset, 2*barrel_diam] ) cube( [barrel_xoffset*2+3*barrel_diam/2, 1.25*barrel_diam, barrel_diam],center=true );

    translate( [-barrel_xoffset,barrel_yoffset,barrel_zoffset] ) barrel();
    translate( [barrel_xoffset,barrel_yoffset,barrel_zoffset] ) barrel();
}

module barrel() {
      difference() {
            union() {
                 cylinder(r=barrel_diam/2, h=barrel_len);
                 translate( [0,0,barrel_len-flash-1] ) cylinder(r=flash/2, h=flash);
                 sphere( r=barrel_diam/2 );
           }
           translate([0,0,barrel_len]) rotate([180,0,0]) nozzle( 3, 0.8 );
     }
}
