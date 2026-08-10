$fn=180;
scale_by=1.05;

stl_path = "/Users/evansutherland/Downloads/Phone+pocket+for+Kmart+Eva+beach+bag+tote/beach bag fastener.stl";

// Shaft extension parameters
shaft_extension = 3;
cut_z = 3;          // Cut on the plain shaft (between disc and grooves)
shaft_r = 5.86;     // Shaft radius
obj_cx = -43.999;   // Object XY center
obj_cy = -47.001;

scale(scale_by)
union() {
    // Bottom part: disc + shaft below cut
    intersection() {
        import(stl_path);
        translate([obj_cx - 50, obj_cy - 50, -50])
            cube([100, 100, 50 + cut_z]);
    }

    // Fill the gap with a cylinder matching the shaft
    translate([obj_cx, obj_cy, cut_z])
        cylinder(r=shaft_r, h=shaft_extension);

    // Top part: shaft above cut + grooves, shifted up
    translate([0, 0, shaft_extension])
    intersection() {
        import(stl_path);
        translate([obj_cx - 50, obj_cy - 50, cut_z])
            cube([100, 100, 50]);
    }
}
