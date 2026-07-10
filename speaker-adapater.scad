// Speaker Adapter: 6.5" speaker to 7" cavity
// All measurements in mm

$fn = 180; // Smooth circles

// Speaker dimensions (convert inches to mm)
speaker_diameter = 6.5 * 25.4;  // 165.1mm
cavity_diameter = 7 * 25.4;      // 177.8mm

// Mounting holes
speaker_6_5_mounting_circle_diameter = 155; // 6.5" speaker mounting holes
speaker_7_mounting_circle_diameter = 170;   // 7" cavity mounting holes
speaker_mounting_hole_diameter = 4.5;
num_mounting_holes = 4;

// Adapter dimensions
adapter_thickness = 12;          // Extra thick for maximum sturdiness
adapter_outer_diameter = cavity_diameter - 0.5;   // Tight fit for cavity (177.3mm)
lip_width = 20;                  // Extra wide lip for maximum support

// Speaker inset dimensions
inset_depth = 6;                 // How deep the speaker sits into the adapter
inset_diameter = 167.6;          // Diameter where outer ring meets inner ring
adapter_inner_diameter = inset_diameter - 20; // 10mm ring width from inset to inner cutout

module mounting_holes() {
    // 6.5" speaker mounting holes
    for (i = [0:num_mounting_holes-1]) {
        angle = i * (360 / num_mounting_holes);
        rotate([0, 0, angle])
        translate([speaker_6_5_mounting_circle_diameter/2, 0, -1])
        cylinder(h = adapter_thickness + 2, d = speaker_mounting_hole_diameter);
    }

    // 7" cavity mounting holes (offset by 45 degrees to avoid overlap)
    for (i = [0:num_mounting_holes-1]) {
        angle = i * (360 / num_mounting_holes) + 45;
        rotate([0, 0, angle])
        translate([speaker_7_mounting_circle_diameter/2, 0, -1])
        cylinder(h = adapter_thickness + 2, d = speaker_mounting_hole_diameter);
    }
}

module adapter_ring() {
    difference() {
        // Main ring body
        cylinder(h = adapter_thickness, d = adapter_outer_diameter);

        // Speaker inset recess (from top)
        translate([0, 0, adapter_thickness - inset_depth])
        cylinder(h = inset_depth + 1, d = inset_diameter);

        // Inner cutout for speaker cone
        translate([0, 0, -1])
        cylinder(h = adapter_thickness + 2, d = adapter_inner_diameter);

        // Mounting holes for speaker
        mounting_holes();
    }
}

// Render the adapter
adapter_ring();
