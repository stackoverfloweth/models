thinner_wall_width = 20.25;
thicker_wall_width = 26.50;

// Crib mount parameters
original_gap = 25.1;
gap_width = thinner_wall_width + 2;  // absolute gap between inner faces of uprights

crib_mount();

module main() {
  union() {
    rotate([0, 0, 36])
    import("/Users/evansutherland/Documents/Models/obj_1_g3-instant-mount-no-clips.stl");
    translate([42.52, -0.95, 18.905])
    rotate([0, 0, 270])
    color("red")
    import("/Users/evansutherland/Downloads/ubiquiti_g3_instant_adapter_15_degrees.stl");

  }
}

module crib_mount() {
    stl = "/Users/evansutherland/Documents/Models/crib-mount.stl";

    // Base (everything below Z=10.5)
    intersection() {
        import(stl);
        translate([0, 0, -1])
        cube([200, 200, 11.5+1], center=true);
    }

    // Left upright (X < 0), shifted outward by (gap_width - original_gap)/2
    translate([-(gap_width - original_gap)/2, 0, 0])
    intersection() {
        import(stl);
        translate([-50, 0, 50])
        cube([100, 200, 200], center=true);
    }

    // Right upright (X > 0), shifted outward by (gap_width - original_gap)/2
    translate([(gap_width - original_gap)/2, 0, 0])
    intersection() {
        import(stl);
        translate([50, 0, 50])
        cube([100, 200, 200], center=true);
    }
}