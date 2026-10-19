// Rack Sovol Display Mount
// Single post clips into vented rack faceplate,
// Sovol display bracket mounts via keyhole slots on its left side
//
// Faceplate vertical (XZ plane) at Y=0
// Post extends into rack (+Y)
// Sovol bracket's left side faces +X, slides up (+Z) to lock onto pegs

$fn = 30;

/* [Faceplate Slots] */
slot_w = 20;
slot_h = 2.75;
panel_t = 1.5;
gap_x = 6.4;
gap_y = 3.45;
clearance = 0.2;
tab_barb = 0.4;

/* [Sovol Keyhole Mounts] */
kh_large = 11;          // large circle diameter
kh_small = 6.5;         // small circle diameter
kh_lower_gap = 37.5;    // between lower two keyholes (Y axis on post)
kh_upper_rise = 20.5;   // upper keyhole above lower pair (Z axis)
sovol_wall_t = 2;       // sovol bracket side wall thickness

/* [Mount Parameters] */
wall = 5;
post_depth = 80;        // post extends this far into rack (Y)
post_width = 20;        // post width (X), matches tab_w

/* [Derived] */
tab_w = slot_w - clearance * 2;
tab_h = slot_h - clearance * 2;

peg_shaft_d = kh_small - 0.5;
peg_head_d = kh_large - 0.5;
peg_head_t = 1.5;
peg_shaft_l = sovol_wall_t + 0.5;

// Post height: enough to cover keyhole pattern + walls
post_height = kh_upper_rise + kh_large / 2 + wall * 2;

// Keyhole peg Y positions on post (lower pair + upper)
kh_y_start = (post_depth - kh_lower_gap) / 2;

module pill_2d(w, h) {
    r = h / 2;
    hull() {
        translate([r, r]) circle(r=r);
        translate([w - r, r]) circle(r=r);
    }
}

// Tab (same as rack-display-mount.scad)
module tab() {
    difference() {
        translate([-(tab_barb), -1.6, (tab_barb * 4)])
            rotate([-90, 0, 0])
                linear_extrude(1.6)
                    pill_2d(tab_w + tab_barb * 2, tab_h + tab_barb * 4);
        translate([-(tab_w / 2), -2, -4])
            rotate([45, 0, 0])
                cube([tab_w * 2, tab_h, 2]);
    }
    rotate([-90, 0, 0])
        linear_extrude(panel_t)
            pill_2d(tab_w, tab_h);
}

// Keyhole peg: shaft through bracket wall, head at tip retains bracket
module keyhole_peg() {
    // Shaft (goes through sovol bracket wall)
    cylinder(d=peg_shaft_d, h=peg_shaft_l);
    // Head at tip (catches outside of bracket wall)
    translate([0, 0, peg_shaft_l])
        cylinder(d=peg_head_d, h=peg_head_t);
}

module post() {
    // --- Spine against faceplate ---
    peg_margin_spine = kh_large / 2 + 5;
    spine_height = kh_large / 2 + wall + kh_upper_rise + peg_margin_spine;
    translate([0, panel_t, 0])
        cube([post_width, wall, spine_height]);

    // --- Tab into faceplate slot ---
    translate([0, 0, spine_height])
        tab();

    // --- Horizontal post into rack ---
    translate([0, panel_t, 0])
        cube([post_width, post_depth, wall]);

    // --- Angled side wall (+X face) follows peg line ---
    peg_margin = kh_large / 2 + 5;
    upper_z = kh_large / 2 + wall + kh_upper_rise + peg_margin;
    lower_rear_y = kh_y_start + kh_lower_gap + peg_margin;
    lower_rear_z = kh_large / 2 + wall + peg_margin;

    translate([post_width - wall, panel_t, 0])
        hull() {
            cube([wall, post_depth, 0.1]);              // bottom full depth
            cube([wall, 0.1, upper_z]);                 // front full height
            translate([0, lower_rear_y, 0])
                cube([wall, 0.1, lower_rear_z]);        // rear peg height
        }

    // --- Keyhole pegs on +X face ---
    // Pegs stick out in +X from post's right face
    // On the YZ face: Y = depth into rack, Z = height
    // Sovol bracket slides +Z to lock (large hole at bottom of each keyhole)

    // Lower front peg
    translate([post_width, panel_t + kh_y_start, kh_large / 2 + wall])
        rotate([0, 90, 0])
            keyhole_peg();

    // Lower rear peg
    translate([post_width, panel_t + kh_y_start + kh_lower_gap, kh_large / 2 + wall])
        rotate([0, 90, 0])
            keyhole_peg();

    // Upper peg (same Y as lower front)
    translate([post_width, panel_t + kh_y_start, kh_large / 2 + wall + kh_upper_rise])
        rotate([0, 90, 0])
            keyhole_peg();
}

post();

// Reference: Sovol bracket footprint (transparent)
%translate([
    post_width + peg_head_t + sovol_wall_t,
    panel_t + (post_depth - 102) / 2,
    0
])
    cube([121.25, 102, post_height]);
