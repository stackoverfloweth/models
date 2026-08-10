$fn = 180;
height = 130.5;
width = 62;
depth = 5;

// main();
ring_caps();

module main() {
  union() {
    translate([0, 0, -3])
    ub_doorbell();

    translate([0, 0, -depth/2])
    difference() {
      hull() {
        rounded_cube([width, height, depth], radius=5, center=true);
        translate([0, 0, -.5])
        ub_doorbell();
      }

      rounded_cube([33.5, height, 30], radius=5, center=true);

      ring_mounts();
    }
  }
}

module ring_caps() {
  union() {
    translate([-10, -10, 0])
    cylinder(h=2, r=3);

    translate([10, -10, 0])
    cylinder(h=2, r=3);

    translate([-10, 10, 0])
    cylinder(h=2, r=3);

    translate([10, 10, 0])
    cylinder(h=2, r=3);
  }
}

module ub_doorbell() {
  difference() {
    union() {
      translate([0, 0, 0.075])
      import("/Users/evansutherland/Downloads/obj_1_geometry_0.stl");

      // fill holes in ub doorbell
      translate([-12, -65.25, -9.5/2-0.25])
      color("green")
      cube([24, 60, 9.5]);
    }

    // screw hole
    translate([0, -47, -1.8])
    color("blue")
    cylinder(h=10, r=2.15);

    // rj45 hole
    hull() {
      translate([0, -30, -20])
      color("blue")
      cylinder(h=50, r=11);

      translate([0, 30, -20])
      color("blue")
      cylinder(h=50, r=11);
    }

    // cut extra thickness
    translate([0, 0, -3.5])
    cube([100, 200, 3], center=true);
  }
}

module ring_mounts() {
  hole_width = 44;
  hole_height = 86;
  hole_radius = 1.5;

  union() {
    translate([-hole_width/2, -hole_height/2, -10/2])
    count_sunk_hole(h=10, r1=hole_radius, r2 = 3.1);

    translate([hole_width/2, -hole_height/2, -10/2])
    count_sunk_hole(h=10, r1=hole_radius, r2 = 3.1);

    translate([-hole_width/2, hole_height/2, -10/2])
    count_sunk_hole(h=10, r1=hole_radius, r2 = 3.1);

    translate([hole_width/2, hole_height/2, -10/2])
    count_sunk_hole(h=10, r1=hole_radius, r2 = 3.1);
  }
}

module count_sunk_hole(r1, r2, h) {
  union() {
    translate([0, 0, h-3])
    cylinder(h=3, r=r2);
    translate([0, 0, h-6])
    cylinder(h=3, r1=r1, r2=r2);
    cylinder(h=h, r=r1);
  }
}

module rounded_cube(size, radius = 1, center = false) {
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
                cylinder(r = actual_radius, h = z);
            // Bottom right corner
            translate([x - actual_radius, actual_radius, 0])
                cylinder(r = actual_radius, h = z);
            // Top left corner
            translate([actual_radius, y - actual_radius, 0])
                cylinder(r = actual_radius, h = z);
            // Top right corner
            translate([x - actual_radius, y - actual_radius, 0])
                cylinder(r = actual_radius, h = z);
        }
    }
}