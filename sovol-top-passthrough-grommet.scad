$fn = 100;

// Match the passthrough opening dimensions
opening_width = 18;    // x - from length in main file
opening_height = 21.5; // z - from gap in main file
wall = 12;              // y - depth of the passthrough wall

// Grommet dimensions
tolerance = 0.3;       // shrink outer size for fit
grommet_w = opening_width - tolerance;
grommet_h = opening_height - tolerance;
grommet_depth = wall - 0.5; // slightly thinner than wall

// Cable hole
cable_dia = 7;

// Slit for mid-cable installation (cuts from bottom edge to hole)
slit_width = 2;

// Lip/flange to prevent push-through
lip = 1.5;
lip_depth = 1.5;

difference() {
    union() {
        // Main grommet body
        cube([grommet_w, grommet_depth, grommet_h], center = true);

        // Lip on one face
        translate([0, -(grommet_depth + lip_depth) / 2, 0])
        cube([grommet_w, lip_depth, grommet_h], center = true);
    }

    // Cable hole (through Y axis)
    rotate([90, 0, 0])
    cylinder(d = cable_dia, h = grommet_depth + lip_depth + 2, center = true);

    // Slit from bottom edge to cable hole for mid-cable install
    translate([0, 0, -(grommet_h / 2 + 1) / 2])
    cube([slit_width, grommet_depth + lip_depth + 2, grommet_h / 2 + 1], center = true);
}
