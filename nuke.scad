nukeDiameter=185;
deckHeight=94.5; //92.5
deckWidth=68.5; //66.5
deckDepth=75; //68

coreHeight=98;
coreWidth=70;
coreDepth=178;

// slit()
// topRing();

core();

module core() {
    union() {
        rotate([270, 0, 0])
        translate([0, -coreDepth/2-8, 0])
        handle();
        
        difference(){
            deckBoxes();
        }
    }
}

module deckBoxes() {
    union() {
        translate([0, 0, deckDepth])
        rotate([90, 270, 0])
        deckBox();
        
        translate([coreWidth+5, 0, 0])
        rotate([90, 0, 0])
        deckBox();

        translate([-coreWidth-5, 0, 0])
        rotate([90, 180, 0])        
        deckBox();

        translate([0, 0, -deckDepth-2.5])
        rotate([90, -90, 0])         
        deckBox();
    }
}

module deckBox() {
    difference() {
        rotate([0, 0, 0])
        cube([deckWidth+5, deckDepth+5, deckHeight+5], true);
        
        translate([5, 0, 0])
        rotate([0, 0, 0])
        cube([deckWidth, deckDepth, deckHeight], true);
    }
}

module handle() {
    union() {
        difference() {
            union() {
                translate([0, 0, -30])
                tab();
                
                translate([0, 0, 30])
                tab();
            }
            
            translate([-20, 8, -50])
            cube([40, 40, 100]);
        }
        
        translate([0, 0, -35])
        cylinder(h=70, d=6, $fn=80);
        
        rotate([0, 0, 90])
        grip();
    }
}

module grip() {      
    union() {
        translate([0, 0, -35])
        gripHalf();
        
        translate([0, 0, 35])
        gripHalf(); 
        
        translate([0, -20, 0])
        cylinder(h=72.5, d=8, $fn=80, center = true);
    }
}

module gripHalf() {
    union () {
        cylinder(h=2.5, d=8, $fn=80, center = true);
        
        translate([0, -10, 0])
        cube([8, 20, 2.5], true);
    }
}

module topRing() {
    deckBottomOffset=78;
    deckHoleOffset=37;
    
    difference() {
        union() {
            translate([0, 0, deckBottomOffset-coreHeight])
            union() {
                insetRing();
                
                translate([0, 0, -14])
                tabs();
            }
            
            translate([-deckHoleOffset, 0, 0])
            coreGuide();
            
            translate([deckHoleOffset, 0, 0])
            coreGuide();

            translate([0, 0, -92])            
            lowerCover();
        }
        
        translate([-deckHoleOffset, 0, 2.5])
        union() {
            cube([coreWidth+2, coreHeight+2, coreDepth-1], true);
            cube([coreWidth/2, coreHeight+5, coreDepth-1], true);
            translate([-1, 0, 0])
            cube([coreWidth+4, coreHeight/2, coreDepth-1], true);
            
            translate([0, 0, -90])
            scale([50, 50, 100])     
            import("/Users/evansutherland/Downloads/MTG Logo.stl");
        }
        
        translate([deckHoleOffset, 0, 2.5])
        union() {
            cube([coreWidth+2, coreHeight+2, coreDepth-1], true);
            cube([coreWidth/2, coreHeight+5, coreDepth-1], true);
            translate([1, 0, 0])
            cube([coreWidth+4, coreHeight/2, coreDepth-1], true);
            
            translate([0, 0, -90])
            scale([50, 50, 100])     
            import("/Users/evansutherland/Downloads/MTG Logo.stl");
        }
    }
}

module insetRing() {
    expansionHeight=37;
    
    difference() {
        union() {
            cylinder(h=4, d=nukeDiameter+2, $fn=200);
            translate([0, 0, 4])
            cylinder(h=expansionHeight, d=nukeDiameter+4.5, $fn=200);
            translate([0, 0, expansionHeight])
            cylinder(h=15, d=nukeDiameter, $fn=200);            
            
            translate([0, 75, 15])
            scale([30, 30, 20])     
            import("/Users/evansutherland/Downloads/MTG Logo.stl");
            
            translate([0, -75, 15])
            scale([30, 30, 20])     
            rotate([0, 0, 180])
            import("/Users/evansutherland/Downloads/MTG Logo.stl");
        }
    }
}

module coreGuide() {
    cube([coreWidth+5, coreHeight+5, coreDepth], true);
}

module slit() {
    difference() {
        children();
        
        rotate_about_pt(40, 0, [0, 0, 0])
        translate([91, 0, -116])
        cube([100, 2, 100]);
    }
}

module tabs() {
    intersection() {
        union() {
            translate([92, 0, -2.5])
            rotate([90, 0, 90])
            tab();
            
            rotate_about_pt(120, 0, [0, 0, 0])
            translate([92, 0, -2.5])
            rotate([90, 0, 90])
            tab();
            
            rotate_about_pt(-120, 0, [0, 0, 0])
            translate([92, 0, -2.5])
            rotate([90, 0, 90])
            tab();
        }
        
        translate([0, 0, -80])
        cylinder(h=100, d=nukeDiameter, $fn=200);
    }
}

module tab() {
    tabHeight=18;
    tabWidth=15;
    tabThickness=4;
    tabDiameter=7;

    difference() {
        union() {
            translate([0, tabDiameter*1.2, 0])
            rotate([90, 0, 0])
            cube([tabWidth, tabThickness, tabHeight], true);
            
            translate([0, 0, -tabThickness/2])
            cylinder(h=tabThickness, d=tabWidth, $fn=80);
            
            
            translate([0, 20, 0])
            rotate([45, 0, 0])
            cube([15, 15, 15], true);
        }
        
        translate([0, 0, -tabThickness/2])
        cylinder(h=tabThickness, d=tabDiameter, $fn=80);
    }
}

module lowerCover() {
    nukeInnerDiameter=174;

    cylinder(h=3, d=nukeInnerDiameter+10, $fn=200);    
}

module rotate_about_pt(a, v, pt) {
    translate(pt)
        rotate(a,v)
            translate(-pt)
                children();   
}