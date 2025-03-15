length=100;

union() {
    rotate([90, 0, 0])
    difference() {
        union() {
            translate([-1, 0, 0])
            cube([17, 6, length]);
            
            translate([-3, -3, 0])
            cube([20.5, 4.5, length]);
        }
        
        for (i = [1:4]) {
            rotate([90, 0, 0])
            translate([8, i*20, 0])
            union() {
                cylinder(d=2, h=10, $fn=80, center=true);
                
                translate([0, 0, 3])
                sphere(d=10, $fn=80, true);
            }
        }
    }
    
    difference() {
        translate([8, -4, (50/2)+6])
        cube([50, 8, 50], center=true);
    
        rotate([90, 0, 0])
        translate([-5, 12, 4])
        union() {
            cylinder(d=2, h=10, $fn=80, center=true);
            
            translate([0, 0, -5])
            sphere(d=10, $fn=80, true);
        }
            
        rotate([90, 0, 0])
        translate([20, 12, 4])
        union() {
            cylinder(d=2, h=10, $fn=80, center=true);
            
            translate([0, 0, -5])
            sphere(d=10, $fn=80, true);
        }

    
        rotate([90, 0, 0])
        translate([-5, 42, 4])
        union() {
            cylinder(d=2, h=10, $fn=80, center=true);
            
            translate([0, 0, -5])
            sphere(d=10, $fn=80, true);
        }
            
        rotate([90, 0, 0])
        translate([20, 42, 4])
        union() {
            cylinder(d=2, h=10, $fn=80, center=true);
            
            translate([0, 0, -5])
            sphere(d=10, $fn=80, true);
        }
    }
}