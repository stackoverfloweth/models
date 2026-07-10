difference() {
  // the bracket itself
  union() {
    rotate([180, 270, 0])
    import("/Users/evansutherland/Downloads/Slatwall_Mounting_Bracket_for_Magnetic_Tool_Holder_(or_anything!)/SlatWall_Mount2_v4.stl");
      
    translate([94, -14, 16])
    import("/Users/evansutherland/Downloads/DCB115 Wall Holder.stl");
  }

  // cube to subtract from front
  translate([-6, -50, 16])
  cube([50, 50, 50]);
}



