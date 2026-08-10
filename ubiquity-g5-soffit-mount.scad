// Select which part to render: 0=full, 1/2/3=individual pieces
part = 4;

stl_path = "/Users/evansutherland/Downloads/Bambu+UniFi+G6+Turret+Camera+Soffit+Mount_stls/obj_1_Body1.stl";

// Extension: add 120mm to the long side only
ext = 120;
ext_xy = ext / sqrt(2);

// Model center
cx = 128;
cy = 128;

// Extension cut on arm axis
ext_cut_d = 100;

// Print split cuts along V axis (plain arm sections)
cut1_v = 20;
cut2_v = 170;

// 3/8" dowel pins
dowel_d = 9.525;
dowel_hole_d = dowel_d + 0.3; // holes with print tolerance
dowel_depth = 15;
dowel_length = 28; // slightly shorter than 2x depth for clearance
// Two dowels per joint, spaced across arm width, centered in height
dowel_positions = [[-13, 7.5], [13, 7.5]];

module extended_bracket() {
    union() {
        // Everything up to the extension cut
        intersection() {
            import(stl_path);
            translate([cx, cy, 0])
            rotate([0, 0, 45])
            translate([-500, -500, -1])
                cube([1000, 500 + ext_cut_d, 100]);
        }

        // Long side end piece, shifted outward
        translate([-ext_xy, ext_xy, 0])
        intersection() {
            import(stl_path);
            translate([cx, cy, 0])
            rotate([0, 0, 45])
            translate([-500, ext_cut_d, -1])
                cube([1000, 500, 100]);
        }

        // Fill gap using hull of arm cross-section
        hull() {
            intersection() {
                import(stl_path);
                translate([cx, cy, 0])
                rotate([0, 0, 45])
                translate([-500, ext_cut_d - 1, -1])
                    cube([1000, 2, 100]);
            }
            translate([-ext_xy, ext_xy, 0])
            intersection() {
                import(stl_path);
                translate([cx, cy, 0])
                rotate([0, 0, 45])
                translate([-500, ext_cut_d - 1, -1])
                    cube([1000, 2, 100]);
            }
        }
    }
}

module dowel_holes(v_pos) {
    translate([cx, cy, 0])
    rotate([0, 0, 45])
    for (pos = dowel_positions) {
        translate([pos[0], v_pos, pos[1]])
        rotate([-90, 0, 0])
        translate([0, 0, -dowel_depth])
            cylinder(d=dowel_hole_d, h=2*dowel_depth, $fn=36);
    }
}

module v_slab(v_min, v_max) {
    translate([cx, cy, 0])
    rotate([0, 0, 45])
    translate([-500, v_min, -1])
        cube([1000, v_max - v_min, 100]);
}

module piece(v_min, v_max, has_cut_min, has_cut_max) {
    difference() {
        intersection() {
            extended_bracket();
            v_slab(v_min, v_max);
        }
        if (has_cut_min) dowel_holes(v_min);
        if (has_cut_max) dowel_holes(v_max);
    }
}

if (part == 0) {
    // Full model preview (no dowel holes)
    extended_bracket();
} else if (part == 1) {
    // Short arm + circle (185mm)
    piece(-200, cut1_v, false, true);
} else if (part == 2) {
    // Middle arm section (150mm)
    piece(cut1_v, cut2_v, true, true);
} else if (part == 3) {
    // Long arm end (115mm)
    piece(cut2_v, 300, true, false);
} else if (part == 4) {
    // Dowel pins (print 4x)
    for (i = [0:3]) {
        translate([i * (dowel_d + 5), 0, 0])
            cylinder(d=dowel_d, h=dowel_length, $fn=36);
    }
}
