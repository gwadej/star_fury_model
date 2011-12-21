$fn=30;
base_thick=6.48;
tip_thick=4.32;
base_len=33.33;
tip_len=30.3;
width=34.89;
edge=2;
topoff=10.26;

back_base=14*width/45;
back_tip=8.5*width/45;
back_len=5.4*width/45;

translate([ 5,0,0]) strut();
translate([-5,0,0]) mirror([1,0,0]) strut();

module strut() {
    union() {
     %  polyhedron(
            points = [
                // base: 0 : 3
                [0, base_len/2, 0], [0, -base_len/2, 0], [width, -base_len/2-width*cos(28), 0], [width, base_len/2-width*cos(34), 0],
                // top, right: 4 : 7
                [0, base_len/2, edge], [0, base_len/2-topoff, base_thick], [0, -base_len/2+topoff, base_thick], [0, -base_len/2, edge],
                // top, left: 8 : 11
                [width, -base_len/2-width*cos(28), edge], [width, -base_len/2+topoff-width*cos(28), tip_thick], [width, base_len/2-topoff-width*cos(34), tip_thick], [width, base_len/2-width*cos(34), edge],
            ],
            triangles = [
                //base:0,1
                [0, 3, 1], [3, 2, 1],
                // right: 2 : 5
                [1, 7, 6], [1, 6, 0], [6, 5, 0], [0, 5, 4],
                // back: 6, 7
                [1, 2, 8], [1, 8, 7],
                // left: 8 : 11
                [3, 11, 10], [3, 10, 2], [10, 9, 2], [2, 9, 8],
                // front: 12, 13
                [0, 4, 11], [11, 3, 0],
                // front,top: 14, 15
                [4, 5, 10], [10, 11, 4],
                // top: 16, 17
                [5, 6, 10], [6, 9, 10],
                // back,top: 14, 15
                [6, 7, 9], [7, 8, 9],
            ]
        );
        translate([back_base/2*cos(-38),-base_len*sin(38)-back_len/2,0]) rotate([0,0,-38]) linear_extrude(height=edge) polygon(
            points = [
                [-back_base/2, back_len/2], [back_base/2, back_len/2], [back_tip/2, -back_len/2], [-back_tip/2, -back_len/2],
            ],
            path = [
                // base
                [1, 0, 3], [3, 2, 1],
            ]
        );
    }
}
