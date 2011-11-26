height=23.73;
width=18;
topwid=11.45;
botwid=7.57;
midwid=4.9;
heightwid=14.73;
topwind=height-heightwid;
botleg=15.55;
topleg=9.82;
bdepth=29.93;
point=7.94;
depth=bdepth+point;

% union() {
    linear_extrude( height=bdepth ) polygon(
        points = [ [-topwid/2,-topwind], [topwid/2,-topwind], [width/2,0],
                    [botwid/2,heightwid], [-botwid/2,heightwid], [-width/2,0]
                ],
        paths = [ [0,1,2,3,4,5] ]
    );
    translate( [0,0,bdepth] ) cockpit();
}

body();

module body() {
    toplt=-topwid/2;
    toprt=topwid/2;
    midlt=-width/2;
    midrt=width/2;
    botlt=-botwid/2;
    botrt=botwid/2;
    top=-topwind;
    mid=bdepth;
    bot=heightwid;
    frntlt=-midwid/2;
    frntrt=midwid/2;
    polyhedron(
        points = [
            [toplt, top, 0],   [toprt, top, 0],   [midrt, 0, 0],   [botrt, bot, 0],   [botlt, bot, 0],   [midlt, 0, 0],
            [toplt, top, mid], [toprt, top, mid], [midrt, 0, mid], [botrt, bot, mid], [botlt, bot, mid], [midlt, 0, mid],
            [frntlt, -1, depth], [frntrt, -1, depth], [frntrt, 1, depth], [frntlt, 1, depth]
        ],
        triangles = [
            [0, 4, 5], [1, 2, 3], [0, 3, 4], [0, 1, 3], //back
            [0, 6, 1], [1, 6, 7],   //top
            [6, 0, 5], [6, 5, 11],  //top left
            [8, 1, 7], [1, 8, 2],   //top right
            [9, 2, 8], [2, 9, 3],   //bottom right
            [10, 3, 9], [3, 10, 4],   //bottom
            [11, 4, 10], [4, 11, 5],   //bottom left
            [15, 11, 10], [15, 12, 11], [11, 12, 6], //front left
            [12, 7, 6], [13, 7, 12],  // front top
            [12, 14, 13], [15, 14, 12],   //front
            [13, 8, 7], [8, 13, 14], [14, 9, 8], //front right
            [14, 10, 9], [15, 10, 14]  // front bottom
        ]
    );
}

module cockpit() {
    union() {
        section(    [-topwid/2, -topwind], [ topwid/2, -topwind], [midwid/2, -1] );
        invsection( [-topwid/2, -topwind], [-midwid/2, -1],       [midwid/2, -1] );

        section(    [ topwid/2, -topwind], [ width/2,  0],        [midwid/2, -1] );
        invsection( [ width/2,  0],        [ midwid/2, 0],        [midwid/2, -1] );

        section(    [-topwid/2, -topwind], [-width/2,  0],        [-midwid/2, -1] );
        invsection( [-width/2,  0],        [-midwid/2, 0],        [-midwid/2, -1] );

        section(    [-botwid/2, heightwid], [ botwid/2, heightwid], [midwid/2, 1] );
        invsection( [-botwid/2, heightwid], [-midwid/2, 1],       [midwid/2, 1] );

        section(    [ botwid/2, heightwid], [ width/2,  0],        [midwid/2, 1] );
        invsection( [ width/2,  0],        [ midwid/2, 0],        [midwid/2, 1] );

        section(    [-botwid/2, heightwid], [-width/2,  0],        [-midwid/2, 1] );
        invsection( [-width/2,  0],         [-midwid/2, 0],        [-midwid/2, 1] );

        polyhedron(
            points = [
                [midwid/2, 1, point ],
                [midwid/2, -1, point],
                [-midwid/2, -1, point],
                [-midwid/2, 1, point],
                [0,0,0]
            ],
            triangles = [ [0,1,2], [2,3,0], [1,0,4], [2,1,4], [3,2,4], [3,4,0] ]
        );
    }
}

module section(b1,b2,t) {
    polyhedron(
        points = [ [b1[0], b1[1], 0 ], [b2[0], b2[1], 0], [t[0], t[1], point], [0,0,0] ],
        triangles = [ [0,1,2],[1,3,2],[2,3,0],[0,3,1] ]
    );
}

module invsection(b,t1,t2) {
    polyhedron(
        points = [ [t1[0], t1[1], point], [t2[0], t2[1], point], [b[0], b[1], 0], [0,0,0] ],
        triangles = [ [0,1,2],[1,3,2],[2,3,0],[0,3,1] ]
    );
}
