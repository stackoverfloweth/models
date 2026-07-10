outside_diameter = 22;
inside_diameter = 4;
height = 60;
$fn = 100;

difference() {
    cylinder(h=height, d=outside_diameter);
    cylinder(h=height, d=inside_diameter);
}