// File: starfury.scad
// Author: G. Wade Johnson
// Copyright: 2013 G. Wade Johnson, Some Rights Reserved.
// Main driver file for the creation of the Star Fury Model

include <baffle.scad>;
include <engine.scad>;
use <side_thruster.scad>;
include <body.scad>;
use <stand.scad>;
include <struts.scad>;

plate="assembled";

if( plate == "baffle_pair" )
{
    baffle_pair();
}
if( plate == "baffles_all" )
{
    translate([  5,  10, 0]) baffle_pair();
    translate([  5, -35, 0]) baffle_pair();
    translate([-40,  10, 0]) baffle_pair();
    translate([-40, -35, 0]) baffle_pair();
}
if( plate == "body" )
{
    complete_body();
}
if( plate == "engine" )
{
    engine();
}
if( plate == "engines4" )
{
    x_mirrored()
    {
        translate( [-20, -20, 0] ) engine();
        translate( [-20,  20, 0] ) engine();
    }
}
if( plate == "stand" )
{
    translate( [ 25, 0, 0 ] ) stand_main();
    translate( [-15, 0, 0 ] ) stand_top();
}
if( plate == "struts" )
{
    all_struts();
}
if( plate == "thrusters" )
{
    for( x = [-30, -10, 10, 30] )
    {
        translate( [x, -10, 0] ) thruster();
        translate( [x,  10, 0] ) thruster();
    }
}
if( plate == "assembled" )
{
    assembled_stand();
    translate( [ 0, -2.35, 48] ) union()
    {
        assembled_body();

        x_mirrored()
        {
            translate( [ 16.4, 5.9,  9.13 ] ) rotate( [180, 23.2, 0] ) strut();
            translate( [-16.4, 5.9, 27.95 ] ) rotate( [0,-23, 180] ) strut();
            translate( [-strut_len-22.7, 22.8, height+18.1] ) assembled_engine();
            translate( [strut_len+22.7, 22.8, -4.9] ) rotate( [ 0, 180, 0 ] ) assembled_engine();
        }
    }
}

module assembled_engine()
{
    rotate( [0,0,-90] ) rotate( [ 0, 90, 0 ] ) translate( [ 0, 0, -mainlen] ) union()
    {
        engine();
        translate( [-eng_rad-6, 0, fwdoffset-6.3] ) rotate( [ 0, 90, 0 ] ) thruster();
        translate( [0, -eng_rad-6, fwdoffset-6.3] ) rotate( [-90, 0, 0 ] ) thruster();
        rotate( [ 0, 0, 67] ) translate( [-eng_rad-3.5, 0, rearlen+llength/6-3.4] ) rotate( [ 0, 90, 0 ] ) folded_big_baffle();
        rotate( [ 0, 0,-113] ) translate( [-eng_rad-2.5, 0, rearlen+slength/6-3.4] ) rotate( [ 0, 90, 0 ] ) folded_small_baffle();
    }
}
