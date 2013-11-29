// File: struts.scad
// Author: G. Wade Johnson
// Copyright: 2013 G. Wade Johnson, Some Rights Reserved.
// Design for the struts that connect the engines to the body of the starfury
//  model

$fn=30;
base_thick=6.48;
tip_thick=4.32;
base_len=33.33;
tip_len=30.3;
strut_len=34.89;
edge=2;
topoff=10.26;

back_base=14*strut_len/45;
back_tip=8.5*strut_len/45;
back_len=5.4*strut_len/45;

// Plate of all four struts
module all_struts()
{
    translate([ 5,0.7*base_len,0]) strut();
    translate([-5,0.7*base_len,0]) mirror([1,0,0]) strut();

    translate([ 5,-0.6*base_len,0]) strut();
    translate([-5,-0.6*base_len,0]) mirror([1,0,0]) strut();
}

// Model of a single engine support strut
module strut() {
    ifrac=0.8;
    ofrac=1-ifrac;
    inner_tip=ifrac*back_tip;
    outer_tip=-ofrac*back_tip;
    union() {
        polyhedron(
            points = [
                // base: 0 : 3
                [-base_thick*sin(12.5), base_len/2, 0], [-base_thick*sin(12.5), -base_len/2, 0], [strut_len, -tip_len/2-strut_len*sin(28), 0], [strut_len, tip_len/2-strut_len*sin(34), 0],
                // top, right: 4 : 7
                [-(base_thick-edge)*sin(12.5), base_len/2, edge], [0, base_len/2-topoff, base_thick], [0, -base_len/2+topoff, base_thick], [-(base_thick-edge)*sin(12.5), -base_len/2, edge],
                // top, left: 8 : 11
                [strut_len, -tip_len/2-strut_len*sin(28), edge], [strut_len, -tip_len/2+topoff-strut_len*sin(28), tip_thick], [strut_len, tip_len/2-topoff-strut_len*sin(34), tip_thick], [strut_len, tip_len/2-strut_len*sin(34), edge],
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
        translate([1.25*back_len*cos(38),-base_len*sin(38),0]) rotate([0,0,-24]) polyhedron(
            points = [
                [-back_base/2, back_len/2, 0], [back_base/2, back_len/2, 0], [inner_tip, -back_len/2, 0], [outer_tip, -back_len/2, 0],
                [-back_base/2, back_len/2, edge], [back_base/2, back_len/2, edge], [inner_tip, -back_len/2, edge/2], [outer_tip, -back_len/2, edge/2],
            ],
            triangles = [
                // base: 0, 1
                [1, 0, 3], [3, 2, 1],
                // front; 2, 3
                [0, 1, 5], [5, 4, 0],
                // left: 4, 5
                [0, 4, 7], [7, 3, 0],
                // back: 6, 7
                [3, 7, 6], [6, 2, 3],
                // right: 8, 9
                [2, 6, 5], [5, 1, 2],
                // top: 10, 11
                [4, 5, 6], [6, 7, 4],
            ]
        );
    }
}
