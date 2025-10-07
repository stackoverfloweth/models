bed_frame_width=20;
bed_frame_depth=22.5;

holder_width=48;
holder_height=100;
holder_thickness=4;

remote_width=40;
remote_depth=14;

union() {
  // bed frame hanger
  difference() {
    translate([-holder_thickness/2-2, 0, 0])
      cube([bed_frame_width+holder_thickness, holder_width, bed_frame_depth+holder_thickness], center=true);
    translate([-2, 0, -holder_thickness/2])
      cube([bed_frame_width, holder_width, bed_frame_depth], center=true);
  }

  // long connection
  translate([bed_frame_width/2, 0, -holder_height/2+bed_frame_depth/2+holder_thickness/2])
    cube([holder_thickness, holder_width, holder_height], center=true);

  // remote box
  difference() {
    translate([-holder_thickness+remote_depth-2, -holder_width/2, -holder_height])
      cube([remote_depth+holder_thickness*2, holder_width, 50]);
    translate([-holder_thickness+remote_depth+holder_thickness-2, -remote_width/2, -holder_height+holder_thickness/2])
      cube([remote_depth, remote_width, 50]);
  }
}