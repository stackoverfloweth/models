// Sovol Z-Axis Mounting Block
// Mounts to the blue Z-axis plate via 3 bolt holes with heat inserts

// --- Plate Dimensions (reference) ---
plate_width = 44;          // total X width including miter
plate_tab_width = 35;      // upper tab width after miter cut
plate_depth = 17.3;        // plate depth (Z)
plate_height = 60.2;       // total height (Y)

// --- Hole Parameters ---
hole_diameter = 5.3;       // heat insert hole in plate
bolt_clearance = 4.25;      // M3 bolt clearance hole for mounting block
hole_spacing = 30.75;      // spacing between holes in X and Y

// --- Block Parameters ---
wall = 5;                  // wall thickness around outermost holes
block_depth = 17.3;        // block depth (Z), matches plate depth

// Hole positions (origin = bottom-left hole)
// 3 holes in L-pattern:
//   hole 1: top-left
//   hole 2: bottom-left
//   hole 3: bottom-right
holes = [
    [0, hole_spacing],          // top-left
    [0, 0],                     // bottom-left
    [hole_spacing, 0],          // bottom-right
];

// Block dimensions derived from hole pattern + wall margin
block_width = hole_spacing + wall * 2;
block_height = hole_spacing + wall * 2;

// --- Hinge Parameters (from klipper-camera-adapter) ---
joint_bolt_d = 3.2;            // bolt/pin clearance
joint_knuckle_d = 7;           // outer diameter of knuckle
joint_knuckles = 5;            // total knuckle count (keeps knuckle_len compatible)
joint_clearance = 0.2;         // printing tolerance
knuckle_len = block_depth / joint_knuckles;
block_knuckle_count = 2;       // only render 2 knuckles on block side
ring_knuckle_len = 4.9;        // width of each ring knuckle

$fn = 40;

// --- Hinge layout (all world-space, like klipper-camera-adapter) ---
// Hinge axis along X, beyond block right face, near bottom edge
block_right = block_width - wall;
hinge_joint_x = block_right + joint_knuckle_d / 2;  // ring center X
hinge_joint_y = -wall + joint_knuckle_d / 2;        // ring center Y (near bottom)
stem_h = wall;                                        // stem thickness (Y)

// Printable hinge bolt
bolt_shaft_d = joint_bolt_d - joint_clearance * 2;
bolt_shaft_len = block_depth + 2;
bolt_head_d = joint_knuckle_d;
bolt_head_h = 3;

module hinge_bolt() {
    cylinder(d = bolt_head_d, h = bolt_head_h);
    translate([0, 0, bolt_head_h])
        cylinder(d = bolt_shaft_d, h = bolt_shaft_len);
}

// === Main Block with Hinge ===
module mount_block() {
    difference() {
        union() {
            // Main block
            translate([-wall, -wall, 0])
            hull() {
                translate([-12, 0, 0])
                cube([block_width+12, block_height, block_depth]);

                translate([block_width, block_height-6, 0])
                    cube([42-9.8, 6, block_depth]);
            }

            translate([63-9.8, 34, 36])
            rotate([0, 90, 0])
            rings();   

            // hdmi cable passthrough
            translate([-11, 12, -16.75])
            rotate([0, 90, 0])
            hdmi_passthrough();
        }

        // Bolt clearance holes
        for (h = holes) {
            translate([h[0], h[1], 0])
            bolt_hole();
        }
    }
}

module bolt_hole() {
    union() {
        cylinder(d = bolt_clearance, h = block_depth + 2);
        cylinder(d = 7.25, h = 4);
    }
}

module hdmi_passthrough() {
    gap = 21.5;
    width = 6;
    height = 14;

    difference() {
        cube([gap + width*2, gap + width*2, height], center = true);
        cube([gap, gap, height], center = true);
    }
}

module rings() {
  block_indices = [0, 2];

  difference() {
    union () {
      // Rings + standoff stems (world-space, klipper pattern)
      for (i = block_indices) {
          z_pos = i * ring_knuckle_len;
          // Ring: cylinder along Z at hinge position
          translate([hinge_joint_x, hinge_joint_y, z_pos])
              cylinder(d = joint_knuckle_d, h = ring_knuckle_len);
          // Standoff stem: from block right face to ring center
          translate([block_right, hinge_joint_y - stem_h / 2, z_pos])
              cube([hinge_joint_x - block_right, stem_h, ring_knuckle_len]);
        }
    }

    // Hinge pin hole through all knuckle positions
    translate([hinge_joint_x, hinge_joint_y, -0.1])
        cylinder(d = joint_bolt_d, h = block_depth + 0.2);
  }
}

// Camera-arm-side knuckles (for later)
module hinge_knuckles_arm() {
    arm_indices = [1, 3, 4];
    difference() {
        union() {
            for (i = arm_indices)
                translate([hinge_joint_x, hinge_joint_y, i * knuckle_len])
                    cylinder(d = joint_knuckle_d, h = knuckle_len);
        }
        translate([hinge_joint_x, hinge_joint_y, -0.1])
            cylinder(d = joint_bolt_d, h = block_depth + 0.2);
    }
}

// === PREVIEW ===
mount_block();
// hinge_knuckles_arm();
// translate([40, 0, 0]) hinge_bolt();
