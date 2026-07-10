$fn = 180;

sphere_diameter = 22.25;
sphere_height = 14.25;
cylinder_diameter = 14.3;
cylinder_height = 7.5;

difference() {
  grommet();
  cylinder(d=11, h=50, center=true);
  washer();
}

module washer() {
  difference() {
    cylinder(d=50, h=1.25, center=true);
    cylinder(d=cylinder_diameter, h=50, center=true);
  }
}

module grommet() {
  union() {
    ellipsoid(rx=sphere_diameter/2, ry=sphere_diameter/2, rz=sphere_height/2);
    cylinder(h=cylinder_diameter, d=cylinder_diameter);
  }
}

module ellipsoid(rx, ry, rz) {
    scale([rx, ry, rz])
        sphere(r=1);
}