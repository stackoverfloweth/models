eye_diameter=14;
inside_diameter=10;
post_length=3;
post_diameter=4;

union() {
  translate([0, 0, -post_length])
  intersection() {
    translate([0, 0, eye_diameter/2])
      sphere(d=eye_diameter, $fn=240);
    translate([0, 0, -eye_diameter/2+post_diameter])
      cube([eye_diameter, eye_diameter, eye_diameter], center=true);
  }

  cylinder(d=post_diameter, h=post_length, $fn=240);

  translate([0, 0, post_length])
  cylinder(d=inside_diameter, h=2, $fn=240);
}