// todo:
// [x] pi_adapter_holes should be standouts for heat inserts not just holes
// [x] make sure standouts don't go behind adapter_thickness, the lower hole will run into meanwell
// [x] there should be a cable gland hole below the bottom pi_adapter_holes
// [x] there should be a cable gland hole on the top for output cable
// [x] does output cable fit through cable gland?

$fn = 180;
meanwell_width = 115;
meanwell_depth = 30;
meanwell_hole_radius = 2.5;
meanwell_hole_top_offset = 7.5;
meanwell_back_hole_spacing = 50;
meanwell_side_hole_top_offset = 17;
meanwell_adapter_height_overlap = 40;
adapter_meanwell_wiggle_room = 0.5;
adapter_thickness = 2.5;
adapter_width = meanwell_width + adapter_thickness * 2 + adapter_meanwell_wiggle_room * 2;
adapter_depth = meanwell_depth + adapter_thickness * 2 + adapter_meanwell_wiggle_room * 2;

power_cutout_depth = 2;
power_cutout_width = 29;
power_cutout_length = 48;
power_cutout_outside_width = 50;
power_cutout_outside_length = 60;
power_cutout_hole_radius = 1.3;
power_cutout_hole_spacing = 40;

pi_adapter_hole_spacing = 56;
pi_adapter_hole_radius = 1.875;

// M4 knurled heat insert (short bosses so the Pi PSU sits nearly flush)
insert_hole_d = 6.0;
insert_h = 4;
insert_pilot_d = 4.5;
boss_d = 11;
boss_h = 3;

// M16x1.5 cable gland (through-hole + included nut)
gland_hole_d = 16.5;
gland_clearance = 3;

// Stack above the PSU: gland, then lower mount, then upper mount, then lid
pi_gland_z = meanwell_adapter_height_overlap + gland_clearance + gland_hole_d / 2 + 10;
pi_lower_z = pi_gland_z + gland_hole_d / 2 + gland_clearance + boss_d / 2;
pi_upper_z = pi_lower_z + pi_adapter_hole_spacing;
adapter_height = pi_upper_z + boss_d / 2 + adapter_thickness + 3;

power_cutout_position = [
    power_cutout_outside_length / 2 + 4,
    0,
    adapter_height - 44
];

module meanwell_adapter() {
    translate([-adapter_thickness, -adapter_thickness, 0])
    difference() {
        union() {
            cube([adapter_width, adapter_depth, adapter_height]);

            translate(power_cutout_position)
            rotate([90, 0, 0])
                power_cutout();

            pi_adapter_bosses();
        }

        // Hollow wrap; leave a lid for the output gland
        translate([adapter_thickness, adapter_thickness, -0.1])
            cube([
                meanwell_width,
                meanwell_depth,
                adapter_height - adapter_thickness + 0.1
            ]);

        translate([meanwell_width / 2 + adapter_thickness, meanwell_depth + 0.1, meanwell_hole_top_offset])
            meanwell_back_holes();

        translate([0.1, meanwell_side_hole_top_offset + adapter_thickness, meanwell_hole_top_offset])
            meanwell_side_holes();

        translate(power_cutout_position)
        rotate([90, 0, 0])
        union() {
            power_cutout_window();
            power_cutout_screws();
        }

        pi_adapter_insert_holes();
        pi_input_gland_hole();
        pi_output_gland_hole();
    }
}

module pi_adapter_bosses() {
    for (z = [pi_lower_z, pi_upper_z])
        translate([0, adapter_depth / 2, z])
            rotate([0, -90, 0])
                cylinder(d = boss_d, h = boss_h);
}

module pi_adapter_insert_holes() {
    insert_bore = min(insert_h, boss_h + adapter_thickness - 0.8) + 0.2;
    for (z = [pi_lower_z, pi_upper_z])
        translate([-boss_h - 0.1, adapter_depth / 2, z])
            rotate([0, 90, 0]) {
                cylinder(d = insert_hole_d, h = insert_bore);
                translate([0, 0, insert_bore])
                    cylinder(
                        d = insert_pilot_d,
                        h = boss_h + adapter_thickness - insert_bore + 0.4
                    );
            }
}

module pi_input_gland_hole() {
    translate([-1, adapter_depth / 2, pi_gland_z])
        rotate([0, 90, 0])
            cylinder(d = gland_hole_d, h = adapter_thickness + 2);
}

module pi_output_gland_hole() {
    translate([adapter_width + 0.1, adapter_depth / 2, pi_gland_z])
        rotate([0, -90, 0])
            cylinder(d = gland_hole_d, h = adapter_thickness + 2);
}

module power_cutout() {
    top_difference = (power_cutout_outside_width - power_cutout_width) / 2;

    linear_extrude(height = power_cutout_depth)
    polygon(points = [
        [0, -top_difference],
        [power_cutout_outside_length / 2, 0],
        [power_cutout_outside_length / 2, power_cutout_width],
        [0, power_cutout_width + top_difference],
        [-power_cutout_outside_length / 2, power_cutout_width],
        [-power_cutout_outside_length / 2, 0],
    ]);
}

module power_cutout_screws() {
    translate([0, -5.6, 0])
    for (i = [0 : 1]) {
        translate([0, i * power_cutout_hole_spacing, -10])
            cylinder(r = power_cutout_hole_radius, h = 20);
    }
}

module power_cutout_window() {
    translate([-power_cutout_outside_width / 2 + 1, 0, -10])
        cube([power_cutout_length, power_cutout_width, 20]);
}

union() {
    meanwell();
    meanwell_adapter();
}

module meanwell() {
    color("grey")
    %translate([0, 0, 0])
    difference() {
        cube([meanwell_width, meanwell_depth, meanwell_adapter_height_overlap]);

        translate([meanwell_width / 2, meanwell_depth + 0.1, meanwell_hole_top_offset])
            meanwell_back_holes();

        translate([0.1, meanwell_side_hole_top_offset, meanwell_hole_top_offset])
            meanwell_side_holes();

        translate([meanwell_width / 2 - meanwell_width * 0.9 / 2, -0.1, meanwell_adapter_height_overlap - 14 + 0.1])
            cube([meanwell_width * 0.9, 14, 14]);
    }
}

module meanwell_back_holes() {
    for (i = [0 : 1]) {
        translate([i * meanwell_back_hole_spacing - meanwell_back_hole_spacing / 2, 0, -0.1])
            rotate([90, 0, 0])
                cylinder(r = meanwell_hole_radius, h = 1000);
    }
}

module meanwell_side_holes() {
    rotate([0, 90, 0])
        cylinder(r = meanwell_hole_radius, h = 1000);
}
