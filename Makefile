# Makefile for the Starfury model

STLS=\
	stl/baffles_all.stl\
	stl/body.stl\
	stl/engines4.stl\
	stl/stand.stl\
	stl/struts.stl\
	stl/thrusters.stl\
	stl/assembled.stl

SRCS=\
	 starfury.scad\
	 baffle.scad\
	 body.scad\
	 engine.scad\
	 side_thruster.scad\
	 stand.scad\
	 struts.scad\
	 utils.scad

# This is system-specific
OPENSCAD=/usr/local/bin/openscad

all: $(STLS)

stl/baffles_all.stl: $(SRCS)
	$(OPENSCAD) -o $@ -D'plate="baffles_all"' starfury.scad

stl/baffle_pair.stl: $(SRCS)
	$(OPENSCAD) -o $@ -D'plate="baffle_pair"' starfury.scad

stl/body.stl: $(SRCS)
	$(OPENSCAD) -o $@ -D'plate="body"' starfury.scad

stl/engine.stl: $(SRCS)
	$(OPENSCAD) -o $@ -D'plate="engine"' starfury.scad

stl/engines4.stl: $(SRCS)
	$(OPENSCAD) -o $@ -D'plate="engines4"' starfury.scad

stl/stand.stl: $(SRCS)
	$(OPENSCAD) -o $@ -D'plate="stand"' starfury.scad

stl/struts.stl: $(SRCS)
	$(OPENSCAD) -o $@ -D'plate="struts"' starfury.scad

stl/thrusters.stl: $(SRCS)
	$(OPENSCAD) -o $@ -D'plate="thrusters"' starfury.scad

stl/assembled.stl: $(SRCS)
	$(OPENSCAD) -o $@ -D'plate="assembled"' starfury.scad

# Create STL files from OpenSCAD files
%.stl: %.scad
	$(OPENSCAD) -o $@ $<

.PHONY: clobber
.SECONDARY:

clobber:
	rm $(STLS)
