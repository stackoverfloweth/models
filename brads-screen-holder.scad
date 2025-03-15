width=14.85;
length=41.15;
depth=13.55;
holeDiameter=7;
cylinerRadius=width/2;
tabThickness=3.3;
tabOffset=26.4;

difference() {
    tabBody();
    
    translate([width/2, depth, length-cylinerRadius])
    rotate([90, 0, 0])
    cylinder(h=depth, d=holeDiameter, $fn=180);
    
}

module tabBody() {   
    difference() {
        union() {
            difference() {
                union() {
                    cube([width, depth, length-cylinerRadius]);
                    
                    translate([width/2, tabThickness, length-cylinerRadius])
                    rotate([90, 0, 0])
                    cylinder(h=tabThickness, d=width, $fn=180);
                }
        
                // rear
                translate([0, -tabThickness, -tabOffset-tabThickness])
                cube([width, depth, length]);
            }
                        
            // rear fin        
            rearTabThickness=2;
            rotate([42, 0, 0])
            translate([width/2-rearTabThickness/2, 7.75, -14])
            cube([rearTabThickness, depth, tabOffset]);
        }
            
        // front
        translate([0, tabThickness, length-tabOffset])
        cube([width, depth, length]);
        
        // outside
        translate([0, depth, 0])
        cube([width, depth, length]);
        
        translate([0, -depth, 0])
        cube([width, depth, length]);
        
        translate([0, depth*.75, -length])
        cube([width, depth, length]);
    }
}