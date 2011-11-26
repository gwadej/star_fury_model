height=23.73;
width=18;
topwid=11.45;
botwid=7.57;
heightwid=14.73;
topwind=height-heightwid;
botleg=15.55;
topleg=9.82;
bdepth=29.93;
point=7.94;
depth=bdepth+point;

difference() {
    linear_extrude( height=depth ) polygon(
    points = [ [-topwid/2,-topwind], [topwid/2,-topwind], [width/2,0],
                [botwid/2,heightwid], [-botwid/2,heightwid], [-width/2,0]
            ],
    paths = [ [0,1,2,3,4,5] ]
    );
    translate( [-15, -topwind, bdepth] ) rotate( [43, 0, 0] ) cube( [30, 30, 30] );
    translate( [-15, 1, depth] ) rotate( [-30, 0, 0] ) cube( [50, 50, 50] );
}

% translate( [0,2,bdepth] ) cube( [50,50,1], center=true );
