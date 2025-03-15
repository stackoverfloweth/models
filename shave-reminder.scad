difference() {
    union() {
        translate([0, 8, 0])
            difference() {
                linear_extrude(3)
                    circle(d=16);
                translate([0, -8, -1])
                    cube([50, 16, 5]);
            }
        
        difference(){
            cube([44, 16, 3]);
            translate([4, 4, 2])
                linear_extrude(3)
                    text("SHAVE", size=8);
            
            translate([1, 1, 2])
            difference() {
                cube([42, 14, 5]);
                    translate([1, 1, -1])
                        cube([40, 12, 5]);
            }
        }
    }
    translate([-3, 8, -1])
        rotate([0, 0, 0])
            cylinder(h=10, d=4, $fn=20);
}