tubeDiameter=30;
tubeThickness=2;
tubeLength=26;

difference() {
    union() {
        // main tube
        difference() {
            cylinder(h=tubeLength, d=tubeDiameter, $fn=100);
            translate([0, 0, -1])
            cylinder(h=tubeLength+2, d=tubeDiameter-tubeThickness*2, $fn=100);
        }

        // inset triangles
        vDiameter=40;
        vOffset=28.5;
        intersection(){
            translate([0, -vOffset, 0])
                intersection(){
                    translate([-vDiameter/4, 0, 0])
                        cylinder(h=tubeLength, d=vDiameter);
                    translate([vDiameter/4, 0, 0])
                        cylinder(h=tubeLength, d=vDiameter);
                }
            
            cylinder(h=tubeLength, d=tubeDiameter);
        }

        intersection(){
            translate([0, vOffset, 0])
                intersection(){
                    translate([-vDiameter/4, 0, 0])
                        cylinder(h=tubeLength, d=vDiameter);
                    translate([vDiameter/4, 0, 0])
                        cylinder(h=tubeLength, d=vDiameter);
                }
            
            cylinder(h=tubeLength, d=tubeDiameter);
        }
        
        // mount
        postDiameter=8.35;
        postLength=23;
        mountDiameter=17;
        translate([0, -19, tubeLength/2])
        rotate([-90, 0, 0])
        union() {
            cylinder(h=postLength-mountDiameter, d=postDiameter);
            translate([0, 0, -postLength + mountDiameter])
            sphere(d=mountDiameter, $fn=100);
        }
        
        // pin
        pinDiameter=2.75;
        guardDiameter=8.5;
        translate([0, tubeDiameter/2 + guardDiameter/2, 0])
        difference() {
            union() {
                translate([-guardDiameter/2, -5, 0])
                cube([guardDiameter, guardDiameter-4, tubeLength]);
                cylinder(h=tubeLength, d=guardDiameter, $fn=180);
            }
            
            translate([0, 0, -1])
            cylinder(h=tubeLength+2, d=pinDiameter, $fn=100);
        }
    }
    
    // bottom cutout
    cutoutHeight=11.5;
    cutoutWidth=8.6;
    cutoutDepth=18;
    translate([-cutoutWidth/2, cutoutDepth/2, tubeLength/2 - cutoutHeight/2])
        cube([cutoutWidth, cutoutDepth, cutoutHeight]);
}
