$fn = 100;

// === Core dimensions ===
gap = 21.5;
length = 18;
width = 10;
pass_depth = 16;
bolt_head = 8.75;
bolt_shaft = 5;

// === Cable guide parameters ===
roller_d = 7;
flare = 4;
recess_clearance = 1;
roller_bore_clearance = 0.4;

// === M3 bolt hardware ===
m3_d = 3;
m3_clearance = 0.3;
m3_head_d = 5.5;
m3_head_h = 3.3;
m3_nut_af = 5.5;       // across flats
m3_nut_h = 2.5;
m3_nut_d = m3_nut_af / cos(30);  // across corners

// === Derived ===
outer_x = length + width * 2;
outer_z = gap + width * 2;
pc = [-19, pass_depth / 2, -outer_z / 2];

tb_roller_len = length - 2;
lr_roller_len = gap - 2;
axle_y_offset = 2;

// Roller global positions
top_pos = [pc[0], pc[1] + axle_y_offset, pc[2] + gap / 2];
bot_pos = [pc[0], pc[1] + axle_y_offset, pc[2] - gap / 2];
left_pos = [pc[0] - length / 2, pc[1] - axle_y_offset, pc[2]];
right_pos = [pc[0] + length / 2, pc[1] - axle_y_offset, pc[2]];

// === Main body ===
difference() {
    union() {
        // Base mounting plate
        color("red")
        translate([-outer_x, 0, 0])
        cube([34 + outer_x, pass_depth, width]);

        // Passthrough tunnel
        translate(pc)
        difference() {
            cube([outer_x, pass_depth, outer_z], center = true);
            cube([length, pass_depth + 1, gap], center = true);

            // Flared entries
            for (ys = [-1, 1])
                translate([0, ys * pass_depth / 2, 0])
                hull() {
                    cube([length + flare * 2, 0.01, gap + flare * 2], center = true);
                    translate([0, -ys * flare, 0])
                        cube([length, 0.01, gap], center = true);
                }

            // Top/bottom roller pockets
            for (zs = [-1, 1])
                translate([0, axle_y_offset, zs * gap / 2])
                rotate([0, 90, 0])
                    cylinder(d = roller_d + recess_clearance,
                             h = tb_roller_len + recess_clearance, center = true);

            // Left/right roller pockets
            for (xs = [-1, 1])
                translate([xs * length / 2, -axle_y_offset, 0])
                    cylinder(d = roller_d + recess_clearance,
                             h = lr_roller_len + recess_clearance, center = true);
        }
    }

    // Mounting bolt
    translate([24, pass_depth / 2, 3])
        cylinder(d = bolt_head, h = 7);
    translate([24, pass_depth / 2, 0])
        cylinder(d = bolt_shaft, h = 10);

    // Top/bottom roller M3 bolts (X-axis through side walls)
    for (pos = [top_pos, bot_pos])
        translate(pos)
        rotate([0, 90, 0]) {
            // Shaft
            cylinder(d = m3_d + m3_clearance, h = outer_x + 1, center = true);
            // Bolt head counterbore (+X side)
            translate([0, 0, outer_x / 2 - m3_head_h])
                cylinder(d = m3_head_d + m3_clearance, h = m3_head_h + 1);
            // Hex nut pocket (-X side)
            translate([0, 0, -outer_x / 2 - 1])
                rotate([0, 0, 30])
                cylinder(d = m3_nut_d + m3_clearance, h = m3_nut_h + 1, $fn = 6);
        }

    // Left/right roller M3 bolts (Z-axis through top/bottom walls + base plate)
    for (pos = [left_pos, right_pos]) {
        // Shaft
        translate([pos[0], pos[1], pc[2] - outer_z / 2 - 1])
            cylinder(d = m3_d + m3_clearance, h = outer_z + width + 2);
        // Bolt head counterbore (top of base plate)
        translate([pos[0], pos[1], width - m3_head_h])
            cylinder(d = m3_head_d + m3_clearance, h = m3_head_h + 1);
        // Hex nut pocket (bottom of passthrough)
        translate([pos[0], pos[1], pc[2] - outer_z / 2 - 1])
            rotate([0, 0, 30])
            cylinder(d = m3_nut_d + m3_clearance, h = m3_nut_h + 1, $fn = 6);
    }
}

// === Rollers ===
// Top/bottom roller (print 2x)
translate([45, 0, 0])
difference() {
    cylinder(d = roller_d, h = tb_roller_len, center = true);
    cylinder(d = m3_d + roller_bore_clearance, h = tb_roller_len + 1, center = true);
}

// Left/right roller (print 2x)
translate([45, roller_d + 3, 0])
difference() {
    cylinder(d = roller_d, h = lr_roller_len, center = true);
    cylinder(d = m3_d + roller_bore_clearance, h = lr_roller_len + 1, center = true);
}
