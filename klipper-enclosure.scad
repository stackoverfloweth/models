union() {
  import("/Users/evansutherland/Downloads/Simple+Cover_Casing+for+BTT+-+big+tree+tech+HDMI+5/BTTHDMI5_V4.stl");
  translate([10, 0, 3])
  rotate([0, 0, 90])
  pi_mount();
}

module pi_mount() {
  intersection() {
    translate([10, 0.5, -5.1])
    cube([100, 100, 4], center=true);
    mirror([0, 0, 1])
    import("/Users/evansutherland/Downloads/Raspberry Pi 4 Mounting Plate v10.stl");
  }
}