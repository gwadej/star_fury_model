$fn=30;
tip_thick=4.32;
tip_len=30.3;
edge=2;

topoff=10.26;
width=34.89;
adj=width*(sin(28)-sin(34));

module mount() {
    depth=8;
    union() {
        translate( [tip_len+adj, 0, 0] )
        rotate([-90,0,0])
        linear_extrude( height=edge ) polygon(
            points = [
                [0, 0], [0.65*depth,-0.35*depth], [0, -depth]
            ],
            paths = [ [0, 1, 2] ]
        );
        linear_extrude( height=depth ) polygon(
            points = [
                [0, 0],
                [0, edge],
                [topoff, tip_thick],
                [tip_len-topoff+adj, tip_thick],
                [tip_len+adj, edge],
                [tip_len+adj, 0]
            ],
            paths = [ [0, 1, 2, 3, 4, 5] ]
        );
    }
}

//mount();
