// Conjoined Heart Ring Parameters
ring_diameter = 18;        // Inner diameter of the ring (adjust for size)
num_hearts = 8;            // Number of hearts around the ring
heart_width = 6;           // Width of each heart
heart_height = 5;          // Height of each heart
band_thickness = 2;        // Thickness of the heart outline
ring_depth = 3;            // Depth (thickness) of the ring

$fn = 50;                  // Resolution

// Create the ring from conjoined heart outlines
rotate_extrude(convex = false)
translate([ring_diameter/2 + heart_width/2, 0, 0])
hearts_profile();

// Module to create the profile of conjoined hearts
module hearts_profile() {
    circumference = PI * (ring_diameter + heart_width);
    heart_spacing = circumference / num_hearts;
    
    for (i = [0:num_hearts-1]) {
        translate([0, i * heart_spacing / (ring_diameter/2 + heart_width/2) * (180/PI) - (num_hearts * heart_spacing / (ring_diameter/2 + heart_width/2) * (180/PI))/2, 0])
        rotate([0, 0, 0])
        heart_outline_profile();
    }
}

// 2D heart outline profile
module heart_outline_profile() {
    difference() {
        // Outer heart shape
        heart_shape(heart_width, heart_height);
        
        // Inner heart shape (smaller)
        offset(r = -band_thickness)
        heart_shape(heart_width, heart_height);
    }
}

// Basic heart shape
module heart_shape(w, h) {
    scale([w/10, h/10, 1]) {
        translate([0, -2, 0]) {
            hull() {
                // Left circle
                translate([-2.5, 3.5, 0])
                circle(r = 3, $fn = 30);
                
                // Right circle
                translate([2.5, 3.5, 0])
                circle(r = 3, $fn = 30);
                
                // Bottom point
                translate([0, -4, 0])
                circle(r = 0.5, $fn = 30);
            }
        }
    }
}