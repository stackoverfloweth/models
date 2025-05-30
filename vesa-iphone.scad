vesaGap=100;
monitorGap=140-18;
depth=10;
vesaArmWidth=12;
bodyWidth=40;

difference() {
    union () {
        rotate_about_pt(-45, 0, [-vesaGap/2, 0, 0])
        translate([-vesaGap/2, 0, 0])
        vesaEnd();

        rotate_about_pt(45, 0, [vesaGap/2, 0, 0])
        translate([vesaGap/2, 0, 0])
        vesaEnd();
        
        vesaBody();
        
        translate([0, 58, 0])
        magsafeArm();
    }
    
    translate([0, -.75, 0])
    cylinder(depth, d=60, $fn=180);
}

module vesaEnd() { 
    difference() {
        union() {
            cylinder(h=depth, d=vesaArmWidth, $fn=100);
    
            translate([-vesaArmWidth/2, 0, 0])
                cube([vesaArmWidth, 50, depth]);
        }
        
        cylinder(h=depth, d=5, $fn=100);
    }
}

module vesaBody() {
    union() {
        translate([-bodyWidth/2, 20, 0])
        cube([bodyWidth, monitorGap, depth]);
    }
}

module magsafeArm() {
    depth=3;
    armDepth=7;
    armWidth=28.5;
    
    union() {        
        translate([-bodyWidth/2, 97, 0])
        rotate([90, 0, 0])
        difference() {
            cube([bodyWidth, 50, armDepth+depth*2]);
            
            translate([depth*2, 0, depth])
            cube([armWidth, 50, armDepth]);
        
            translate([20, 25, -14])
            cylinder(h=30, d=24, $fn=180);
        }
    }
}

module rotate_about_pt(z, y, pt) {
    translate(pt)
        rotate([0, y, z])
            translate(-pt)
                children();   
}