width=62;
height=108;
depth=61;
thickness=10;

union() {
    translate([0, 0, depth/2+5])
    difference(){
        hull() {
            cube([width+thickness, height+thickness, depth], true);

            translate([width/2+2.5, height/2+2.5, -depth/2])
            cylinder(d=10, h=depth, $fn=100);
            translate([width/2+2.5, height/2+2.5, -depth/2-5])
            cylinder(d1=1, d2=10, h=5, $fn=100);

            translate([-width/2-2.5, height/2+2.5, -depth/2])
            cylinder(d=10, h=depth, $fn=100);
            translate([-width/2-2.5, height/2+2.5, -depth/2-5])
            cylinder(d1=1, d2=10, h=5, $fn=100);

            translate([-width/2-2.5, -height/2-2.5, -depth/2])
            cylinder(d=10, h=depth, $fn=100);
            translate([-width/2-2.5, -height/2-2.5, -depth/2-5])
            cylinder(d1=1, d2=10, h=5, $fn=100);

            translate([width/2+2.5, -height/2-2.5, -depth/2])
            cylinder(d=10, h=depth, $fn=100);
            translate([width/2+2.5, -height/2-2.5, -depth/2-5])
            cylinder(d1=1, d2=10, h=5, $fn=100);
        }
        
        translate([0, 0, 1])
        cube([width, height, 999], true);
    }

    translate([0, height/2+7, depth/2+5])
    tab();

    translate([0, -height/2-7, depth/2+5])
    rotate([0, 0, 180])
    tab();

    intersection() {
        cube([width, height, 10], true);

        faceplateWithHoles();
    }
}

module faceplateWithHoles() {
    gap=96.7;
    difference() {
        faceplate();

        translate([0, -gap/2, 0])
        cylinder(d=5, h=3, $fn=100, center=true);
        translate([0, -gap/2, 1])
        cylinder(d1=10, d2=1, h=3, $fn=100, center=true);

        translate([0, gap/2, 0])
        cylinder(d=5, h=3, $fn=100, center=true);
        translate([0, gap/2, 1])
        cylinder(d1=10, d2=1, h=3, $fn=100, center=true);
    }
}

module faceplate() {
    difference() {
        union() {
            import("/Users/evansutherland/Downloads/gfci-paddle-switch.stl");

            translate([0, 46, 0])
            cube([15, 15, 2], true);

            translate([0, -46, 0])
            cube([15, 15, 2], true);
        }

        translate([0, 0, 6])
        cube([999, 999, 10], true);

        translate([0, 0, -1])
        cube([999, 999, 2], true);
    }
}

module tab() {
    translate([0, 0, depth/2-3])
    difference() {
        union() {
            cube([20, 14, 6], true);
            translate([0, 7, 0])
            cylinder(d=20, h=6, $fn=100, center=true);
        }

        translate([0, 5, 0])
        cylinder(d=5, h=10, $fn=100, center=true);
        translate([0, 5, -2])
        cylinder(d1=10, d2=5, h=3, $fn=100, center=true);
    }
}