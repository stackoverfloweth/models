$fn = 240;

resin_depth = 3;
tray_depth = 1.2;

union() {
  tray();

  supports(8);

  supports(16);
}

module supports(support_offset) {
  union() {
    color("red")
    translate([support_offset, 0, tray_depth])
    support();

    color("green")
    translate([-support_offset/2, support_offset*sqrt(3)/2, tray_depth])
    support();

    color("blue")
    translate([-support_offset/2, -support_offset*sqrt(3)/2, tray_depth])
    support();
  }
}

module support() {
  support_diameter = .4;
  
  cylinder(h = resin_depth, r = support_diameter);
}

module tray() {
  inner_radius = 45.7;
  inner_depth = 4.6;

  difference() {
    cylinder(h = inner_depth + (resin_depth * 2) + tray_depth, r = inner_radius + resin_depth + tray_depth);
    translate([0, 0, tray_depth])
    cylinder(h = 100, r = inner_radius + resin_depth);
  }
}