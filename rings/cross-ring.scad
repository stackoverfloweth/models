// Cross Ring (IMG_1015)
// A simple ring with a cross decoration on top

// Parameters
ring_diameter = 14.5;      // Inner diameter of ring (adjust for finger size)
band_thickness = 1;      // Thickness of the band
band_height = 1;         // Height of the band
cross_width = 5;         // Width of the cross
cross_height = 7;        // Height of the cross
cross_thickness = 1.2;   // Thickness of cross arms

$fn = 180;

module cross_2d() {
    union() {
        // Vertical arm
        translate([-cross_thickness/2, 0, 0])
            square([cross_thickness, cross_height]);

        // Horizontal arm (positioned higher up on the vertical)
        translate([-cross_width/2, cross_height*0.6, 0])
            square([cross_width, cross_thickness]);
    }
}

module cross_ring() {
    union() {
        // Main band
        difference() {
            cylinder(h=band_height, d=ring_diameter + 2*band_thickness);
            translate([0, 0, -0.5])
                cylinder(h=band_height + 1, d=ring_diameter);
        }

        // Cross decoration on outside of ring
        translate([0, ring_diameter/2 + band_thickness, band_height/2]) {
            rotate([90, 0, 0]) {
                linear_extrude(height=1.5, center=true) {
                    rotate([0, 0, 90]) {
                        translate([0, -cross_height/2, 0])
                            cross_2d();
                    }
                }
            }
        }
    }
}

cross_ring();
