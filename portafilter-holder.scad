outside_radius = 41;
inside_radius = 30; // 30 after bezel
height = 25;

difference() {
  cylinder(h=height, r=outside_radius, $fn=180, center=true);

  union() {
    translate([0, 0, height * 0.45])
    cylinder(h=height, r=inside_radius, $fn=180, center=true);

    translate([0, 0, 10])
    cylinder(h=10, r1=inside_radius*.5, r2=inside_radius*1.25, $fn=180, center=true);

    rotate([90, 0, 0])
    translate([0, 4, 78])
    hull() {
      cylinder(h=100, r=10, $fn=180, center=true);
      translate([0, 10, 0])
      cylinder(h=100, r=10, $fn=180, center=true);
    }
  }
}
