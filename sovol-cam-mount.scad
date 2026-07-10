$fn = 180;

arm_length = 100;
arm_width = 10;
arm_thickness = 2.2;
hole_radius = 2.75;

beagle_gap = 15;
beagle_length = 21;

module sovol_cam_mount() {
  difference() {
    union() {
      mirror([2, 0, 0])
      sovol_adapter();

      difference() {
        hull() {
          cube([10, arm_width, 6]);
          cube([arm_length * 0.25, arm_width, arm_thickness]);
        }

        translate([0, 4.6, 5])
        rotate([0, 90, 0])
        cylinder(h=arm_length, r=hole_radius);
      }

      cube([arm_length-30, arm_width, arm_thickness]);

      translate([arm_length - 30, 0, 0])
      rotate([0, 0, 25])
      difference() {
        hull() {
          cube([beagle_length, 10, 5]);
          rotate([0, 90, 0])
          translate([-8, 5, 0])
          cylinder(h=beagle_length, d=10);
        }

        translate([(beagle_length-beagle_gap)/2, 0, arm_thickness])
        cube([beagle_gap, 10, 50]);

        translate([beagle_length-2, 3, arm_thickness+3])
        cube([4, 4, 6]);

        rotate([0, 90, 0])
        translate([-8, 5, 0])
        cylinder(h=beagle_length, d=4);
      }
    }

    // bevel
    translate([0, 0, -2.8])
    rotate([45, 0, 0])
    cube([arm_length, 3, 3]);
  }
}

module sovol_adapter() {
  intersection() {
    translate([-166.5, -104.25, -1])
    import("/Users/evansutherland/Downloads/Sovol_SV06_C270_webcam_holder.stl");
    cube([30, 30, 50]);
  }
}

sovol_cam_mount();