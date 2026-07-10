$fn=180;

bag_roll_width=60;
bag_roll_diameter=6;
towel_diameter=10;
thickness=2.5;
gap_between=20;

difference() {
  union() {
    //bag holder
    cylinder(d=bag_roll_diameter, h=bag_roll_width+thickness*2);

    //connector
    hull() {
      cylinder(d=bag_roll_diameter, h=thickness*2);

      translate([0, gap_between, 0])
      cylinder(d=towel_diameter+thickness*2, h=thickness*2);
    }

    //slider
    translate([0, gap_between, 0])
    difference() {
        cylinder(d=towel_diameter+thickness*2, h=15);
    }
  }

  translate([0, gap_between, 0])
  cylinder(d=towel_diameter, h=25);
}