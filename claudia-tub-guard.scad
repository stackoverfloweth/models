$fn = 120;
tub_width = 100;
guard_height = 98.5 + 18;
guard_width = 155;
guard_thickness = 6;
guard_angle = 110;
bracket_width = 120;
screw_hole_diameter = 6.6;
gusset_size = 4;

difference() {
  bracket();
  translate([bracket_width/2, tub_width/2, -1])
  cylinder(h=guard_thickness*2, d=screw_hole_diameter);

  translate([bracket_width/2, tub_width+guard_thickness+1, -56+guard_thickness - guard_thickness*1.5])
  rotate([90, 0, 0])
  cylinder(h=guard_thickness*2, d=screw_hole_diameter);
}

module bracket() {
  union() {
    color("yellow")
    cube([bracket_width, tub_width, guard_thickness]);

    translate([0, guard_thickness, guard_thickness/2])
    rotate([guard_angle, 0, 0])
    height_bracket();

    bottom_bracket();
  }
}

module height_bracket() {
  union() {
    color("red")
    cube([bracket_width, guard_height, guard_thickness]);

    color("violet")
    translate([0, -4, -4])
    rotate([315, 0, 0])
    cube([bracket_width, guard_thickness, guard_thickness*2]);

    color("orange")
    translate([0, guard_height-guard_thickness, -15])
    cube([bracket_width, guard_thickness, 15]);

    color("purple")
    translate([0, guard_height-guard_thickness*3, -15-guard_thickness])
    cube([bracket_width, guard_thickness*3, guard_thickness]);
  }
}

module bottom_bracket() {
  union() {
    color("pink")
    translate([0, tub_width, -56+guard_thickness - guard_thickness*3])
    cube([bracket_width, guard_thickness, 56 + guard_thickness*3]);

    color("orange")
    translate([0, tub_width+guard_thickness, -56+guard_thickness])
    cube([bracket_width, guard_thickness, guard_thickness]);

    color("purple")
    translate([0, tub_width+guard_thickness*2, -56+guard_thickness])
    cube([bracket_width, guard_thickness, guard_thickness*3]);
  }
}