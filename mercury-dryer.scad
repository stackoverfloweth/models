actual_radius=19.85;
scale_by=1.5;
$fn=180;

rack_stand();
// translate([0, 200, 0])
// fan_blades();

module rack_stand() {
  stand_height = 40;
  rack_radius = 80;
  wall_thickness = 2.5;

  // Adjustable hole size for the perforated top grid
  hole_size = 3;  // Change this value to adjust opening size
  hole_spacing = 4;  // Distance between hole centers

  difference() {
    //outside
    cylinder(h=stand_height + wall_thickness/2, r=rack_radius + wall_thickness, center=true);

    //inside
    translate([0, 0, 1])
    cylinder(h=stand_height, r=rack_radius, center=true);

    // Perforated grid
    for (x = [-rack_radius : hole_spacing : rack_radius]) {
      for (y = [-rack_radius : hole_spacing : rack_radius]) {
        if (sqrt(x*x + y*y) <= rack_radius + wall_thickness) {
          translate([x, y, -(stand_height/2 + wall_thickness/2)])
          cylinder(h=wall_thickness + 2, r=hole_size/2, center=true);
        }
      }
    }
  }
}

module fan_blades() {
  union() {
    translate([-110, -110, 10])
    import("/Users/evansutherland/Downloads/elegoo-center-spoke.stl");
    // actual_radius is 19.85mm

    difference() {
      scale([scale_by, scale_by, 1])
      translate([-135.5, -120, -20])
      import("/Users/evansutherland/Downloads/fan-blades.stl");
      // fan-blades radius is 75mm

      translate([0, 0, -26])
      cylinder(h=30, r=19.85);
    }

    translate([0, 0, -6])
    cylinder(h=18, r=19.85);
  }
}