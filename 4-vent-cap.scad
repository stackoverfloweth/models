$fn = 180;

vent_diameter = 98.8;
cap_thickness = 2;
cap_length = 30;

union() {
  difference() {
    cylinder(h=cap_length, d=vent_diameter);
    translate([0, 0, cap_thickness])
    cylinder(h=cap_length, d=vent_diameter - cap_thickness * 2);
  }

  translate([0, 0, -5])
  cube([30, 30, 10], center=true);
}