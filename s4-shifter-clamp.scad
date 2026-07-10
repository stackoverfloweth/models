$fn = 180;
rod_diameter = 16;
length = 30.1;
width = 30;
height = 14.5;
alt_height = -2;
hole_diameter = 3;

difference() {
  cube(size=[width, height, length], center=true);

  // rod
  translate([0, 6, 0])
  cylinder(h=length, d=rod_diameter, $fn=80, center=true);

  // offset heights
  translate([width/2, height+alt_height, 0])
  cube(size=[width, height, length], center=true);

  // holes
  rotate([0, 90, 0])
  union() {
    translate([-7, 0, -10.5])
    rotate([90, 0, 0])
    cylinder(h=height, d=hole_diameter, $fn=80, center=true);

    translate([7, 0, -10.5])
    rotate([90, 0, 0])
    cylinder(h=height, d=hole_diameter, $fn=80, center=true);

    translate([-7, 0, 10.5])
    rotate([90, 0, 0])
    cylinder(h=height, d=hole_diameter, $fn=80, center=true);

    translate([7, 0, 10.5])
    rotate([90, 0, 0])
    cylinder(h=height, d=hole_diameter, $fn=80, center=true);
  }
}