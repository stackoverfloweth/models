$fn = 180;

sphere_diameter = 22;
sphere_height = 14.25;
hole_diameter = 16.5;

difference() {
  ellipsoid(rx=sphere_diameter/2, ry=sphere_diameter/2, rz=sphere_height/2);
  cylinder(d=11, h=50, center=true);
  washer();
}

module washer() {
  difference() {
    cylinder(d=50, h=1.5, center=true);
    cylinder(d=hole_diameter, h=50, center=true);
  }
}

module ellipsoid(rx, ry, rz) {
    scale([rx, ry, rz])
        sphere(r=1);
}