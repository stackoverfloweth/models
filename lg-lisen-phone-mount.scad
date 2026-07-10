$fn = 180;

screw_center_to_bottom = 25;
screw_to_bottom = screw_center_to_bottom + 3;
screw_center_to_middle = 11.25;
screw_diameter = 3.5;
punch_center_to_middle = 71.4;
punch_center_to_bottom = 8;
punch_diameter = 3.2;
screw_center_to_punch_center = 84.5;
monitor_depth = 15.5;

mount_width = 150;
mount_middle = mount_width / 2;
mount_height = 25;
mount_depth = 5;

button_cutout_diameter = 16;

magsafe_width = 40;
armDepth=7;
armWidth=28.5;

difference() {
  union() {
    bodyMount();

    // connection
    hull() {
      translate([mount_middle - magsafe_width/2, 0, -1])
      cube([magsafe_width, mount_depth, 1]);

      translate([mount_middle - magsafe_width/2, 0, -mount_height])
      rotate([70, 0, 0])
      magsafeArm();
    }
  }

  rotate([-20, 0, 0])
  translate([mount_middle - magsafe_width/2 + 6, -50, -mount_height-8])
  magsafeArmCutout();

  // menu cutout
  translate([mount_middle, mount_depth, 8])
  rotate([90, 0, 0])
  cylinder(h=mount_depth, d=button_cutout_diameter);

  // screw hole
  translate([mount_middle + screw_center_to_middle, mount_depth, screw_center_to_bottom-3]) {
    rotate([90, 0, 0])
    cylinder(h=mount_depth/2, d=screw_diameter*2);
  }
}

module bodyMount() {
  difference() {
    cube([mount_width, mount_depth, screw_to_bottom]);

    // screw hole
    translate([mount_middle + screw_center_to_middle, mount_depth, screw_center_to_bottom-3]) {
      rotate([90, 0, 0])
      cylinder(h=mount_depth, d=screw_diameter);
    }

    // punch hole
    translate([mount_middle - punch_center_to_middle, mount_depth, punch_center_to_bottom]) {
      rotate([90, 0, 0])
      cylinder(h=mount_depth, d=punch_diameter);
    }
  }
}

module magsafeArm() {
  depth=3;
  
  union() {        
    rotate([90, 0, 0])
    difference() {
      cube([magsafe_width, 50, armDepth+depth*2]);
      
      translate([depth*2, 0, depth])
      magsafeArmCutout();
    }
  }
}

module magsafeArmCutout() {
  cube([armWidth, 75, armDepth]);
}