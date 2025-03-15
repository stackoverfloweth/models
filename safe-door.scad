buttonDiameter=23;
overallDiameter=104.25;
insideDiameterImportant=92;
distanceBetweenMountingHoles=42;
mountingHoleDiameter=5.5;
backWindowWidth=44;
backWindowHeight=32;
frontScrewDiameter=3;
distanceBetweenFrontScrews=68;
distanceFromOutsideEdgeToScrew=9.25;
// heightAtBottomLogo=31.5;
heightAtBottomLogo=40;
bottomPlateThickness=2;

difference() {
    difference() {
        // main body
        difference() {
            cylinder(h=heightAtBottomLogo, d=overallDiameter);
            translate([0, 0, bottomPlateThickness])
                cylinder(h=100, d=insideDiameterImportant);
        }
        
        // back window
        translate([-2, -32, -10])
            cube([backWindowHeight, backWindowWidth, 100]);
        
        
        topMountX=35;
        
        // mounting holes
        translate([topMountX, 0, -10])
            cylinder(h=100, d=mountingHoleDiameter);
        
        translate([(distanceBetweenMountingHoles - topMountX) * -1, 0, -10])
            cylinder(h=100, d=mountingHoleDiameter);
        
        // mounting hole guides
        translate([topMountX -6, 0, -10])
            cylinder(h=100, d=mountingHoleDiameter*2);
        
        translate([(distanceBetweenMountingHoles - topMountX) * -1 -6, 0, -10])
            cylinder(h=100, d=mountingHoleDiameter*2);
            
        // screw holes
        distanceToScrewFromCenter=-42.5;
        distanceBetween=58.89;
        
        translate([distanceToScrewFromCenter, 0, -1])
            cylinder(h=4, d1=frontScrewDiameter * 2, d2=frontScrewDiameter);
            
        translate([14.125, 38, -1])
            cylinder(h=4, d1=frontScrewDiameter * 2, d2=frontScrewDiameter);
            
        translate([14.125, -38, -1])
            cylinder(h=4, d1=frontScrewDiameter * 2, d2=frontScrewDiameter);
           
    }
    
    // hole for button
    translate([0, 0, heightAtBottomLogo/2])
        rotate([90, 0, 90])
            cylinder(h=100, d=buttonDiameter);
}