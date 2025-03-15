nukeDiameter=185;
deckHeight=94.5; //92.5
deckWidth=68.5; //66.5
deckDepth=75; //68

deckBox();

translate([100, 0, 65])
rotate([270, 0, 0])
handle();

module deckBox() {
    union() {
        difference() {
            rotate([0, 0, 0])
            cube([deckWidth+5, deckDepth+5, deckHeight+5], true);
            
            translate([5, 0, 0])
            rotate([0, 0, 0])
            cube([deckWidth, deckDepth, deckHeight], true);
        }
        
        
        translate([-36.75, 52, 54.75])
        rotate([90, 180, 90])
        doveXs(deckDepth-1.5, 5);
        
        translate([-36.75, 52-8, -49.75])
        rotate([90, 180, 90])
        doveYs(deckDepth-1.5, 4);
        
        translate([-36.75, 40, 60])
        rotate([90, 90, 90])
        doveYs(deckDepth-1.5, 6);
        
        translate([-36.75, -45, 60-8])
        rotate([90, 90, 90])
        doveXs(deckDepth-1.5, 5);
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

module doveXs(length=1, count) {
    union() {
        for ( i = [1:1:count]) 
            translate([i*16, 0, 0])
            linear_extrude(length)
            doveX();
    }
}

module doveYs(length=1, count) {
    union() {
        for ( i = [1:1:count]) 
            translate([i*16, 0, 0])
            linear_extrude(length)
            doveY();
    }
}

module doveX() {
    // 5 x 10
    // 5 x 6
    polygon(points = [
        [0, 0],  // Bottom-left
        [10, 0], // Bottom-right
        [8, 5],  // Top-right
        [2, 5]   // Top-left
    ], paths = [[0, 1, 2, 3]]);
}

module doveY() {
    // 5 x 10
    // 5 x 6
    polygon(points = [
        [2.5, 0],  // Bottom-left
        [7.5, 0], // Bottom-right
        [9.5, 5],  // Top-right
        [0.5, 5]   // Top-left
    ], paths = [[0, 1, 2, 3]]);
}

module handle() {
    union() {
        translate([-10, 10, 44])
        rotate([0, 90, 0])
        doveYs(20, 4);
        
        translate([0, 0, 0])
        difference() {
            union() {
                translate([0, 4, 0])
                cylinder(h=60, d=20, $fn=80, center=true);            
                translate([0, 8, 0])
                cube([20, 10, 60], true);
            }
            
            translate([0, 15, 0])
            cube([20, 10, 60], true);
            
            translate([0, 0, -35])
            cylinder(h=70, d=7, $fn=80);
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