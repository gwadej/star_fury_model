// File: body.scad
// Author: G. Wade Johnson
// Copyright: 2013 G. Wade Johnson, Some Rights Reserved.
// Design file for the core of the starfury body.

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

// cockpit
thick=1;
tl_angle1=70;
cockpit_height=20;

function upper_gun_xoff(diam)=width/2+diam;
function upper_gun_yoff(diam)=-1.5*diam;
function upper_gun_zoff(diam)=4;

function lower_gun_xoff(diam)=bottomwidth/2+1.5*diam;
function lower_gun_yoff(diam)=middleheight;
function lower_gun_zoff(diam)=3.5*diam;

module complete_body()
{
    diam=barrel_diam;
    union()
    {
        main_body();
        // Add in the gun supports.
        for( x = [ -upper_gun_xoff( diam ), upper_gun_xoff( diam ) ] )
            translate( [ x, upper_gun_yoff( diam ), 0 ] )
                upper_gun_support( upper_gun_zoff( diam ), diam );
        for( x = [ -lower_gun_xoff( diam ), lower_gun_xoff( diam ) ] )
            translate( [ x, lower_gun_yoff( diam ), 0 ] )
                lower_gun_support( lower_gun_zoff( diam ), diam );
    }
}


module assembled_body()
{
    rotate( [-90, 0, 180 ] ) translate( [0, -(middleheight+bottomwidth/2), -mid/2 ] ) main_body();
}

module main_body()
{
    union() {
        body();
        top_guns( barrel_diam, barrel_len, flash );
        translate( [0,-topwind+0.1,0] ) upper_support();

        translate( [7,0.4*middleheight,6] ) fuel_tank();
        translate( [-7,0.4*middleheight,6] ) fuel_tank();
        undercarriage( barrel_diam, mid+point/2, flash );
        translate( [0,0.6*middleheight,0] ) lower_support();
    }
}

module body () {
    midback=mid-point/2;
    offset=midback -2;
    top_angle=57;
    bot_angle=41;
    middlewidth=4.9;

    difference() {
        body_base(midback);
        translate([0,0,offset]) union() {
            translate( [0,0,cockpit_height+1.5] ) rotate([top_angle,0,0]) top_center_pane();
            top_left_pane();
            mirror([1,0,0]) top_left_pane();
            translate( [0,0,cockpit_height+0.9] ) rotate([-bot_angle,0,0]) bottom_center_pane();
            bottom_left_pane();
            mirror([1,0,0]) bottom_left_pane();
        }
    }
}

module body_base(midback) {
    off=offset;
    bev=off/2;
    toplt=-topwidth/2;
    toprt=topwidth/2;
    midlt=-width/2;
    midrt=width/2;
    botlt=-bottomwidth/2;
    botrt=bottomwidth/2;
    top=-topwind;
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
    thickness=6.48;
    edge=2;
    gap=6.78;
    length=48.72;
    width=27.67;
    frontwidth=13.55;
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
                [-frontwidth/2, 0, length], [frontwidth/2, 0, length], [width/2+thickness*sin(11.5), 0, lead], [width/2+thickness*sin(11.5), 0, 0], [-width/2-thickness*sin(11.5), 0, 0], [-width/2-thickness*sin(11.5), 0, lead],
                // front: 6, 7
                [-frontwidth/2, -edge, length], [frontwidth/2, -edge, length],
                // right: 8 : 10
                [width/2+(thickness-edge)*sin(11.5), -edge, lead], [width/2, -thickness, ftopoff], [width/2, -thickness, topoff],
                // rear: 11, 12
                [width/2+(thickness-edge)*sin(11.5), -edge, 0], [-width/2-(thickness-edge)*sin(11.5), -edge, 0],
                // left: 13 : 15
                [-width/2, -thickness, topoff], [-width/2, -thickness, ftopoff], [-width/2-(thickness-edge)*sin(11.5), -edge, lead],
                // top: 16 : 19
                [-ridge/2, -thickness, topfrnt], [ridge/2, -thickness, topfrnt], [ridge/2, -thickness, toprear], [-ridge/2, -thickness, toprear],
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
        translate([0, 0, gap/2+length-2.82]) union() {
            cube( gap, center=true );
           translate([2,-1,-(gap-6.25)/2]) rotate( [0, 18, 0] ) cube( 5, center=true );
           translate([-2,-1,-(gap-6.25)/2]) rotate( [0, -18, 0] ) cube( 5, center=true );
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
    xoffset=upper_gun_xoff( diam );
    yoffset=upper_gun_yoff( diam );
    zoffset=upper_gun_zoff( diam );

    // forward gun support
    translate( [0, yoffset, len-flash-1.5*diam] ) cube( [xoffset*2+3*diam/2, 1.25*diam, 2*diam], center=true );
    // rear gun support
    translate( [0, yoffset, 6] ) cube( [xoffset*2+3*diam/2, 1.6*diam, diam], center=true );

    translate( [-xoffset, yoffset, 0] )
        translate( [0, 0, zoffset] ) barrel( diam, len, flash,1.5*diam );
    translate( [ xoffset, yoffset, 0] )
        translate( [ 0, 0, zoffset] ) barrel( diam, len, flash, 1.5*diam );
}

module upper_gun_support( zoff, diam )
{
    cylinder( h=zoff-0.75*diam, r1=1.5*diam, r2=0.2 );
}

module lower_guns( diam, body_len, flash ) {
    xoffset=lower_gun_xoff( diam );
    yoffset=lower_gun_yoff( diam );
    zoffset=lower_gun_zoff( diam );
    len=body_len-3*diam;

    // forward gun support
    translate( [0, yoffset, len-flash] ) cube( [xoffset*2+3*diam/2, 1.25*diam, 2*diam], center=true );
    // rear gun support
    translate( [0, yoffset, len/2] ) cube( [xoffset*2+2*diam, 2*diam, 2*diam], center=true );
    translate( [-xoffset, yoffset, 0] )
        translate( [0, 0, zoffset] ) barrel( diam, len, flash, 2*diam );
    translate( [ xoffset, yoffset, 0] )
        translate( [ 0, 0, zoffset] ) barrel( diam, len, flash, 2*diam );
}

module lower_gun_support( zoff, diam )
{
    cylinder( h=zoff-diam, r1=1.25*diam, r2=0.2 );
}

module undercarriage( diam, len, flash ) {
    xoffset=-3*bottomwidth/8;
    yoffset=middleheight-bottomwidth/4;
    union () {
        lower_guns( diam, len, flash );
        difference() {
            translate([xoffset,yoffset,0]) cube( [0.75*bottomwidth, 0.75*bottomwidth, mid] );
            translate( [-bottomwidth/2,yoffset+bottomwidth/4,-bottomwidth] ) rotate([45,0,0]) cube([bottomwidth,2*bottomwidth,bottomwidth]);
            translate( [-bottomwidth/2,yoffset+bottomwidth/8,mid] ) rotate([-45,0,0]) cube([bottomwidth,2*bottomwidth,bottomwidth]);
        }
    }
}

module lower_support() {
    thickness=6.48;
    edge=2;
    gap=6.78;
    length=43;
    width=27.67;
    frontwidth=10;
    toprear=15.39;
    topfrnt=32.06;
    lead=33.33;
    topoff=10.26;
    ftopoff=lead-topoff;
    ridge=12.42;

    polyhedron(
        points = [
            // base: 0 : 5
            [-frontwidth/2, 0, length], [frontwidth/2, 0, length], [width/2+thickness*sin(11.5), 0, lead], [width/2+thickness*sin(11.5), 0, 0], [-width/2-thickness*sin(11.5), 0, 0], [-width/2-thickness*sin(11.5), 0, lead],
            // front: 6, 7
            [-frontwidth/2, edge, length], [frontwidth/2, edge, length],
            // right: 8 : 10
            [width/2+(thickness-edge)*sin(11.5), edge, lead], [width/2, thickness, ftopoff], [width/2, thickness, topoff],
            // rear: 11, 12
            [width/2+(thickness-edge)*sin(11.5), edge, 0], [-width/2-(thickness-edge)*sin(11.5), edge, 0],
            // left: 13 : 15
            [-width/2, thickness, topoff], [-width/2, thickness, ftopoff], [-width/2-(thickness-edge)*sin(11.5), edge, lead],
            // top: 16 : 19
            [-ridge/2, thickness, topfrnt], [ridge/2, thickness, topfrnt], [ridge/2, thickness, toprear], [-ridge/2, thickness, toprear],
        ],
        triangles = [
            // base: 0 : 3
            [2, 0, 1], [5, 0, 2], [3, 4, 5], [2, 3, 5],
            // front: 4, 5
            [6, 7, 1], [1, 0, 6],
            // right,front: 6,7
            [1, 7, 2], [8, 2, 7],
            // right: 8 : 11
            [9, 2, 8], [10, 11, 3], [2, 9, 10], [3, 2, 10],
            // back: 12, 13
            [12, 3, 11], [4, 3, 12],
            // left: 14 : 17
            [13, 5, 4], [4, 12, 13], [13, 14, 5], [14, 15, 5],
            // left,front: 18,19
            [0, 5, 15], [0, 15, 6],
            // top,left: 20 : 24
            [16, 6, 15], [14, 16, 15], [14, 19, 16], [19, 14, 13], [12, 19, 13],
            // top, back: 25, 26
            [12, 18, 19], [11, 18, 12],
            // top,right: 27 : 31
            [10, 18, 11], [9, 18, 10], [17, 18, 9], [8, 17, 9], [7, 17, 8],
            // top, front: 32, 33
            [17, 7, 6], [6, 16, 17],
            // top: 34, 35
            [19, 17, 16], [19, 18, 17],
        ]
    );
}

module barrel(diam,len,flash,diam2) {
      difference() {
            union() {
                 cylinder(r=diam/2, h=len);
                 translate( [0, 0, len-(flash+1)] ) cylinder(r=flash/2, h=flash);
                 cylinder(r=diam2/2, h=len/2);
                 sphere( r=diam2/2 );
           }
           translate( [0, 0, len] ) rotate( [180, 0, 0] ) nozzle( diam, diam/2-0.45 );
     }
}

module top_left_pane() {
    translate( [middlewidth/2+thick*sin(7),-1,cockpit_height-2*thick*cos(tl_angle1)] )
        rotate([3,0,-7]) rotate([0,tl_angle1,0]) top_side_pane();
}

module bottom_left_pane() {
    bl_angle1=71;
    translate( [middlewidth/2+thick*sin(9),1.5,cockpit_height-3*thick*cos(tl_angle1)] )
        rotate([-6,0,9]) rotate([0,bl_angle1,0]) bottom_side_pane();
}

module top_center_pane() {
    topwid=11-2;
    botwid=5.5-2;
    len=15-2;
    translate([0,-2,-thick/2]) linear_extrude(height=thick) polygon(
        points= [
            [-topwid/2,-len],
            [topwid/2,-len],
            [botwid/2,0],
            [-botwid/2,0]
        ],
        paths = [ [ 0,1,2,3] ]
    );
}

module top_side_pane() {
    length=19-2;
    mid=11.5;
    height=9-2;
    translate([0,0,-thick/2]) linear_extrude(height=thick) polygon(
        points = [
            [0,0], [length,0], [mid,-height],
        ],
        paths = [ [0,1,2] ]
    );
}

module bottom_center_pane() {
    topwid=5.5-2;
    botwid=8-2;
    len=18.5-2;
    translate([0,2.2,-thick/2]) linear_extrude(height=thick) polygon(
        points= [
            [-topwid/2,0],
            [topwid/2,0],
            [botwid/2,len],
            [-botwid/2,len]
        ],
        paths = [ [ 0,1,2,3] ]
    );
}

module bottom_side_pane() {
    length=19-2;
    mid=10;
    height=14.5-2;
    translate([0,0,-thick/2]) linear_extrude(height=thick) polygon(
        points = [
            [0,0], [length,0], [mid,height],
        ],
        paths = [ [0,1,2] ]
    );
}

