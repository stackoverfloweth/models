// Simple Rings Set (IMG_1013)
// A set of four simple rings with different decorations: heart, sphere, house/arrow, and sphere

// Parameters
ring_diameter = 17.5;      // Inner diameter of ring (adjust for finger size)
band_thickness = 1;    // Thickness of the thin band
decoration_size = 3;     // Size of decorative elements
spacing = 25;            // Spacing between rings for display

$fn = 180;

module simple_band(inner_d, thickness, height) {
    difference() {
        cylinder(h=height, d=inner_d + 2*thickness);
        translate([0, 0, -0.5])
            cylinder(h=height + 1, d=inner_d);
    }
}

module heart_2d(size=1) {
    scale([size, size, 1]) {
        translate([0, -0.3, 0]) {
            union() {
                translate([-0.5, 0.5, 0])
                    circle(r=0.7, $fn=30);
                translate([0.5, 0.5, 0])
                    circle(r=0.7, $fn=30);
                polygon([[-1.2, 0.5], [1.2, 0.5], [0, -1.5]]);
            }
        }
    }
}

module heart_ring() {
    difference() {
        union() {
            // Main band
            simple_band(ring_diameter, band_thickness, 1.5);

            // Outer heart on outside of ring (flush with band)
            translate([0, ring_diameter/2 + band_thickness/2, 0.75])
                rotate([90, 0, 0])
                    linear_extrude(height=band_thickness, center=true)
                        heart_2d(2.0);
        }

        // Inner heart cutout (cuts through both heart and band)
        translate([0, ring_diameter/2 + band_thickness/2, 0.75])
            rotate([90, 0, 0])
                linear_extrude(height=band_thickness * 3, center=true)
                    heart_2d(1.0);

        // Cut off bottom of heart to align with ring bottom
        translate([0, ring_diameter/2 + band_thickness/2, -5])
            cube([10, band_thickness * 3, 10], center=true);
    }
}

module sphere_ring() {
    union() {
        simple_band(ring_diameter, band_thickness, 1.5);

        // Sphere decoration on top
        // translate([0, ring_diameter/2 + band_thickness, 1.5])
        //     sphere(d=decoration_size);
    }
}

module house_ring() {
    union() {
        simple_band(ring_diameter, band_thickness, 1.5);

        // House/arrow shape decoration
        translate([0, ring_diameter/2 + band_thickness, 1.5]) {
            linear_extrude(height=1) {
                polygon([
                    [-1.5, 0],
                    [-1.5, 2],
                    [0, 3],
                    [1.5, 2],
                    [1.5, 0]
                ]);
            }
        }
    }
}

// Display all rings in a row
translate([-spacing*1.5, 0, 0])
    heart_ring();

translate([-spacing*0.5, 0, 0])
    sphere_ring();

// translate([spacing*0.5, 0, 0])
//     house_ring();

// translate([spacing*1.5, 0, 0])
//     sphere_ring();
