// Single Gang Electrical Box (New Work Style)
// Standard dimensions for US single-gang box

// Main dimensions (in mm)
box_width = 50.8;        // 2 inches
box_height = 101.6;      // 4 inches
box_depth = 63.5;        // 2.5 inches (standard depth)
wall_thickness = 2;      // Wall thickness

// Mounting tabs
tab_width = 12.7;        // 0.5 inches
tab_thickness = 1.5;
tab_extension = 19;      // Extension beyond box

// Mounting holes
mounting_hole_diameter = 4.5;  // For #6-32 screws
mounting_hole_spacing = 83.3;  // Standard 3.281 inches center-to-center

// Knockout holes (cable entry)
knockout_diameter = 19;
knockout_offset = 15;

module single_gang_box() {
    difference() {
        union() {
            // Main box body
            cube([box_width, box_height, box_depth]);

            // Top mounting tab
            translate([-tab_extension, (box_height - tab_width)/2, 0])
                cube([tab_extension, tab_width, tab_thickness]);

            // Bottom mounting tab
            translate([box_width, (box_height - tab_width)/2, 0])
                cube([tab_extension, tab_width, tab_thickness]);
        }

        // Hollow out the interior
        translate([wall_thickness, wall_thickness, wall_thickness])
            cube([box_width - 2*wall_thickness,
                  box_height - 2*wall_thickness,
                  box_depth]);

        // Top mounting hole
        translate([-tab_extension/2, box_height/2 - mounting_hole_spacing/2, -1])
            cylinder(d=mounting_hole_diameter, h=tab_thickness + 2, $fn=30);

        // Bottom mounting hole
        translate([box_width + tab_extension/2, box_height/2 + mounting_hole_spacing/2, -1])
            cylinder(d=mounting_hole_diameter, h=tab_thickness + 2, $fn=30);

        // Cable knockout holes on sides
        // Left side
        translate([-1, box_height - knockout_offset, box_depth/2])
            rotate([0, 90, 0])
            cylinder(d=knockout_diameter, h=wall_thickness + 2, $fn=40);

        // Right side
        translate([box_width - wall_thickness - 1, knockout_offset, box_depth/2])
            rotate([0, 90, 0])
            cylinder(d=knockout_diameter, h=wall_thickness + 2, $fn=40);

        // Back knockout
        translate([box_width/2, box_height/2, -1])
            cylinder(d=knockout_diameter, h=wall_thickness + 2, $fn=40);
    }
}

// Render the box
single_gang_box();
