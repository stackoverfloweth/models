device_width = 51;
device_height = 76;
device_depth = 16.5;
clip_width = 12;
clip_height = 40;
clip_depth = 1;

union() {
  wall_thickness = 3;
  outside_width = device_width + wall_thickness*2;
  outside_height = device_height + wall_thickness*2;
  outside_depth = device_depth + wall_thickness*2;

  difference() {
    rounded_cube([outside_width, outside_height*0.75, outside_depth]);

    translate([wall_thickness, wall_thickness-2, wall_thickness+2])
    device_body();

    // screen cutout
    translate([outside_width/2-22, 12, device_depth])
    cube([44, 50, 10]);

    // clip cutout
    translate([outside_width/2-clip_width/2, 0, 2])
    cube([clip_width, outside_height, clip_depth]);
  }
}

module device_body() {
  rounded_cube([device_width, device_height, device_depth]);
}

// Rounded cube module - works like cube() but with rounded corners
module rounded_cube(size, radius = 2, center = false, fn = 180) {
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
            // Create spheres at each corner of the cube
            // Bottom face corners
            translate([actual_radius, actual_radius, actual_radius])
                sphere(r = actual_radius, $fn = fn);
            translate([x - actual_radius, actual_radius, actual_radius])
                sphere(r = actual_radius, $fn = fn);
            translate([actual_radius, y - actual_radius, actual_radius])
                sphere(r = actual_radius, $fn = fn);
            translate([x - actual_radius, y - actual_radius, actual_radius])
                sphere(r = actual_radius, $fn = fn);
            
            // Top face corners
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