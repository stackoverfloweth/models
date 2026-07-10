// Heater dimensions
heater_width = 148.5;
heater_depth = 79.25;
corner_radius = 25;  // Corner radius on the sides of the heater

// Stand parameters
stand_height = 60;
tilt_angle = 10;
cutout_depth = 10;  // How deep the heater sits into the stand
wall_margin = 5;  // Extra material around the heater
stand_width = heater_width+wall_margin*2;
stand_depth = heater_depth+wall_margin*2;

$fn = 180;

module heater_cutout() {
  union() {
    translate([corner_radius, 0, 0])
    hull() {
        translate([0, 0, 0])
        cylinder(r=corner_radius, h=heater_depth);

        translate([heater_width-(corner_radius*2), 0, 0])
        cylinder(r=corner_radius, h=heater_depth);

        translate([0, heater_width-(corner_radius*2), 0])
        cylinder(r=corner_radius, h=heater_depth);

        translate([heater_width-(corner_radius*2), heater_width-(corner_radius*2), 0])
        cylinder(r=corner_radius, h=heater_depth);
    }

    translate([corner_radius, heater_width-corner_radius, wall_margin/2])
    cube([heater_width-corner_radius*2, 4.12, heater_depth-wall_margin]);
  }
}

// Main stand
difference() {
    cube([stand_width, stand_height+cutout_depth, stand_depth]);
    rotate([tilt_angle, 0, 0])
    translate([wall_margin, -110, wall_margin])
    heater_cutout();
}