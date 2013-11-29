# Makefile for the Starfury model

STLS=\
	baffles_all.stl\
	body.stl\
	engines4.stl\
	stand.stl\
	struts.stl\
	thrusters.stl

SRCS=\
	 starfury.scad\
	 baffle.scad\
	 body.scad\
	 engine.scad\
	 engine_mount.scad\
	 side_thruster.scad\
	 stand.scad\
	 struts.scad\
	 utils.scad

# This is system-specific
OPENSCAD=/usr/local/bin/openscad

all: $(STLS)

baffles_all.stl: $(SRCS)
	$(OPENSCAD) -o $@ -D'plate="baffles_all"' starfury.scad

baffle.stl: $(SRCS)
	$(OPENSCAD) -o $@ -D'plate="baffle"' starfury.scad

body.stl: $(SRCS)
	$(OPENSCAD) -o $@ -D'plate="body"' starfury.scad

engine.stl: $(SRCS)
	$(OPENSCAD) -o $@ -D'plate="engine"' starfury.scad

engines4.stl: $(SRCS)
	$(OPENSCAD) -o $@ -D'plate="engines4"' starfury.scad

stand.stl: $(SRCS)
	$(OPENSCAD) -o $@ -D'plate="stand"' starfury.scad

struts.stl: $(SRCS)
	$(OPENSCAD) -o $@ -D'plate="struts"' starfury.scad

thrusters.stl: $(SRCS)
	$(OPENSCAD) -o $@ -D'plate="thrusters"' starfury.scad

# Create STL files from OpenSCAD files
%.stl: %.scad
	$(OPENSCAD) -o $@ $<

.PHONY: clobber
.SECONDARY:

clobber:
	rm $(STLS)
