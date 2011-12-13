include <utils.scad>
$fn=30;
zscale=56/37;
height=23.73;
width=18;
topwidth=11.45;
bottomwidth=7.57;
middlewidth=4.9;
middleheight=14.73;
topwind=height-middleheight;
mid=45.3;
point=12.02;
depth=mid+point;
offset=3;

barrel_diam=2.5;
flash=3.5;
barrel_len=0.65*depth;

union() {
    body();
    top_guns( barrel_diam, barrel_len, flash );
    translate( [0,-topwind+0.1,0] ) upper_support();

    translate( [7,0.4*middleheight,6] ) fuel_tank();
    translate( [-7,0.4*middleheight,6] ) fuel_tank();
  //  mid_supports( 7, 0.4*middleheight, 5 );
}

module body() {
    off=offset;
    bev=off/2;
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

    union() {
        polyhedron(
            points = [
                [toplt, top, off],   [toprt, top, off],   [midrt, 0, off],     [botrt, bot, off], [botlt, bot, off], [midlt, 0, off],
                [toplt, top, mid],   [toprt, top, mid],   [midrt, 0, midback], [botrt, bot, mid], [botlt, bot, mid], [midlt, 0, midback],
                [frntlt, -1, depth], [frntrt, -1, depth], [frntrt, 1, depth],  [frntlt, 1, depth]
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
                // 0 : 3
                [0, 4, 5], [1, 2, 3], [0, 3, 4], [0, 1, 3], //back
                // 4, 5
                [0, 6, 1], [1, 6, 7],       //top
                // 6, 7
                [6, 0, 5], [6, 5, 11],      //top left
                // 8, 9
                [8, 1, 7], [1, 8, 2],       //top right
                // 10, 11
                [9, 2, 8], [2, 9, 3],       //bottom right
                [10, 3, 9], [3, 10, 4],     //bottom
                [11, 4, 10], [4, 11, 5],    //bottom left
                [11, 10, 6], [9, 8, 7], [10, 9, 6], [9, 7, 6], //back
            ]
        );
    }
}

module upper_support() {
    thickness=-6.48;
    edge=-2;
    length=48.72;
    width=27.67;
    //middle=10.17;
    frontwidth=13.55;
    //frontdip=length-4.27;
    toprear=15.39;
    topfrnt=32.06;
    lead=length-15.39;
    topoff=10.26;
    ftopoff=lead-topoff;
    ridge=12.42;
    difference() {
        polyhedron(
            points = [
                // base: 0 : 5
                [-frontwidth/2, 0, length], [frontwidth/2, 0, length], [width/2, 0, lead], [width/2, 0, 0], [-width/2, 0, 0], [-width/2, 0, lead],
                // front: 6, 7
                [-frontwidth/2, edge, length], [frontwidth/2, edge, length],
                // right: 8 : 10
                [width/2, edge, lead], [width/2, thickness, ftopoff], [width/2, thickness, topoff],
                // rear: 11, 12
                [width/2, edge, 0], [-width/2, edge, 0],
                // left: 13 : 15
                [-width/2, thickness, topoff], [-width/2, thickness, ftopoff], [-width/2, edge, lead],
                // top: 16 : 19
                [-ridge/2, thickness, topfrnt], [ridge/2, thickness, topfrnt], [ridge/2, thickness, toprear], [-ridge/2, thickness, toprear],
            ],
            triangles = [
                // base: 0 : 3
                [1, 0, 2], [2, 0, 5], [5, 4, 3], [5, 3, 2],
                // front: 4, 5
                [1, 7, 6], [6, 0, 1],
                // right,front: 6,7
                [2, 7, 1], [7, 2, 8],
                // right: 8 : 11
                [8, 2, 9], [3, 11, 10], [10, 9, 2], [10, 2, 3],
                // back: 12, 13
                [11, 3, 12], [12, 3, 4],
                // left: 14 : 17
                [4, 5, 13], [13, 12, 4], [5, 14, 13], [5, 15, 14],
                // left,front: 18,19
                [15, 5, 0], [6, 15, 0],
                // top,left: 20 : 24
                [15, 6, 16], [15, 16, 14], [16, 19, 14], [13, 14, 19], [13, 19, 12],
                // top, back: 25, 26
                [19, 18, 12], [12, 18, 11],
                // top,right: 27 : 31
                [11, 18, 10], [10, 18, 9], [9, 18, 17], [9, 17, 8], [8, 17, 7],
                // top, front: 32, 33
                [6, 7, 17], [17, 16, 6],
                // top: 34, 35
                [16, 17, 19], [17, 18, 19],
            ]
        );
        translate([0, 0, 6.78/2+length-2.82]) union() {
            cube( 6.78, center=true );
           translate([2,-1,-(6.78-6.25)/2]) rotate( [0, 18, 0] ) cube( 5, center=true );
           translate([-2,-1,-(6.78-6.25)/2]) rotate( [0, -18, 0] ) cube( 5, center=true );
        }
    }
}

module mid_supports(dx,y,z) {
    thickness=4.09;
    depth=14;
    len=16.5;
    translate( [ dx, y, z] ) rotate( [0, 0, -43] ) translate( [len/4, 0, depth/2] ) cube( [len, thickness, depth], center=true );
    translate( [-dx, y, z] ) rotate( [0, 0, 223] ) translate( [len/4, 0, depth/2] ) cube( [len, thickness, depth], center=true );
}

module fuel_tank() {
    rad=4.5;
    len=0.3*depth;
    translate( [0, 0, rad*zscale+len/2] ) scale( [1, 1, len/rad] ) sphere(rad);
}

module top_guns( diam, len, flash ) {
    xoffset=width/2+diam;
    yoffset=-3*diam/2;
    zoffset=diam/2;

    // forward gun support
    translate( [0, yoffset, len-flash-2*diam] ) cube( [xoffset*2+3*diam/2, 1.25*diam, flash], center=true );
    // rear gun support
    translate( [0, yoffset, 6] ) cube( [xoffset*2+3*diam/2, 1.25*diam, diam], center=true );

    translate( [-xoffset, yoffset, zoffset] ) barrel( diam, len, flash );
    translate( [ xoffset, yoffset, zoffset] ) barrel( diam, len, flash );
}

module barrel(diam,len,flash) {
      difference() {
            union() {
                 cylinder(r=diam/2, h=len);
                 translate( [0, 0, len-(flash+1)] ) cylinder(r=flash/2, h=flash);
                 sphere( r=diam/2 );
           }
           translate( [0, 0, len] ) rotate( [180, 0, 0] ) nozzle( diam, diam/2-0.45 );
     }
}
