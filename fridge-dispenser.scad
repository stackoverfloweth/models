innerWidth=38.5;
innerHeight=145-6.5;
innerDepth=9.5;
outerWidth=innerWidth+12;
outerHeight=innerHeight+26;
tabWidth=15;
waterlineDiameter=7.8;

rotate([-90,0, 0])        
frame();

translate([-100, -11, -15])
rotate([-90,0, 0])        
trigger();

module trigger() {
    triggerWidth = innerWidth + 5.25;
    union() {                
        difference() {
            cube([triggerWidth, 3, innerHeight+20], true);
                
            // waterline cutout
            translate([0, 0, -17.75])
            cube([25, 100, 45], true);    
        }
        
        translate([0, 1.5, 60])
        rotate([90, 90, 0])
        scale(0.2)
        import("/Users/evansutherland/Downloads/arrow.stl");
        
        // trigger action
        triggerLength=28;
        triggerHeight=8;
        triggerAngle=16;
        rotate([0, 180, 0])
        translate([6, -triggerHeight-1, -triggerLength-4.75])
        difference() {
            cube([10, triggerHeight, triggerLength]);
            
            rotate_about_pt(triggerAngle, 0, 0, [0, triggerHeight, 0])
            cube([10, triggerHeight, 30]);
        }
            
        // spring bottom
        translate([-15, -3, -30])
        rotate([90, 0, 0])
        springAnchor();
        
        // flat print support
        translate([-15, -5.25, -50])
        cube([6, 7.5, 1], true);

        translate([0, 0, -10])
        // botom components
        union () {    
            translate([0, 8, -36.25])
            cube([triggerWidth, 16, 12], true);
            
            // water line 
            translate([4, 6+15, -66.25+27])
            rotate([180, 0, 0])
            difference() {
                union () {
                    translate([-4, 0, -3])
                    cube([triggerWidth, 12, 12], true);    
                    
                    translate([-4, 0, 0])
                    intersection() {
                        rotate_about_pt(-30, 0, 0, [triggerWidth, 14, -34])
                        cube([triggerWidth, 50, 50], true);
                        
                        translate([0, 8, -30])
                        cube([triggerWidth, 28, 42], true);
                    }
                }
                                
                // waterline cutout... again
                translate([0-4, 0, -31.75])
                cube([25, 100, 45], true);  
            
                translate([0, -.5, -20])
                cylinder(100, d=waterlineDiameter, $fn=80, true);
             
                translate([0, -4, -20])
                cube([waterlineDiameter, waterlineDiameter, 100], true);     
            }  
            
            // water line lip
            translate([0, 3, -innerHeight/2+1.5])
            difference() {
                cube([triggerWidth, 4.5, 3], true);
                
                translate([0, -.5, 1])
                cube([triggerWidth, 2.75, 2.75], true);
            }
        }
    }
}

module frame() {
    union() {
        difference() {
            union() {
                roundedCube(2, innerWidth, innerDepth, innerHeight);
                
                translate([0, 13.5-1.5, -8])
                roundedCube(2, outerWidth, 13.5, outerHeight);
            }
            
            // inner cut
            cube([innerWidth-1.5, 100, innerHeight-1.5], true);
            
            translate([-50, -21.5-2.5, outerHeight/2-36])
            cube([100, 20, 23]);
            
            translate([-50, -21.5, outerHeight/2-55-43])
            cube([100, 20, 30]);
            
            translate([-50, -21.5, -75])
            cube([100, 20, 36]);
                
            // clip cutout 
            translate([-50, -21.5, -40+7.5])
            cube([100, 20, 30]);
        }
                
        // top tab   
        translate([0, 0, -8]) 
        difference() {
            union() {
                translate([0, -7.5, outerHeight/2])
                rotate([-45, 0, 0])
                cube([tabWidth, 8, 4], true);
                
                translate([0, -8, outerHeight/2+5.75])
                roundedCube(2, tabWidth, 1.5, tabWidth-4);
                
                translate([0, -5.5, outerHeight/2-2.75])
                cube([tabWidth, 8, 4], true);
            }
            
            translate([0, -13.5, outerHeight/2])
            cube([tabWidth, 8, tabWidth], true);
            
            // screw hole
            translate([0, 0, outerHeight/2+6])
            roundedCube(2, 3, 10, 1);
        }
        
        // slides    
        translate([0, 0, innerHeight*.3])
        union () {
            translate([-innerWidth/2-.75, 12.75, -14])
            slide(innerHeight*.6);
            
            translate([innerWidth/2+.75, 12.75, -14])
            rotate([0, 180, 0])
            slide(innerHeight*.6);
        }
    }
    
    
    // bottom clip
    difference() {
        union() {
            translate([0, -5, -outerHeight/2+8.5])
            cube([tabWidth, 8, 4], true);
            
            translate([0, -4, -outerHeight/2+9])
            rotate([45, 0, 0])
            cube([tabWidth, 18, 4], true);         
        }
                    
        translate([0, -17, -outerHeight/2+3])
        cube([tabWidth, 16, tabWidth], true);
        
        // remove overhang inside top
        translate([0, 0, -outerHeight/2+21.25])
        cube([tabWidth, 12, tabWidth], true);
            
        // remove overhang inside back
        translate([0, 6, -outerHeight/2+12])
        cube([tabWidth, 12, tabWidth], true);   
    }
    
    // spring bottom
    translate([0-15, 4, -outerHeight/2+15])
    springAnchor();
                
    // clip cutout 
    translate([17, -9.5, -40+4.5])
    cube([1.5, 9.5, 15]);
    
    // clip cutout 
    translate([-18.5, -9.5, -40+4.5])
    cube([1.5, 9.5, 15]);
    
    // switch mount
    translate([-innerWidth/2, -9.5, 14.25])
    cube([2, 21.5, 50]);
    
    translate([-18, -4, 16])
    rotate([0, 90, 0])
    cylinder(10.5, d1=3, d2=2.5, $fn=80);
    
    translate([-18, 6, 38])
    rotate([0, 90, 0])
    cylinder(10.5, d1=3, d2=2.5, $fn=80);
}

module rotate_about_pt(x, z, y, pt) {
    translate(pt)
        rotate([x, y, z])
            translate(-pt)
                children();   
}

module springAnchor() {
    difference() {
        cube([5, 4, 5], true);
        
        translate([0, 10, 0.5])
        rotate([90, 0, 0])
        cylinder(20, d=2, $fn=80, true);
    }
}

module slide(h) {
    difference() {
        cube([10.5, 12.5, h], true);
        
        translate([1.5, -1.5, 0])
        cube([8.5, 10.5, h], true);
    }
}

module roundedCube(radius, w, d, h) {
    
    hull() {
        rotate([90, 0, 0])
        translate([-w/2+radius, -h/2+radius, 0])
        cylinder(d, r=radius, $fn=80);
        
        rotate([90, 0, 0])
        translate([-w/2+radius, h/2-radius, 0])
        cylinder(d, r=radius, $fn=80);
        
        rotate([90, 0, 0])
        translate([w/2-radius, -h/2+radius, 0])
        cylinder(d, r=radius, $fn=80);
        
        rotate([90, 0, 0])
        translate([w/2-radius, h/2-radius, 0])
        cylinder(d, r=radius, $fn=80);
    }
}