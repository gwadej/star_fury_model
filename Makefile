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
	 baffle.scad

# This is system-specific
OPENSCAD=/usr/local/bin/openscad

all: $(STLS)

baffles_all.stl: $(SRCS)
	$(OPENSCAD) -o $@ -D'plate="all_baffles"' starfury.scad

baffle.stl: $(SRCS)
	$(OPENSCAD) -o $@ -D'plate="baffle"' starfury.scad

# Create STL files from OpenSCAD files
%.stl: %.scad
	$(OPENSCAD) -o $@ $<

.PHONY: clobber
.SECONDARY:

clobber:
	rm $(STLS)
