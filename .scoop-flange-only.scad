width = 4;
scoop_flange_width = 120;
scoop_flange_height = 50;
scoop_flange_length = 120;

module rounded_cube(size, radius = 1, center = false, fn = 180) {
    dimensions = is_list(size) ? size : [size, size, size];
    x = dimensions[0];
    y = dimensions[1];
    z = dimensions[2];
    max_radius = min(x, y, z) / 2;
    actual_radius = min(radius, max_radius);
    translate_offset = center ? [-x/2, -y/2, -z/2] : [0, 0, 0];
    translate(translate_offset) {
        hull() {
            translate([actual_radius, actual_radius, actual_radius])
                sphere(r = actual_radius, $fn = fn);
            translate([x - actual_radius, actual_radius, actual_radius])
                sphere(r = actual_radius, $fn = fn);
            translate([actual_radius, y - actual_radius, actual_radius])
                sphere(r = actual_radius, $fn = fn);
            translate([x - actual_radius, y - actual_radius, actual_radius])
                sphere(r = actual_radius, $fn = fn);
            translate([actual_radius, actual_radius, z - actual_radius])
                sphere(r = actual_radius, $fn = fn);
            translate([x - actual_radius, actual_radius, z - actual_radius])
                sphere(r = actual_radius, $fn = fn);
            translate([actual_radius, y - actual_radius, z - actual_radius])
                sphere(r = actual_radius, $fn = fn);
            translate([x - actual_radius, y - actual_radius, z - actual_radius])
                sphere(r = actual_radius, $fn = fn);
        }
    }
}

module scoop_flange() {
  union() {
    rounded_cube([scoop_flange_width, scoop_flange_length, width], 4);
    hull() {
      rounded_cube([width, scoop_flange_length*0.35, scoop_flange_height], 4);
      rounded_cube([width, scoop_flange_length, scoop_flange_height*0.15], 4);
    }
    translate([scoop_flange_width-width, 0, 0]) {
      hull() {
        rounded_cube([width, scoop_flange_length*0.35, scoop_flange_height], 4);
        rounded_cube([width, scoop_flange_length, scoop_flange_height*0.15], 4);
      }
    }
    translate([0, 0, 0]) {
      rounded_cube([scoop_flange_width, width, scoop_flange_height], 4);
    }
  }
}

scoop_flange();
