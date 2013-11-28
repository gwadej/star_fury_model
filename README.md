# Aurora Class Star Fury Model

After I got my 3D printer and had spent time printing other people's designs, I
wanted a model of my own.  I went through some relatively simple designs and
was ready for something more complicated.

Anyone who has seen *Babylon 5* is familiar with the Star Fury. It was the
fighter craft of the Earth Alliance. It also moved like no other craft that I
can remember in Science Fiction. As a big fan, I really wanted a star fury
model, but I never saw one. Now that I had a 3D printer, I was going to fix
that.

## Design

This design is a simplified version of the Star Fury seen throughout the
series. One day, I hope to extend the design to be more accurate. I wanted
the design to be big enough to handle, but the parts had to fit within the
build volume of my Thing-o-matic.

To avoid the problem of needing to print a lot of support, I decided to
design the model in parts and assemble it into the final model. This ended up
meaning that the model requires a lot of post processing. But the result is
pretty impressive.

This was my first serious design using OpenSCAD, so there are quite a few bits
that are not optimal. One day, I'll go back and fix that.

## Major Parts

The model is separated into several files, each focuses on a different part of
the model.

## baffle.scad

This file describes that baffle structures that mount on the back portion of
the main engines of the model.

## baffles\_all.scad

This file generates a single plate that contains all of the baffles.

## body.scad

This file describes the body of the model.

## engine\_mount.scad

The structure on the side of the engine that connects to the main struts.

## engine.scad

One of the four main engines on the model.

## engines4.scad

A printing plate that contains all four engines, ready to print.

## side\_thruster.scad

The nozzle for the perpendicular thrusters on the engines.

## stand.scad

A stand for holding the model.

## struts.scad

These struts connect the engines to the main body of the model.

## thrusters.scad

This is a printing plate that contains all eight thruster pieces.

## utils.scad

Utilities used while designing the model.

# Future Directions

Looking at the model again, two years later, I see a large number of really bad
design decisions. I need to clean up the OpenSCAD itself pretty substantially.

# License

This model was released under a Creative Commons - Attribution - Share Alike
License ([BY-SA](http://creativecommons.org/licenses/by-sa/3.0/)).
