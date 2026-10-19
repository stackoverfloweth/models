// Initial Ring
// A simple ring with customizable initials on the outside

// Parameters
ring_diameter = 19.5;      // Inner diameter of ring (adjust for finger size)
band_thickness = 1;    // Thickness of the band
band_height = 1;         // Height of the band

// Customizable Initials
font_size = 3;           // Size of the letters
letter_depth = 2;      // How far the letters protrude from the ring
font_name = "Arial:style=Bold";  // Font (change if desired)

$fn = 180;

module curved_text(txt, radius, size, thickness) {
    // Calculate spacing for each character
    char_count = len(txt);
    // Approximate angle per character (adjust based on font width)
    angle_per_char = 15;  // Degrees per character
    total_angle = (char_count - 1) * angle_per_char;
    start_angle = -total_angle / 2;

    for (i = [0:char_count-1]) {
        angle = start_angle + i * angle_per_char;
        rotate([0, 0, angle])
            translate([0, radius, 0])
                rotate([90, 0, 180])  // Added 180 degree Z rotation to flip direction
                    translate([0, 0, -1])  // Start at ring surface
                        linear_extrude(height=thickness)
                            mirror([1, 0, 0])
                                text(txt[i], size=size, font=font_name,
                                     halign="center", valign="bottom");
    }
}

module initial_ring(initials) {
    difference() {
        // Main band
        cylinder(h=band_height, d=ring_diameter + 2*band_thickness);

        // Inner hole
        translate([0, 0, -.5])
            cylinder(h=band_height + 1, d=ring_diameter);
    }

    // Add curved initials on outside of ring
    // Position at base of ring (z=0) with letters extending upward and protruding outward
    translate([0, 0, 0])
        curved_text(initials, ring_diameter/2 + band_thickness, font_size, letter_depth);
}

translate([0, 0, 0])
initial_ring("L");
translate([0, 30, 0])
initial_ring("W");
translate([0, 60, 0])
initial_ring("S");
translate([0, 90, 0])
initial_ring("O");
