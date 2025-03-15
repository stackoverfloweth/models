postWidth=78;
holeDiameter=16;
phoneWidth=85.5;
phoneHeight=127;
phoneDepth=32;
holderWidth=3.5;

union() {
    rackMount();
    phoneHolder();
        
    translate([0, -22, 40])
    rotate([90, 0, 0])
    post();
}

module rackMount() {
    bracketWidth=8;
    bracketHeight=60;
    bracketDepth=10;
    
    union() {
        translate([phoneWidth/2 - bracketWidth/2 + holderWidth, -66, -35.25])
        cube([bracketWidth, postWidth+bracketWidth, bracketHeight], true);    
        
        translate([3.25, -postWidth -28.25, -35.25])
        cube([postWidth+bracketWidth, bracketWidth, bracketHeight], true);
    }
}

module post() {
    union() {
        cylinder(h=2, d=holeDiameter*2);
        cylinder(h=postWidth, d=holeDiameter);
        translate([0, 0, postWidth])
        cylinder(h=3, d1=holeDiameter, d2=holeDiameter/1.625);
    }
}

module phoneHolder() {
    
    difference(){
        translate([0, -2, 0])
        cube([phoneWidth+holderWidth*2, phoneDepth+holderWidth*3, phoneHeight+holderWidth], true);
        
        translate([0, holderWidth/2, holderWidth])
        cube([phoneWidth, phoneDepth, phoneHeight], true);
        
        translate([0, holderWidth*2, 40])
        cube([phoneWidth, phoneDepth, phoneHeight], true);
        
        translate([0, holderWidth/2+4, 100])
        cube([phoneWidth*2, phoneDepth+4, phoneHeight], true);
    }
}
