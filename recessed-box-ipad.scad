gang_box_width = 95.5;
gang_box_height = 59.5;

difference() {
    union() {
        import("/Users/evansutherland/Downloads/Recessed+Wall+Box/Recessed Wall Box.stl");

        translate([20, 0, 88.5])
        difference() {
            cube([160, 120, 3], true);
            
            cube([150, 80, 5], true);
        }
    }

    translate([20, -40, 40])
    cube([gang_box_width, 8, gang_box_height], true);
    
    translate([20, 0, 88.5])
    union() {
        box_offset = 40;
        standard_distance = 83;

        translate([0, box_offset, -5])
        cylinder(h=10, d=3, $fn=100);

        translate([0, box_offset-standard_distance, -5])
        cylinder(h=10, d=3, $fn=100);
    }
}