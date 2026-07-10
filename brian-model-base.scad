base_width=25;
base_depth=1.25;
$fn=180;

module round(width) {
    difference() {
        cylinder(h=base_depth, d=width, center=true);
        magnet(d=width-2);
    }
}

module square(width, length) {
    difference() {
        cube([width, length, base_depth], true);
        magnet();
    }
}

module magnet(d=3.25) {
    color("red")
    translate([0, 0, -base_depth/2])
    cylinder(h=1.1, d=d);
}

round(40);

translate([0, 50, 0])
round(30);

translate([0, 100, 0])
round(25);