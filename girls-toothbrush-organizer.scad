max_width=245;
max_length=455;

depth=18;

lg_brush_width=32;
lg_brush_length=210;

sm_brush_width=16;
sm_brush_length=170;

brush_head_width=16;
brush_head_length=depth-2;

toothpaste_holder_width=10;
toothpaste_holder_length=36;

difference() {
  cube([max_width/3, 236, depth]);

  translate([21, 20, depth])
    lg_brush();

  translate([50, 15, depth])
    sm_brush();

  translate([50, sm_brush_length+30, depth])
    brush_head();

  translate([70, 15, depth])
    sm_brush();

  translate([70, sm_brush_length+30, depth])
    brush_head();

  translate([42, sm_brush_length+42, depth])
    toothpaste_holder();
}

module lg_brush() {
  rotate([0, 90, 90])
  hull() {
    sphere(d=lg_brush_width, $fn=120);
    translate([0, 0, lg_brush_length-lg_brush_width/2])
    sphere(d=lg_brush_width, $fn=120);
  }
}

module sm_brush() {
  rotate([0, 90, 90])
  hull() {
    sphere(d=sm_brush_width, $fn=120);
    translate([0, 0, sm_brush_length-sm_brush_width/2])
    sphere(d=sm_brush_width, $fn=120);
  }
}

module brush_head() {
  translate([0, 0, -brush_head_length])
  rotate([0, 0, 90])
  cylinder(d=brush_head_width, h=brush_head_length, $fn=120);
}

module toothpaste_holder() {
  translate([0, 0, -depth+2])
  cube([toothpaste_holder_length, toothpaste_holder_width, depth-2]);
}