// PSU Enclosure with Rack Mounting Bracket
$fn = 120;

// Enclosure dimensions
enclosure_length = 254;  // X - long side
enclosure_width  = 123;  // Y
enclosure_height = 43;   // Z

// Mounting bracket parameters
bracket_thickness = 8;
bracket_flange_height = 30;      // how far the flange extends downward from bottom
bracket_hole_diameter = 6.35;    // 1/4" for standard rack screws (M6 / 10-32)

// EIA-310 standard rack hole spacing
// Holes along the flange length, spaced to match rack rail pattern
rack_hole_spacing_a = 15.875;    // 5/8"
rack_hole_spacing_b = 15.875;    // 5/8"
rack_hole_group = rack_hole_spacing_a + rack_hole_spacing_b;  // 31.75mm per group

// EIA-310 repeating hole pattern: 15.875, 15.875, 12.7 (= 44.45mm per U)
rack_hole_pattern = [15.875, 15.875, 12.7];
rack_u_groups = 5;               // number of U-groups of holes to generate

// Center the enclosure and add bracket
module enclosure() {
  difference() {
    cube([enclosure_length, bracket_thickness, enclosure_height]);

    translate([22.5, 20, 2.25+bracket_thickness+10.75])
    rotate([90, 0, 0])
      psu_mounting_holes();

    // Segment cuts at each U-group boundary (aligned with flange cuts)
    for (u = [0 : rack_u_groups]) {
      cx = (enclosure_length - rack_u_groups * 44.45) / 2 + u * 44.45 - 6.35;
      translate([cx - 1.5, -0.1, -0.1])
        cube([3, bracket_thickness + 0.2, enclosure_height + 0.2]);
    }
  }
}

module psu_mounting_holes() {
  union() {
    cylinder(h = enclosure_height, r = 2.25);
    translate([150, 0, 0])
    cylinder(h = enclosure_height, r = 2.25);
  }
}

module mounting_bracket() {
    // Build EIA-310 hole positions along X
    // 5 U-groups = 16 holes spanning 222.25mm, centered on the 254mm length
    total_span = rack_u_groups * 44.45;
    start_x = (enclosure_length - total_span) / 2;

    difference() {
        // Horizontal flange extending outward from the bottom edge
        translate([0, 0, -bracket_thickness])
            cube([enclosure_length, bracket_flange_height, bracket_thickness]);

        // Screw holes at EIA-310 spacing
        for (u = [0 : rack_u_groups - 1]) {
            u_offset = start_x + u * 44.45;
            positions = [
                u_offset,
                u_offset + rack_hole_pattern[0],
                u_offset + rack_hole_pattern[0] + rack_hole_pattern[1]
            ];
            for (x = positions) {
                translate([x, bracket_flange_height / 4, -bracket_thickness - 0.1])
                    cylinder(h = bracket_thickness + 0.2, d = bracket_hole_diameter);
            }
        }
        // Final hole to close the last group
        translate([
            start_x + rack_u_groups * 44.45,
            bracket_flange_height / 4,
            -bracket_thickness - 0.1
        ])
            cylinder(h = bracket_thickness + 0.2, d = bracket_hole_diameter);

        // Segment cuts at each U-group boundary, centered in the 12.7mm gap
        for (u = [0 : rack_u_groups]) {
            cx = start_x + u * 44.45 - 6.35;  // midpoint of 12.7mm inter-group gap
            translate([cx - 1.5, -0.1, -bracket_thickness - 0.1])
                cube([3, bracket_flange_height + 0.2, bracket_thickness + 0.2]);
        }
    }
}

// Centered enclosure
translate([-enclosure_length / 2, 12, -enclosure_height / 2])
    enclosure();

// Bracket on the long side (+Y face)
translate([-enclosure_length / 2, -10, -enclosure_height / 2+bracket_thickness])
    mounting_bracket();
