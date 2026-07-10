pen_slot_width = 16;   // ~13mm for a Sharpie barrel (~12mm diameter)
pen_slot_depth = 16;    // how deep into the stake the slot cuts
slot_length = 120;     // length of the slot along the shaft
clip_width = 12;
clip_depth = 1;
dome_radius = 30;  // radius of the half circle
wall_thickness = 2.5;
$fn = 180;

difference() {
  union() {
    scale([1.4, 1.4, 1.4])
    translate([-94.25, -79.75, -pen_slot_depth+8]) {
      difference() {
        import("/Users/evansutherland/Downloads/obj_1_LandscapingFabricStake.stl");
        
        translate([27, 60, 0])
        cube([110, 60, 60]);
      }
    }

    difference() {
      // slab
      translate([0, 0, -9.5])
      cube([slot_length, 60, wall_thickness], center=true);

      // clip cutout
      clip_length = 80;
      translate([-slot_length/2+clip_length/2, 0, -9.5])
      cube([clip_length, clip_width, clip_depth], center=true);
    }

    // pen slot
    translate([0, 0, -8.5])
    difference() {
      rotate([0, 90, 0])
      linear_extrude(height=slot_length, center=true)
      difference() {
        circle(r=dome_radius);
        translate([dome_radius, 0])
        square(dome_radius * 2, center=true);
      }
      translate([-slot_length/2-10, -pen_slot_width/2, 0])
      cube([slot_length, pen_slot_width, pen_slot_depth]);
    }
  }

  translate([0, 0, 19])
  cube([300, 300, 20], center=true);

  translate([0, 0, -11.75])
  cube([400, 300, 2], center=true);
}
