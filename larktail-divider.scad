$fn = 180;

width = 98;
length = 375;
base_height = 10;

// Stanley 40oz Quencher - tapered
bottle_diameter_bottom = 78.6;
bottle_diameter_top = 82;

// Ring collar parameters
wall_thickness = 3;
wall_height = 80;

// Bottle center positions (at each rounded end)
bottle_y = length/2 - width/2;

// Base - stadium/oblong shape
hull() {
    translate([0, -bottle_y, 0])
        cylinder(d = width, h = base_height);
    translate([0, bottle_y, 0])
        cylinder(d = width, h = base_height);
}

// Gusset parameters
gusset_height = 40;
gusset_steps = 20;

// Base footprint (for clipping gusset)
module base_footprint() {
    hull() {
        translate([0, -bottle_y, 0])
            circle(d = width);
        translate([0, bottle_y, 0])
            circle(d = width);
    }
}

// Outer diameter at a given height using concave (cosine) curve
function gusset_outer_d(z) =
    let(t = z / gusset_height)
    let(curve = 1 - cos(t * 90)) // concave: stays wide longer, then sweeps in
    (width) * (1 - curve) + (bottle_diameter_bottom + wall_thickness * 2) * curve;

// Inner diameter at a given height (matches collar taper)
function gusset_inner_d(z) =
    bottle_diameter_bottom + (bottle_diameter_top - bottle_diameter_bottom) * (z / wall_height);

// Full ring collar for bottle (tapered to match Stanley profile)
module bottle_collar(y_pos) {
    translate([0, y_pos, 0]) {
        // Collar ring
        difference() {
            cylinder(d1 = bottle_diameter_bottom + wall_thickness * 2, d2 = bottle_diameter_top + wall_thickness * 2, h = wall_height);
            translate([0, 0, -1])
                cylinder(d1 = bottle_diameter_bottom, d2 = bottle_diameter_top, h = wall_height + 2);
        }
        // Concave curved gusset, clipped to base footprint
        intersection() {
            difference() {
                union() {
                    for (i = [0:gusset_steps-1]) {
                        z0 = gusset_height * i / gusset_steps;
                        z1 = gusset_height * (i + 1) / gusset_steps;
                        hull() {
                            translate([0, 0, z0])
                                cylinder(d = gusset_outer_d(z0), h = 0.01);
                            translate([0, 0, z1])
                                cylinder(d = gusset_outer_d(z1), h = 0.01);
                        }
                    }
                }
                translate([0, 0, -1])
                    cylinder(d1 = bottle_diameter_bottom, d2 = bottle_diameter_top, h = wall_height + 2);
            }
            linear_extrude(height = gusset_height)
                translate([0, -y_pos, 0])
                    base_footprint();
        }
    }
}

bottle_collar(-bottle_y/1.15);
bottle_collar(bottle_y/1.15);
