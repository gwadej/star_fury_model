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
    translate( [0,-topwind,0] ) upper_support();

    translate( [7,0.4*middleheight,4] ) fuel_tank();
    translate( [-7,0.4*middleheight,4] ) fuel_tank();
    mid_supports( 7, 0.4*middleheight, 5 );
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

module upper_support() {
    thickness=-6.48;
    length=32.19;
    width=27.67;
    middle=10.17;
    frontwidth=13.55;
    midlength=length-10.17;
    polyhedron(
        points = [
           // 0 : 5
           [-frontwidth/2, 0, length], [-frontwidth/2+2.82,0,length], [-6.78/2,0,length-2.82], [6.78/2,0,length-2.82], [frontwidth/2-2.82,0,length], [frontwidth/2,0,length],
           // 6 : 9
           [width/2,0,midlength], [width/2,0,0], [-width/2,0,0], [-width/2,0,midlength],
           // 10 : 15
           [-frontwidth/2, thickness/8, length], [-frontwidth/2+2.82,thickness/8,length], [-6.78/2,thickness/3,length-2.82], [6.78/2,thickness/3,length-2.82], [frontwidth/2-2.82,thickness/8,length], [frontwidth/2,thickness/8,length],
           // 16 : 19
           [width/2,thickness,midlength], [width/2,thickness,0], [-width/2,thickness,0], [-width/2,thickness,midlength],

        ],
        triangles = [
            [0,1,2], [0,2,9], [9,2,3], [9,3,6], [3,4,5], [3,5,6], [9,6,7], [7,8,9],
            [0,10,1], [10,11,1],
            [1,11,2], [11,12,2],
            [2,12,3], [12,13,3],
            [3,13,4], [13,14,4],
            [4,14,5], [14,15,5],
            [5,15,6], [15,16,6],
            [6,16,7], [16,17,7],
            [7,17,8], [17,18,8],
            [8,18,9], [18,19,9],
            [9,19,0], [19,10,0],
            [12,11,10], [19,12,10], [13,12,19], [16,13,19], [15,14,13], [16,15,13], [17,16,19], [19,18,17]
        ]
    );
}

module mid_supports(dx,y,z) {
    thickness=4.09;
    depth=14;
    len=16.5;
    translate( [dx,y,z] ) rotate( [0,0,-43] ) translate([len/4,0,depth/2]) cube( [len,thickness,depth], center=true );
    translate( [-dx,y,z] ) rotate( [0,0,223] ) translate([len/4,0,depth/2]) cube( [len,thickness,depth], center=true );
}

module fuel_tank() {
    rad=4.5;
    len=0.38*mid;
    translate( [0, 0, rad+len/2] ) scale( [1, 1, len/rad] ) sphere(rad);
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
