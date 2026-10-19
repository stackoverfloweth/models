// Klipper Camera + HDMI Converter Adapter
// Camera mounting holes: 28.5mm square pattern
// HDMI converter mounting holes: 12.5mm x 21mm pattern
// Hardware: M2.5 screws

$fn = 40;

// --- Parameters ---

// Both boards share the same PCB layout
board_hole_x = 21;              // hole spacing along X
board_hole_y = 12.5;            // hole spacing along Y
board_x = 25;                   // approx board dimension
board_y = 16;                   // approx board dimension

// Hardware
standoff_d = 5.5;              // standoff outer diameter
standoff_h = 7;                // height above plate for HDMI board clearance
pin_d = 1.8;                   // heat-stake pin diameter
pin_h = 4;                     // pin height above standoff (melt down to secure board)

// Plate
plate_thickness = 2.5;
plate_corner_r = 2;


// Mounting bracket (step to second plate)
step_gap = 20;                 // vertical distance between plates
mount_plate_x = 47;           // depth of the mounting plate
end_panel_height = 8;          // how far the end panel extends up

// Plate sizing - single board footprint
plate_x = board_hole_x + 12;
plate_y = board_hole_y + 12;

// Joint parameters (hinge style)
joint_bolt_d = 3.2;            // bolt/pin clearance
joint_knuckle_d = 7;           // outer diameter of knuckle
joint_knuckles = 5;            // total knuckle count (odd = part1 gets ends)
joint_clearance = 0.2;         // printing tolerance

// --- Modules ---

module rounded_rect(x, y, h, r) {
    hull() {
        for (dx = [-1, 1], dy = [-1, 1])
            translate([dx * (x/2 - r), dy * (y/2 - r), 0])
                cylinder(r = r, h = h);
    }
}

// Hinge joint - interlocking knuckles along Y, bolt as pin
yellow_joint_x = -(plate_x/2 + plate_thickness/2);
yellow_joint_z = step_gap + plate_thickness + joint_knuckle_d/2 + 0.5;  // above yellow wall
orange_joint_x = -(plate_x/2 + plate_thickness + joint_knuckle_d/2) + 10;  // left of orange plate
orange_joint_z = step_gap + plate_thickness/2;  // at orange plate edge
knuckle_len = plate_y / joint_knuckles;

// Yellow knuckles (part1) - on top of yellow wall + stem down
module hinge_knuckles_yellow() {
    yellow_wall_top = step_gap + plate_thickness;
    difference() {
        union() {
            for (i = [0 : joint_knuckles - 1])
                if (i % 2 == 0) {
                    translate([yellow_joint_x, -plate_y/2 + i * knuckle_len, yellow_joint_z])
                        rotate([-90, 0, 0])
                            cylinder(d = joint_knuckle_d, h = knuckle_len);
                    // Stem down to yellow wall
                    translate([yellow_joint_x - plate_thickness/2, -plate_y/2 + i * knuckle_len, yellow_wall_top])
                        cube([plate_thickness, knuckle_len, yellow_joint_z - yellow_wall_top]);
                }
        }
        translate([yellow_joint_x, -plate_y/2 - 0.1, yellow_joint_z])
            rotate([-90, 0, 0])
                cylinder(d = joint_bolt_d, h = plate_y + 0.2);
    }
}

// Orange knuckles (part2) - left of orange plate + stem right
module hinge_knuckles_orange() {
    orange_plate_edge = -(plate_x/2 + plate_thickness);
    difference() {
        union() {
            for (i = [0 : joint_knuckles - 1])
                if (i % 2 == 1) {
                    translate([orange_joint_x, -plate_y/2 + i * knuckle_len, orange_joint_z])
                        rotate([-90, 0, 0])
                            cylinder(d = joint_knuckle_d, h = knuckle_len);
                    // Stem to orange plate
                    translate([orange_plate_edge, -plate_y/2 + i * knuckle_len, orange_joint_z - plate_thickness/2])
                        cube([orange_joint_x - orange_plate_edge, knuckle_len, plate_thickness]);
                }
        }
        translate([orange_joint_x, -plate_y/2 - 0.1, orange_joint_z])
            rotate([-90, 0, 0])
                cylinder(d = joint_bolt_d, h = plate_y + 0.2);
    }
}

// Part 1: Camera assembly (red, green, blue, yellow + tabs)
module part1() {
    // A: Base plate (RED)
    color("red")
        hull() {
            for (dy = [-1, 1])
                translate([plate_x/2 - plate_corner_r, dy * (plate_y/2 - plate_corner_r), 0])
                    cylinder(r = plate_corner_r, h = plate_thickness);
            translate([-plate_x/2, -plate_y/2, 0])
                cube([0.01, plate_y, plate_thickness]);
        }

    // B: Camera standoffs + pins below plate (GREEN)
    color("green")
        for (dx = [-1, 1], dy = [-1, 1])
            translate([dx * board_hole_x/2, dy * board_hole_y/2, 0]) {
                translate([0, 0, -standoff_h])
                    cylinder(d = standoff_d, h = standoff_h);
                translate([0, 0, -(standoff_h + pin_h)])
                    cylinder(d = pin_d, h = pin_h);
            }

    // C: HDMI converter standoffs + pins above plate (BLUE) — same holes
    color("blue")
        for (dx = [-1, 1], dy = [-1, 1])
            translate([dx * board_hole_x/2, dy * board_hole_y/2, 0]) {
                cylinder(d = standoff_d, h = plate_thickness + standoff_h);
                translate([0, 0, plate_thickness + standoff_h])
                    cylinder(d = pin_d, h = pin_h);
            }

    // D: Vertical wall (YELLOW) - stops at joint line
    color("yellow")
        translate([-(plate_x/2 + plate_thickness), -plate_y/2, 0])
            cube([plate_thickness, plate_y, step_gap + plate_thickness]);

    // Hinge knuckles on top of yellow
    color("yellow")
        hinge_knuckles_yellow();
}

// Part 2: Mount assembly (orange, purple + slots)
module part2() {
    // E: Mounting plate (ORANGE)
    color("orange")
        translate([0, 0, step_gap])
            hull() {
                translate([-plate_x/2, -plate_y/2, 0])
                    cube([0.01, plate_y, plate_thickness]);
                for (dy = [-1, 1])
                    translate([-(plate_x/2 + plate_thickness) - mount_plate_x + plate_corner_r, dy * (plate_y/2 - plate_corner_r), 0])
                        cylinder(r = plate_corner_r, h = plate_thickness);
            }

    // F: End panel (PURPLE) - narrower with rounded free edges
    purple_h = plate_thickness + end_panel_height;
    purple_w = plate_y * 2;  // wider than orange
    purple_x = -(plate_x/2 + plate_thickness) - mount_plate_x;
    color("purple")
        translate([purple_x, 0, step_gap])
            hull() {
                // Bottom edge: square, flush with orange
                translate([0, -purple_w/2, 0])
                    cube([plate_thickness, purple_w, 0.01]);
                // Top edge: rounded corners
                for (dy = [-1, 1])
                    translate([plate_thickness/2, dy * (purple_w/2 - plate_corner_r), purple_h - plate_corner_r])
                        rotate([0, 90, 0])
                            cylinder(r = plate_corner_r, h = plate_thickness, center = true);
            }
}

// Mount hole parameters
purple_h = plate_thickness + end_panel_height;
purple_z_center = step_gap + purple_h - plate_corner_r - 2.85/2 - 0.5;

module part2_with_holes() {
    difference() {
        union() {
            part2();
            // Hinge knuckles hanging below orange
            color("orange")
                hinge_knuckles_orange();
        }

        // Countersunk screw holes through purple + orange
        for (y_pos = [-21, -15, -9, -3, 3, 9, 15, 21])
            translate([
                -(plate_x/2 + plate_thickness) - mount_plate_x - 0.1,
                y_pos,
                purple_z_center
            ])
                rotate([0, 90, 0]) {
                    cylinder(d = 2.85, h = plate_thickness * 2 + mount_plate_x + 0.2);
                    translate([0, 0, plate_thickness - (5.75 - 2.85) / 2])
                        cylinder(d1 = 2.85, d2 = 5.75, h = (5.75 - 2.85) / 2);
                }
    }
}

// Printable hinge bolt
bolt_shaft_d = joint_bolt_d - joint_clearance * 2;
bolt_shaft_len = plate_y + 2;
bolt_head_d = joint_knuckle_d;
bolt_head_h = 3;

module hinge_bolt() {
    cylinder(d = bolt_head_d, h = bolt_head_h);
    translate([0, 0, bolt_head_h])
        cylinder(d = bolt_shaft_d, h = bolt_shaft_len);
}

// Print-ready versions (clean unions, no colors)
module print_part1() {
    union() {
        color("red")
        hull() {
            for (dy = [-1, 1])
                translate([plate_x/2 - plate_corner_r, dy * (plate_y/2 - plate_corner_r), 0])
                    cylinder(r = plate_corner_r, h = plate_thickness);
            translate([-plate_x/2, -plate_y/2, 0])
                cube([0.01, plate_y, plate_thickness]);
        }
        color("green")
        for (dx = [-1, 1], dy = [-1, 1])
            translate([dx * board_hole_x/2, dy * board_hole_y/2, 0]) {
                translate([0, 0, -standoff_h])
                    cylinder(d = standoff_d, h = standoff_h);
                translate([0, 0, -(standoff_h + pin_h)])
                    cylinder(d = pin_d, h = pin_h);
                cylinder(d = standoff_d, h = plate_thickness + standoff_h);
                translate([0, 0, plate_thickness + standoff_h])
                    cylinder(d = pin_d, h = pin_h);
            }
        color("purple")
        translate([-(plate_x/2 + plate_thickness), -plate_y/2, 0])
            cube([plate_thickness, plate_y, step_gap + plate_thickness]);
        hinge_knuckles_yellow();
    }
}

module print_part2() {
    part2_with_holes();
}

// === PREVIEW MODE (colored, separated) ===
// part1();
// translate([0, 0, 25]) part2_with_holes();
// translate([40, 0, 0]) color("white") hinge_bolt();

// === PRINT MODE (uncomment one at a time) ===
print_part1();
// print_part2();
// hinge_bolt();
