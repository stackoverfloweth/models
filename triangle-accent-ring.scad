// Triangle Accent Ring (IMG_1014)
// A delicate ring with a small triangular accent on top

// Parameters
ring_diameter = 19;      // Inner diameter of ring (adjust for finger size)
band_thickness = 1.5;    // Thickness of the thin band
band_height = 1;       // Height of the band
triangle_size = 3;       // Size of the triangle accent

$fn = 80;

module triangle_accent_ring() {
    union() {
        // Main thin band
        difference() {
            cylinder(h=band_height, d=ring_diameter + 2*band_thickness);
            translate([0, 0, -0.5])
                cylinder(h=band_height + 1, d=ring_diameter);
        }

        // Triangle accent on outside of ring
        translate([0, ring_diameter/2 + band_thickness, band_height/2]) {
            rotate([90, 0, 0]) {
                linear_extrude(height=1.5, center=true) {
                    polygon([
                        [0, triangle_size * 0.866 / 2],
                        [-triangle_size/2, -triangle_size * 0.866 / 2],
                        [triangle_size/2, -triangle_size * 0.866 / 2]
                    ]);
                }
            }
        }
    }
}

triangle_accent_ring();
