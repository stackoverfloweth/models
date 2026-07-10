// Disc Golf Mini Trophy - Single Piece with Raised Text
// Print with filament swap for multi-color effect
//
// To print:
// 1. Export as STL
// 2. Slice and add filament change at the layer where raised features start
//    (typically around 2.2mm height for a 3mm thick disc)
// 3. Print base layers in black, then swap to white for raised features

$fn = 180; // Smooth circles

// Dimensions (all in mm)
mini_diameter = 75;       // Disc diameter
base_thickness = 6;       // Base disc thickness (layers before color swap)
raised_height = 0.5;        // Height of raised features (after color swap)
total_thickness = base_thickness + raised_height;  // Total = 10mm

// Main model
disc_golf_mini();

// ===== MAIN MINI MODEL =====
module disc_golf_mini() {
    // Base disc (black)
    color("black")
        cylinder(d=mini_diameter, h=base_thickness);

    // Raised features (white - this is where you swap filament color)
    color("white")
        translate([0, 0, base_thickness])
            raised_features();
}

// ===== RAISED FEATURES (for color swap) =====
module raised_features() {
    linear_extrude(height=raised_height) {
        // Outer and inner decorative rings
        decorative_rings();

        // Disc golf basket in center (scaled and repositioned for 75mm disc)
        translate([0, 15, 0])
            scale(0.75)
                basket_2d();

        // Floral decorations flanking basket
        translate([-2, 15, 0])
            floral_accent();
        translate([2, 15, 0])
            mirror([1, 0, 0])
                floral_accent();

        // Trophy category at bottom
        text_banner_2d();

        // Repeating "KING 2025" around the circumference
        circular_text();
    }
}

// ===== DISC GOLF BASKET (top-down view) =====
module basket_2d() {
    union() {
        // Outer basket cage rim
        difference() {
            circle(d=20);
            circle(d=18);
        }

        // Inner catch tray
        difference() {
            circle(d=16);
            circle(d=14);
        }

        // Small inner chain ring (where all chains connect)
        difference() {
            circle(d=8);
            circle(d=6.5);
        }

        // Center pole (looking down at it)
        rotate([0, 0, 35])
        star_5point(size=2);

        // Interlinking chain ovals - concentric rings moving inward
        for (i = [0:30:330]) {
            rotate([0, 0, i]) {
                // Outer chain link (vertical oval)
                translate([6.5, 0, 0])
                    difference() {
                        scale([0.6, 1, 1])
                            circle(d=1.4);
                        scale([0.6, 1, 1])
                            circle(d=0.7);
                    }
                // Middle chain link (horizontal oval, overlapping)
                translate([5.75, 0, 0])
                    rotate([0, 0, 90])
                        difference() {
                            scale([0.6, 1, 1])
                                circle(d=1.4);
                            scale([0.6, 1, 1])
                                circle(d=0.7);
                        }
                // Inner chain link (vertical oval, overlapping)
                translate([5, 0, 0])
                    difference() {
                        scale([0.6, 1, 1])
                            circle(d=1.4);
                        scale([0.6, 1, 1])
                            circle(d=0.7);
                    }
                // Innermost chain link (horizontal oval)
                translate([4.25, 0, 0])
                    rotate([0, 0, 90])
                        difference() {
                            scale([0.6, 1, 1])
                                circle(d=1.4);
                            scale([0.6, 1, 1])
                                circle(d=0.7);
                        }
            }
        }

        // Flying disc approaching (angled view from above)
        // translate([14, 0, 0]) {
        //     circle(d=6);
        // }
        // translate([18, 0, 0]) {
        //     difference() {
        //         circle(d=6);
        //         circle(d=4.5);
        //     }
        // }
        // translate([22, 0, 0]) {
        //     difference() {
        //         circle(d=6);
        //         circle(d=4.5);
        //     }
        // }
        // translate([26, 0, 0]) {
        //     difference() {
        //         circle(d=6);
        //         circle(d=4.5);
        //     }
        // }
    }
}

// ===== 2D TEXT BANNER =====
module text_banner_2d() {
    // Trophy category - flat centered text (customize this for each trophy)
    translate([0, 0, 0])
        text("PUTTING",
             size=4.5,
             font="Arial:style=Bold",
             halign="center",
             valign="center");

    translate([0, -7, 0])
        text("COMPETITION",
             size=4.5,
             font="Arial:style=Bold",
             halign="center",
             valign="center");

    translate([0, -14, 0])
        text("WINNER",
             size=4.5,
             font="Arial:style=Bold",
             halign="center",
             valign="center");
}

// ===== DECORATIVE RINGS =====
module decorative_rings() {
    ring_width = 1.5;  // Width of each ring

    // Outer ring (outside the text) - scaled for 75mm disc
    difference() {
        circle(d=70);
        circle(d=70 - ring_width);
    }

    // Inner ring (inside the text) - scaled for 75mm disc
    difference() {
        circle(d=57);
        circle(d=57 - ring_width);
    }
}

// Dotted circle helper
module dotted_circle(radius=35, dot_size=1, num_dots=60) {
    for (i = [0:num_dots-1]) {
        angle = i * (360 / num_dots);
        rotate([0, 0, angle])
            translate([0, radius, 0])
                circle(d=dot_size);
    }
}

// ===== CIRCULAR TEXT =====
module circular_text() {
    // Text that curves around the edge
    text_string = "KING 2025 ";  // Space at end for separation
    radius = 31.5;    // Distance from center (scaled for 75mm disc)
    text_size = 3;

    // Calculate total arc and spacing
    num_chars = len(text_string);
    num_repeats = 8;  // How many times to repeat around circle (reduced for more spacing)
    total_chars = num_chars * num_repeats;
    angle_per_char = 360 / total_chars;

    // Place each character around the circle
    for (repeat = [0:num_repeats-1]) {
        for (i = [0:num_chars-1]) {
            char_angle = (repeat * num_chars + i) * angle_per_char;
            rotate([0, 0, char_angle])  // Rotate position around circle
                translate([0, radius, 0])  // Move out to edge
                    rotate([0, 0, 180])  // Flip letter to read correctly from outside
                        text(text_string[i],
                             size=text_size,
                             font="Arial:style=Bold",
                             halign="center",
                             valign="center");
        }
    }
}

// 5-pointed star
module star_5point(size=3) {
    points = 5;
    outer_r = size;
    inner_r = size * 0.4;

    star_points = [
        for (i = [0:points*2-1])
            let (
                angle = i * 360 / (points * 2) - 90,
                r = (i % 2 == 0) ? outer_r : inner_r
            )
            [r * cos(angle), r * sin(angle)]
    ];

    polygon(star_points);
}

// Laurel branch for wreath
module laurel_branch() {
    for (i = [0:4]) {
        translate([i * 1.5, i * 2, 0])
            rotate([0, 0, -15 * i])
                ellipse(2, 1);
        translate([i * 1.5, i * 2, 0])
            rotate([0, 0, 15 * i])
                mirror([1, 0, 0])
                    ellipse(2, 1);
    }
}

// Ellipse helper for leaves
module ellipse(width, height) {
    scale([width, height, 1])
        circle(d=1);
}

// Rosette decoration (circular flower pattern)
module rosette(size=4) {
    num_petals = 7;

    // Center circle
    circle(d=size * 0.2);

    // Petals radiating outward
    for (i = [0:num_petals-1]) {
        angle = i * (360 / num_petals);
        rotate([0, 0, angle])
            translate([size * 0.35, 0, 0])
                ellipse(size * 0.4, size * 0.25);
    }
}

// Floral accent - flowers arranged in arc from large to small
module floral_accent() {
    arc_radius = -10;

    // Largest flower
    translate([arc_radius * cos(-30), arc_radius * sin(5), 0])
    translate([0, -3.5, 5])
        rosette(size=5);

    // Larger flower
    translate([arc_radius * cos(-10), arc_radius * sin(-10), 0])
    translate([0, -1, -10])
        rosette(size=4);

    // Medium flowers
    translate([arc_radius * cos(-30), arc_radius * sin(-30), 0])
        rotate([0, 0, -30])
            rosette(size=3.2);

    // Smaller flowers
    translate([arc_radius * cos(-50), arc_radius * sin(-50), 0])
        rotate([0, 0, -50])
            rosette(size=2.5);

    // Smallest flowers
    translate([arc_radius * cos(-65), arc_radius * sin(-65), 0])
        rotate([0, 0, -65])
            rosette(size=2);
}
