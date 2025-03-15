height=3.4;
width=28.6;
depth=2.4;

difference() {
    hull() {
        translate([-width/2+height/2, 0, 0])
        cylinder(h=depth, d=height, $fn=180);
        
        translate([width/2-height/2, 0, 0])
        cylinder(h=depth, d=height, $fn=180);
    }
    
    hull() {
        translate([-width/2+height/2, 0, 0])
        cylinder(h=depth, d=height*.75, $fn=180);
        
        translate([width/2-height/2, 0, 0])
        cylinder(h=depth, d=height*.75, $fn=180);
    }
}