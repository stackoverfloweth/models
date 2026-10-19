// Rack Display Mount - Shelf Brackets
// Two supports clip into vertical vented faceplate,
// extend back into rack to hold display face-up
//
// Faceplate is in XZ plane at Y=0 (front face at Y=0, back at Y=panel_t)
// Rack interior extends in +Y direction
// Tabs pass through slots; bracket body is behind panel

/* [Display] */
display_w = 132;    // width (X, along faceplate)
display_d = 86;    // depth (Y, into rack)
display_h = 8.5;     // thickness (Z)

/* [Faceplate Slots] */
slot_w = 20;            // slot width (pill shape, horizontal)
slot_h = 2.75;          // slot height (vertical)
panel_t = 1.5;          // panel thickness (Y)
gap_x = 6.4;            // horizontal gap between slots
gap_y = 3.45;           // vertical gap between slots

/* [Bracket Parameters] */
wall = 5;             // wall thickness
shelf_depth = 105;      // shelf extends into rack (Y)
lip = 2.5;              // lip height to retain display
rise = 20;              // raise back end to angle the display
clearance = 0.2;        // clearance per side for tabs
num_tab_rows = 1;       // slot rows to engage (Z direction)
tab_barb = 0.4;         // barb overhang on front face for retention

/* [Derived] */
pitch_z = slot_h + gap_y;  // 6.2mm vertical pitch on faceplate
tab_w = slot_w - clearance * 2;
tab_h = slot_h - clearance * 2;

// Bracket body spans from top tab to bottom tab + walls
body_height = (num_tab_rows - 1) * pitch_z + slot_h + wall * 2;

$fn = 30;

module pill_2d(w, h) {
    r = h / 2;
    hull() {
        translate([r, r]) circle(r=r);
        translate([w - r, r]) circle(r=r);
    }
}

// Tab: thin pill that passes through slot (Y axis)
// Origin at front face of panel, centered on slot
module tab() {
    // Front barb (sits against front face of panel, wider than slot)
    difference() {
      translate([-(tab_barb), -1.6, (tab_barb*4)])
          rotate([-90, 0, 0])
              linear_extrude(1.6)
                  pill_2d(tab_w + tab_barb * 2, tab_h + tab_barb * 4);
      translate([-(tab_w/2), -2, -4])
        rotate([45, 0, 0])
          cube([tab_w*2, tab_h, 2]);
    }

    // Through-slot portion
    rotate([-90, 0, 0])
        linear_extrude(panel_t)
            pill_2d(tab_w, tab_h);
}

module bracket() {
    spine_height = rise + wall + wall;

    // Side profile as a single polygon (depth x height), extruded along X
    // rotate(120, [1,1,1]) maps: polygon X→world Y, polygon Y→world Z, extrusion Z→world X
    outer = [
        [0, 0],                                        // bottom front
        [shelf_depth, 0],                              // bottom rear
        [shelf_depth, wall + display_h + wall],        // top rear lip outer
        [shelf_depth - wall, wall + display_h + wall], // top rear lip inner
        [shelf_depth - wall, wall + wall],             // shelf surface at rear
        [0, spine_height],                             // shelf surface / spine top at front
    ];
    hole = [
        [wall, wall],                    // hole bottom front
        [shelf_depth - wall * 2, wall],  // hole bottom rear
        [shelf_depth - wall * 2, wall + 1], // hole top rear
        [wall, rise],                    // hole top front
    ];
    translate([0, panel_t, 0])
    rotate(120, [1, 1, 1])
    linear_extrude(tab_w)
    polygon(
        points = concat(outer, hole),
        paths = [[0,1,2,3,4,5], [6,7,8,9]]
    );

    translate([0, 0, spine_height])
        tab();
}

// --- Layout ---

// Left bracket
bracket();

// Right bracket (mirrored)
translate([display_w + tab_w * 2, 0, 0])
    mirror([1, 0, 0])
        bracket();

// Reference display (transparent, remove for printing)
shelf_angle = atan2(rise, shelf_depth);
%translate([tab_w, panel_t + wall, wall + wall + rise])
    rotate([shelf_angle, 0, 0])
        cube([display_w, display_d, display_h]);
