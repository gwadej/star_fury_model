height=23.73;
width=18;
topwid=11.45;
botwid=7.57;
midwid=4.9;
heightwid=14.73;
topwind=height-heightwid;
bdepth=29.93;
point=7.94;
depth=bdepth+point;

toplt=-topwid/2;
toprt=topwid/2;
midlt=-width/2;
midrt=width/2;
botlt=-botwid/2;
botrt=botwid/2;
top=-topwind;
mid=bdepth;
midback=mid-point/2;
bot=heightwid;
frntlt=-midwid/2;
frntrt=midwid/2;
polyhedron(
    points = [
        [toplt, top, 0],   [toprt, top, 0],   [midrt, 0, 0],   [botrt, bot, 0],   [botlt, bot, 0],   [midlt, 0, 0],
        [toplt, top, mid], [toprt, top, mid], [midrt, 0, midback], [botrt, bot, mid], [botlt, bot, mid], [midlt, 0, midback],
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
