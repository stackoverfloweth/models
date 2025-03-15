d=76;

difference() {
    union() {
        cylinder(d=d, h=140, $fn=180);
        
        rotate([90, 0, 0])
        translate([0, 70, 0])
        cylinder(d=d, h=80, $fn=180);
    }
    cylinder(d=d-5, h=140, $fn=180);
    
    rotate([90, 0, 0])
    translate([0, 70, 0])
            cylinder(d=d-5, h=120, $fn=180);
}