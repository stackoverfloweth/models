height=16;
width=50;
depth=3;

difference() {
    union() {
        translate([0, height/2, 0])
            difference() {
                cylinder(h=depth, d=height, $fn=120);
                
                translate([0, -height/2, 0])
                    cube([width, height, depth]);
            }
        
        difference(){
            cube([width-depth, height, depth]);

            translate([width/2, height/2, depth])
                print("Evan", 8);

            translate([width/2, height/2, depth/3])
                mirror([1, 0, 0])
                    print("Evan", 8);
        }
    }

    // hole for the key ring
    translate([-3, height/2, -1])
        rotate([0, 0, 0])
            cylinder(h=10, d=4, $fn=120);
}

module print(text, size) {
    translate([0, 0, -0.5])
    union() {
        translate([-width/2+6, -height/2+4, -0.5])
            linear_extrude(depth/3)
                text(text, size=size);
        
        difference() {
            scale([0.8, 0.8, 1])
            cube([width, height, depth/3], true);

            scale([0.8, 0.8, 1])
            cube([width-2, height-2, 5], true);
        }
    }
}