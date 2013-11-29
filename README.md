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

This model is my first attempt to create an Aurora-class
[Starfury](http://en.wikipedia.org/wiki/Starfury) from the television show
Babylon 5. I've always liked the design of this one-man fighter craft and
decided that it would be a fun and challenging design project. I wanted
the design to be big enough to handle, but the parts had to fit within the
build volume of my Thing-o-matic.

The included STL files were designed for efficiency of printing and assembling
a single model. You can use the included OpenSCAD files to print individual
parts or make modifications. I hope to make the OpenSCAD files easier to modify
at some point.

Although this is a pretty good first attempt, there are several features that
are not quite correct.

1. The upper supports are much simpler than they should be.
2. The forward guns are not as well-formed and sturdy as I would like.
3. The detail on the sides of the body could use some work.
4. The back of the model has no detail at all.

As my design skills improve, I hope to revisit this model.

## Build Instructions

The model is made up of a number of pieces that must be glued together to make
the final piece. I used an ABS/acetone mixture as glue. I assume super glue or
model cement would work as well.

You need to print one each of

1. stand.stl - support for model 
2. body.stl - main body 
3. struts.stl - connect the engines to the body 
4. engines4.stl - mount at the ends of the struts 
5. thrusters.stl - small thruster engines at right angles to main engines 
6. baffles\_all.stl - baffles mounting to the rear of the main engines

Note: The body (body.stl) has four conical supports that snap off after the
print is complete. Sometimes these will disconnect when you remove the body
from the build platform. That is not a sign of a problem. If any of the
supports remain attached to the body, they should snap off relatively easily.

Note: Almost all parts should be relatively insensitive to minor differences in
printer configuration. However, I found that the baffles\_all.stl only prints
well with extra shells set to 0 and 100% infill (in the Fill plugin).

1. (stand.stl) Glue the flat part of the cross shape on top of the shaft,
   inserting the pin on the top of the shaft in the hole on the top.
2. Glue the wide portion of one pair of struts (struts.stl) to the upper
   support on the body (body.stl). The flat portion of the struts will be on
   the bottom. Both the side of the strut and the mount point are angled, so
   the result should angle upward. (Look at the pictures to determine which
   part of the body is the top.)
   * If necessary, sand off any rough spots to allow for a good fit.
   * You will need to hold or tape this piece in place until the glue dries.
3. Glue the wide portion of the other pair of struts to the supports on the
   lower sides of the body. The flat portion of the struts should face up. Both
   the side of the strut and the mount point are angled, so the result should
   angle downward.
   * If necessary, sand off any rough spots to allow for a good fit.
   * You will need to hold or tape this piece in place until the glue dries.
4. Now is a good time to attach (not glue) the body to the stand. This will
   make further work easier, since there is no flat portion of the model that
   you can set down. The longer portion of the top of the stand should match
   with the front of the model.
   * There are two pair of rectangular supports on the bottom of the body.
     These supports should match the gaps in the side rails of the top of the
     stand. A little pressure should friction-fit these pieces together.
5. Each of the engines (engines4.stl) has a pair of holes at right angles on
   the side of the engine. These are mounting points for the little thruster
   nozzles (thrusters.stl).
   * Glue one nozzle with the shaft inside each of the two side holes on the
     engine.
   * Repeat for each of the four.
6. There are two different versions of the engine (engines4.stl). Find the
   engine that matches with the top right strut (looking at the small end, the
   thrusters will point up and right and the engine mount will be on the top
   left).
   * Glue the engine mount to the end of the top right strut. If necessary,
     sand off any rough spots to allow for a good fit.
   * You will need to hold or tape this piece in place until the glue dries.
7. Find the engine that matches the top left strut (thrusters point up and
   left, engine mount on top right). Glue the engine mount to the end of the
   top left strut. If necessary, sand off any rough spots to allow for a good
   fit.
8. Find the engine that matches the lower right strut (thrusters point down and
   right, engine mount on lower left). Glue the engine mount to the end of the
   lower right strut. If necessary, sand off any rough spots to allow for a
   good fit.
9. Find the engine that matches the lower left strut (thrusters point down and
   left, engine mount on lower right). Glue the engine mount to the end of the
   lower left strut. If necessary, sand off any rough spots to allow for a good
   fit.
10. The baffles (baffles\_all.stl) require some minor modification before
    mounting. With the flat side down, there are two grooves that run
    lengthwise down each baffle. The sides of the baffle should be bent upward
    about 10-15 degrees on each side.
11. Each of the little *fingers* at the end of the baffle also need to be bent
    slightly upwards (maybe 5 degrees).
12. Repeat steps 10 and 11 for all 8 baffles.
13. The smaller baffles mount on the side of the rear nozzle closest to the
    body. There is a small hole that matches a small pin on the top front of
    the baffle. (It is relatively close to the angle of the support strut.)
    * Glue this pin in the hole. You will need to hold this for some time until
      the glue sets. Try to keep the fingers pointed directly to the rear of
      the module.
14. Repeat step 13 for all of the small baffles.
15. The larger baffles mount on the outside of the rear nozzle. There is a
    small hole that matches a small pin on the top front of the baffle. (It is
    very close to directly opposite the angle of the support strut.)
    * Glue this pin in the hole. You will need to hold this for some time until
      the glue sets. Try to keep the fingers pointed directly to the rear of
      the module.
16. Repeat step 15 for the rest of the large baffles.

Congratulations, you have your own Starfury model!

## Major Parts

The model is separated into several files, each focuses on a different part of
the model.

### starfury.scad

This file brings together all of the definitions and declares the individual
*plates* to be constructed. To build a given STL file, change the *plate*
variable to have one of the defined values. The Makefile will construct each of
the output STL files.

### baffle.scad

This file describes the baffle structures that mount on the back portion of
the main engines of the model.

### body.scad

This file describes the body of the model.

### engine\_mount.scad

The structure on the side of the engine that connects to the main struts.

### engine.scad

One of the four main engines on the model.

### side\_thruster.scad

The nozzle for the perpendicular thrusters on the engines.

### stand.scad

A stand for holding the model.

### struts.scad

These struts connect the engines to the main body of the model.

### utils.scad

Utilities used while designing the model.

## Assembled STL File

The file *assembled.stl* shows what the model looks like once it is fully
assembled. This STL is not meant to be printed, it just serves as a reference
model.

## Future Directions

Looking at the model again, two years later, I see a large number of really bad
design decisions. I need to clean up the OpenSCAD itself pretty substantially.

Some of the bad design decisions are a result of having been an OpenSCAD novice
at the time I built the model. I wasn't aware of many ways to reduce duplication.
The bigger problem is the large number of raw literals in the code. This was
partly caused by developing the model based on random pictures. Unfortunately,
most of it was just bad practice. I have been programming long enough to know
better, but I still made the mistake.

## License

This model was released under a Creative Commons - Attribution - Share Alike
License ([BY-SA](http://creativecommons.org/licenses/by-sa/3.0/)).
