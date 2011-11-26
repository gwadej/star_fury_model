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
union() {
    section( [-topwid/2,  -topwind], [topwid/2, -topwind],  [ midwid/2, -1] );
    invsection( [-topwid/2,  -topwind], [-midwid/2, -1],  [midwid/2, -1] );

    section( [ topwid/2,  -topwind], [ width/2, 0],         [midwid/2, -1] );
    invsection( [ width/2,  0], [ midwid/2, 0],         [midwid/2, -1] );

    section( [-topwid/2,  -topwind], [-width/2, 0],         [-midwid/2, -1] );
   # invsection( [-width/2,  0], [-midwid/2, 0],         [-midwid/2, -1] );

    section( [-botwid/2, heightwid], [botwid/2, heightwid], [0, 0] );

    section( [ botwid/2, heightwid], [ width/2, 0],         [0, 0] );

    section( [-botwid/2, heightwid], [-width/2, 0],         [0, 0] );
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
