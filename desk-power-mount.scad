$fn = 120;
length = 180;
thickness = 10;
rail_width = 20.5;
rail_gap = 98;
ps_mount_hole_gap = 102.7;
ps_mount_hole_head = 5.25;
ps_mount_hole_thread = 4;
ps_mount_hole_depth = 2.5;
magnet_width = 9.8;
magnet_length = 20.3;
magnet_depth = 2;

union() {
  cube([length, rail_gap, thickness], center=true);
  translate([0, rail_width/2+rail_gap/2, 0]) {
    rail();
  }
  translate([0, -rail_width/2-rail_gap/2, 0]) {
    rail();
  }
  
  translate([-ps_mount_hole_gap/2, 0, -thickness/2])
  hook();

  translate([ps_mount_hole_gap/2, 0, -thickness/2])
  hook();
}


module rail() {
  color("red")
  difference() {
    cube([length, rail_width, thickness], center=true);
    translate([0, 0, thickness/2-magnet_depth/2-0.25])
      cube([length, magnet_width, magnet_depth], center=true);
  }
}

module hook() {
  color("blue")
  translate([0, 0, -ps_mount_hole_depth/2])
  union() {
    //thread
    cylinder(h=ps_mount_hole_depth, d=ps_mount_hole_thread, center=true);
    //head
    translate([0, 0, -ps_mount_hole_depth/2])
    cylinder(h=1, d=ps_mount_hole_head, center=true);
  }
}