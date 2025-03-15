width=214;
height=114.3;
depth=5;

controller_width=48+0.5;
controller_height=88+0.5;
controller_offset=210/2-controller_width/2;

union () {
    difference() {
        cube([width, height, depth], true);
        cube([width-3, height-3, depth], true);
    }

    intersection() {
        // inner hex
        difference() {
            cube([width, height, depth], true);
            
            // controller cutout
            translate([-controller_offset, 0, 0])
            cube([controller_width, controller_height, depth], true);
            
            translate([controller_offset, 0, 0])
            cube([controller_width, controller_height, depth], true);
        }
        
        translate([-width/2, -height/2, 0])
        hex_grid();
    }
    
    // controller box
    difference() {
        translate([-controller_offset, 0, 0])
        cube([controller_width+3, controller_height+3, depth], true);
            
        translate([-controller_offset, 0, 1.5])
        cube([controller_width, controller_height, depth], true);
    }

    difference() {
        translate([controller_offset, 0, 0])
        cube([controller_width+3, controller_height+3, depth], true);
        
        translate([controller_offset, 0, 1.5])
        cube([controller_width, controller_height, depth], true);
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