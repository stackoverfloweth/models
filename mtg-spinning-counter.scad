inner_diameter_offset = 12;
inner_diameter = 7.5;
outer_diameter = 30;
magnet_diameter = 4.25;
total_depth=3.6;
disk_depth=0.5;

disk(start_index=1, end_index=9, rotation_offset=12);

translate([0, 0, 10])
disk(start_index=10, end_index=19, font_size=3.25, font_offset=-1);

module disk(start_index, end_index, font_size=6, font_offset=0, rotation_offset=9) {
  difference() {
    union() {
      cylinder(d=outer_diameter, h=disk_depth, $fn=100);

      count=50;
      for (i = [1:count]) {
        rotate([0, 0, i * 360 / -count])
        translate([0, outer_diameter/2, 0])
        cylinder(d=1.75, h=disk_depth, $fn=4);
      }
    }

    cylinder(d=inner_diameter_offset, h=1.5, $fn=100);
  }

  union() {
    count=end_index-start_index+1;
    for (i = [start_index:end_index]) {
        rotate([0, 0, i * 360 / -count])
        translate([0, 13.5 + font_offset, 0])
        rotate([0, 0, 180 + rotation_offset])
        color("green")

        linear_extrude(1, 1, disk_depth+0.5)
          text(str(i), size=font_size);
    }
  }
}