width=205;
length=203;
height=140;
post=9;
depth=3;

union() {
    difference() {
        union() {            
            color([1, 0, 0])
            difference() {
                cube([width+depth*2, length+depth*2, height], true);
                
                translate([0, 0, 5])
                cube([width+depth*2, length+depth*2, 118], true);
            }
            
            intersection() {
                translate([0, 0, 5])
                cube([width+depth*2, length+depth*2, 118], true);
                
                union() {
                    translate([-104, -104, -50])
                    rotate([90, 0, 0])
                    hex_grid();
                    
                    translate([-104, 104, -50])
                    rotate([90, 0, 0])
                    hex_grid();
                    
                    translate([-105, -104, -50])
                    rotate([90, 0, 90])
                    hex_grid();
                    
                    translate([105, -104, -50])
                    rotate([90, 0, 90])
                    hex_grid();
                }
            }
        }
        
        translate([0, 0, 0])
        cube([width, length, height + 20], true);
    }
    
    translate([-width/2-depth/2, -length/2-depth/2, 0])
    cube([depth, depth, height], true);
    
    translate([width/2+depth/2, -length/2-depth/2, 0])
    cube([depth, depth, height], true);
    
    translate([width/2+depth/2, length/2+depth/2, 0])
    cube([depth, depth, height], true);
    
    translate([-width/2-depth/2, length/2+depth/2, 0])
    cube([depth, depth, height], true);

    translate([-82, 89.5, -70])
    track();
    
    translate([-82, -104.5, -70])
    track();

    rotate([0, 0, 90])
    translate([-82, 90.5, -70])
    track();

    rotate([0, 0, 90])
    translate([-82, -105.5, -70])
    track();
}

module track() {
    trackPiece();
    
    translate([75+post+depth*2, 0, 0])
    trackPiece();
}

module trackPiece() {
    difference() {
        cube([75, post+depth*2, post+depth*2]);
        
        translate([0, depth, depth])
        cube([75, post, post+depth]);
    }
}

outer_hex = 5;
inner_hex = 4;
wall_depth = outer_hex - inner_hex;
tile_height = depth;
n = 14;
m = 32;

module hexagon(x) circle(r=x, $fn=6);
module hollow_hex(x, inner_x) difference(){hexagon(x); hexagon(inner_x);}
module hex_cylinder(height=0.1) linear_extrude(height=height, center=true) hollow_hex(outer_hex, inner_hex);

bump_y_vec = [0,(outer_hex * sqrt(3))-wall_depth/2,0];
bump_x_vec = [outer_hex * sqrt(2),0,0];


module hex_column(n) {
    union() {
        for (i =[0:n-1]){
            translate(i * bump_y_vec) hex_cylinder(tile_height);
        }
    }
}

module hex_grid() {
    union() {
        for (i = [0:2:m-1]) {
            translate(i*bump_x_vec) hex_column(n);
        }
        for (i = [1:2:m-1]) {
            translate(i*(bump_x_vec) + bump_y_vec/2) hex_column(n);
        }
    }
}