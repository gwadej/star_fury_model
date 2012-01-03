use <side_thruster.scad>

for (x = [-30, -10, 10, 30])
{
    translate( [x, -10, 0] ) thruster();
    translate( [x,  10, 0] ) thruster();
}
