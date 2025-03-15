innerHeight = 10.50;
innerWidth = 47.20;
outerHeight = 19.10;
outerWidth = 54.62;
postHeight=5+8.28;

difference() {
    union() {
        innerPlug();
        
        //corner posts
        cornerRadius=1.5;
        
        translate([-innerWidth/2 + cornerRadius, 0, -2.5])
        cylinder(postHeight, r=cornerRadius, $fn=100);
        
        translate([innerWidth/2 - cornerRadius, 0, -2.5])
        cylinder(postHeight, r=cornerRadius, $fn=100);
        
        //tabs
        translate([-14, innerHeight/2-1.5, -2.5])
        tab();
        
        translate([8.5, innerHeight/2-1.5, -2.5])
        tab();
        
        rotate([0, 0, 180])
        translate([-15, innerHeight/2-1.5, -2.5])
        tab();
        
        rotate([0, 0, 180])
        translate([7.5, innerHeight/2-1.5, -2.5])
        tab();
        
        //outside facet
        translate([0, 0, -1.5])
        cube([outerWidth, outerHeight, 2], center=true);
    }
    
    cube([40, 8, 50], center=true);
}

module tab() {
    tabWidth=6;
    union() {
        cube([tabWidth, 1.5, postHeight-3]);
        
        translate([0, 1.5, 13.25])
        rotate([0, 90, 0])
        linear_extrude(tabWidth)
        polygon(points=[[0, -1.5],[1.75, 0.75],[10, -1.5]], paths=[[0,1,2]]);
    }
}

module innerPlug() {
    union() {
        radius = innerHeight/2;
        translate([innerWidth/2 - radius, 0, 0])
        cylinder(5, d=innerHeight, center=true, $fn=100);

        translate([-innerWidth/2 + radius, 0, 0])
        cylinder(5, d=innerHeight, center=true, $fn=100);
        
        translate([-innerWidth/2 + radius, -innerHeight/2, -2.5])
        cube([innerWidth-innerHeight, innerHeight, 5]);
    }
}