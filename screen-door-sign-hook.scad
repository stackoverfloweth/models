ledge_thickness = 6;
width = 20;
thickness = 8;

union() {
  cube([width, 50, 4]);
  cube([width, 4, ledge_thickness + 4 + thickness]);
  translate([0, 0, ledge_thickness + 4])
  cube([width, 10 + 4, thickness]);
}