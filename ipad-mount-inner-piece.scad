tubeLength=26;
vDiameter=10;

baseHeight=11.50;
baseWidth=8.30;
baseDepth=2.75;

union(){
    cube([baseWidth, baseDepth, baseHeight]);

    difference() {
        translate([baseWidth/2, -1.75, 0])
            rotate([0, 0, 45])
                cube([baseHeight, baseHeight, baseHeight]);
        
        translate([-baseWidth/2, 0, -1])
            cube([baseWidth*2, baseDepth*10, baseHeight+2]);
    }
}