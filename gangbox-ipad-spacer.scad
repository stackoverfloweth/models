screw_gap=84;
spacer_depth=40;
gang_box_width = 74.5;
gang_box_height = 50.5;
ipad_width=134.75;
ipad_height=195.430;

difference() {
  union() {
    import("/Users/evansutherland/Downloads/iPad+Mini+6+Magnetic+Wall+Mount+Block+2+v4.stl");

    translate([0, 0, -spacer_depth/2-4])
    rounded_cube([ipad_width, ipad_height, spacer_depth-6], 12, true);
  }

    // screw holes
    translate([42, 25.5, -50])
    cylinder(h=100, d=3.5, $fn=100);

    translate([42-screw_gap, 25.5, -50])
    cylinder(h=100, d=3.5, $fn=100);

    translate([42, 0, -50])
    cylinder(h=100, d=3.5, $fn=100);

    translate([42-screw_gap, 0, -50])
    cylinder(h=100, d=3.5, $fn=100);

    // screw passthrough
    translate([42, 25.5, -36])
    cylinder(h=50, d=8, $fn=100);

    translate([42-screw_gap, 25.5, -36])
    cylinder(h=50, d=8, $fn=100);

    translate([42, 0, -36])
    cylinder(h=50, d=8, $fn=100);

    translate([42-screw_gap, 0, -36])
    cylinder(h=50, d=8, $fn=100);

    // cable passthrough
    translate([0, 0, -spacer_depth/2-6])
    rounded_cube([60, 100, 52], 12, true);
}

module rounded_cube(size, radius = 1, center = false, fn = 180) {
    // Handle both single value and vector for size (like cube() does)
    dimensions = is_list(size) ? size : [size, size, size];
    x = dimensions[0];
    y = dimensions[1];
    z = dimensions[2];

    // Clamp radius to not exceed half the smallest dimension
    max_radius = min(x, y, z) / 2;
    actual_radius = min(radius, max_radius);

    // Calculate translation offset if center = true
    translate_offset = center ? [-x/2, -y/2, -z/2] : [0, 0, 0];

    translate(translate_offset) {
        hull() {
            // Create cylinders at each corner of the cube
            // Bottom left corner (vertical cylinder along Z)
            translate([actual_radius, actual_radius, 0])
                cylinder(r = actual_radius, h = z, $fn = fn);
            // Bottom right corner
            translate([x - actual_radius, actual_radius, 0])
                cylinder(r = actual_radius, h = z, $fn = fn);
            // Top left corner
            translate([actual_radius, y - actual_radius, 0])
                cylinder(r = actual_radius, h = z, $fn = fn);
            // Top right corner
            translate([x - actual_radius, y - actual_radius, 0])
                cylinder(r = actual_radius, h = z, $fn = fn);
        }
    }
}