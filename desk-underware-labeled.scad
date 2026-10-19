// === Configuration ===
label = "DAC PSU";
label_font_size = 8;
label_depth = 0.8; // how deep the text is inset

// === Import and Center ===
// Actual STL bounding box: X [115.48, 140.52], Y [28, 228], Z [0, 11.47]
stl_min = [115.48, 28.00, 0.00];
stl_size = [25.03, 200.00, 11.47];

difference() {
    translate([-(stl_min.x + stl_size.x/2), -(stl_min.y + stl_size.y/2), -stl_min.z])
        import("/Users/evansutherland/Downloads/Underware+–+Ultimate+Cable+Management+System+(MB)/Underware - Channels-I/handsonkatie_channel-i08_top.stl");

    // Inset label on the bottom face, running along the length (y-axis), mirrored
    mirror([1, 0, 0])
        rotate([0, 0, 90])
            translate([0, 0, -0.01])
                linear_extrude(height = label_depth + 0.01)
                    text(label, size = label_font_size, font = "Liberation Sans:style=Bold",
                         halign = "center", valign = "center");
}