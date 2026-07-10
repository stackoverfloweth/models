hole_diameter = 6.5;
hole_spacing = 65.5;
max_plate_below = 8;
plate_height = 40;
plate_thickness = 2;
plate_width = hole_spacing*3;
$fn = 180;

difference() {
  union() {
    color("purple")
    plate();

    translate([0, 0, 1])
    color("black")
    difference() {
      plate(0, 1);
      plate(3, 1);
    }

    translate([plate_width/-2, -10, 1])
    color("black")
    holes(9, 1);

    color("black")
      linear_extrude(height=plate_thickness)
        text("MARGO",
             size=36,
             font="SignPainter:style=HouseScript",
             halign="center",
             valign="center");
  }

  translate([plate_width/-2, -10, 0])
  holes();
}

module plate(margin=0, depth=plate_thickness) {
  cube([plate_width+20-margin, plate_height-margin, depth], center=true);
}

module holes(diameter=hole_diameter, height=100) {
  for (i = [0:3]) {
    translate([i*hole_spacing, 0, 0])
    cylinder(h=height, d=diameter, center=true);
  }
}
