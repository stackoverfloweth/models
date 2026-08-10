// Ridge Wallet Organizer - Pocket Insert (Inverse Space)
// Creates an insert for the large open pocket only.
// Adjust pocket position/size to match your tray, then preview.

// Position and size of the open pocket region (tweak these to fit)
pocket_height = 4.1;  // Z depth of pocket

// Clearance so the insert fits loosely enough to remove
clearance = 0.3;

difference() {
    union() {
        translate([54, 2, 0])
        color("red")
        cube([
            30,
            50,
            pocket_height 
        ]);

        translate([28, 2, 0])
        color("green")
        cube([
            50,
            14,
            pocket_height 
        ]);

        translate([40, 0, 0])
        rotate([0, 0, 48])
        color("blue")
        cube([
            50,
            13,
            pocket_height 
        ]);

        translate([38, 3, 0])
        rotate([0, 0, 30])
        color("pink")
        cube([
            50,
            13,
            pocket_height 
        ]);
    }

    // Subtract the original tray to carve out the inverse
    translate([0, 0, 5.8])
    import("/Users/evansutherland/Downloads/Slim%20AirTag%20-%20Ridge%20-%204.5mm.stl");
}
