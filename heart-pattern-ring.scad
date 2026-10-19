// Heart Pattern Ring (IMG_1012)
// A ring with repeating heart cutouts around the band

// Parameters
ring_diameter = 18;      // Inner diameter of ring (adjust for finger size)
ring_height = 8;         // Height of the ring band
ring_thickness = 2.5;    // Thickness of the ring wall
num_hearts = 8;          // Number of hearts around the ring

$fn = 100;

module heart_2d(size=1) {
    // Create a 2D heart shape
    scale([size, size, 1]) {
        translate([0, -0.3, 0]) {
            union() {
                // Two circles for top of heart
                translate([-0.5, 0.5, 0])
                    circle(r=0.7);
                translate([0.5, 0.5, 0])
                    circle(r=0.7);
                // Triangle for bottom of heart
                polygon([[-1.2, 0.5], [1.2, 0.5], [0, -1.5]]);
            }
        }
    }
}

module heart_ring() {
    outer_radius = ring_diameter/2 + ring_thickness;
    inner_radius = ring_diameter/2;

    difference() {
        // Main ring body
        cylinder(h=ring_height, r=outer_radius);

        // Inner hole
        translate([0, 0, -1])
            cylinder(h=ring_height + 2, r=inner_radius);

        // Cut out hearts around the ring
        for (i = [0:num_hearts-1]) {
            angle = i * (360/num_hearts);
            rotate([0, 0, angle])
                translate([outer_radius - ring_thickness/2, 0, ring_height/2])
                    rotate([0, 90, 0])
                        linear_extrude(height=ring_thickness + 1, center=true)
                            heart_2d(2.5);
        }
    }
}

heart_ring();
