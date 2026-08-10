$fn = 180;
yubico_width = 18;
yubico_height = 45;
clearance = 0.3;
tall_size = 50;

difference() {
  import("/Users/evansutherland/Downloads/ridge-wallet-organizer-insert.stl");
  translate([64, 4.25, 0])
  cube([yubico_width + clearance, yubico_height + clearance, 100]);

  translate([64, 27.5, 0])
  cylinder(h = 100, d = 20, $fn = 100);
}