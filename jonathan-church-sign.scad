cross_file = "/Users/evansutherland/Documents/Models/methodist-cross.png";
flame_file = "/Users/evansutherland/Documents/Models/methodist-flame.png";
logo_size = 100;        // size of logo (will fit within this dimension)
cross_depth = 2;      // how deep to engrave cross (mm)
flame_depth = 1;      // how deep to engrave flame (mm)

post_diameter=24;
sleeve_thickness=2;
sleeve_height=35;
backboard_thickness=3;
backboard_width=200;
backboard_height=200;
transition_height=60;
$fn=180;

difference() {
  union() {
    sleeve();
    translate([0, 0, sleeve_height])
    transition();
  }
  translate([0, 0, sleeve_height + transition_height/2])
  backboard();
}

// translate([0, 0, 100])
// backboard(with_logo = true);

module sleeve(height = sleeve_height) {
  difference() {
    cylinder(h=height, d=post_diameter + sleeve_thickness*2);
    cylinder(h=height, d=post_diameter);
  }
}

module transition() {
  hull() {
    sleeve(transition_height/2);
    translate([0, 0, transition_height/2])
    backboard(transition_height/2);
  }
}

module backboard(height = backboard_height, with_logo = false) {
  difference() {
    translate([0, 0, height/2])
    rotate([0, 90, 0])
    cube([height, backboard_width, backboard_thickness], center=true);

    // if (with_logo) {
    //   // Position logos on front face, centered on backboard
    //   translate([backboard_thickness/2, 0, height/2])
    //   rotate([0, 90, 0])
    //   rotate([0, 0, 90]) {
    //     logo(cross_file, cross_depth);
    //     logo(flame_file, flame_depth);
    //   }
    // }
  }
}

module logo(file, depth) {
  // Image dimensions (update these to match your PNG)
  img_width = 300;
  img_height = 300;

  // Scale factor to fit logo_size, height values in surface() range 0-100
  scale_xy = logo_size / max(img_width, img_height);
  scale_z = depth / 100;  // surface() outputs 0-100 height

  scale([scale_xy, scale_xy, scale_z])
  translate([-img_width/2, -img_height/2, 0])
  surface(file, center=false, invert=true);
}