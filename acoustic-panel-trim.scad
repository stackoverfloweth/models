$fn = 180;
panel_width = 27;
panel_gap = 12.75;
panel_depth = 12.5;
trim_thickness = 2;
trim_height = 10;

union() {
  trim();
  for (i = [0:4]) {
    translate([(panel_width+panel_gap)*i, 0, 0])
    trim();
  }

  // bottom cable track
  // translate([0, trim_height, 0])
  // difference() {
  //   cube([200.75-trim_thickness, 20, panel_depth+trim_thickness]);

  //   translate([0, trim_thickness, trim_thickness])
  //   cube([200.75-trim_thickness, 20-trim_thickness*2, panel_depth]);
  // }
}

// // generic keyboard arms
// arm_width = 64;
// arm_depth = 10;
// lip_thickness = 5;

// union() {
//   mirror([0, 0, 1])
//   union() {
//     full_trim();
//     for(i = [0:7]) {
//       translate([0, trim_height*i, 0])
//       full_trim();
//     }
//   }

//   translate([-panel_gap, 0, -panel_depth-trim_thickness])
//   arm(panel_gap, arm_width);
//   // translate([-trim_thickness, 0, 0])
//   // arm(panel_width + trim_thickness*2, arm_width - panel_depth - trim_thickness, with_hull = false);
//   translate([panel_width, 0, -panel_depth-trim_thickness])
//   arm(panel_gap, arm_width);
// }

// module arm(width, length, with_hull = true) {
//   cube([width, arm_depth, length + panel_depth]);

//   // for strength
//   if (with_hull) {
//     hull() {
//       cube([width, arm_depth, panel_depth + trim_thickness]);
//       cube([width, trim_height * 8, 1]);
//     }
//   }

//   // lip
//   translate([0, lip_thickness, length + panel_depth - lip_thickness])
//   cube([width, arm_depth, lip_thickness]);
// }

// mercedes mount
// union() {
//   full_trim();
//   for(i = [0:7]) {
//     translate([0, trim_height*i, 0])
//     full_trim();
//   }

//   translate([-114.5, 30, 118])
//   rotate([270, 0, 0])
//   import("/Users/evansutherland/Downloads/obj_1_Body_02.stl");
// }

// mclaren mount
// union() {
//   full_trim();
//   for(i = [0:7]) {
//     translate([0, trim_height*i, 0])
//     full_trim();
//   }

//   translate([-6, -88, 117.5])
//   rotate([0, 90, 0])
//   import("/Users/evansutherland/Downloads/obj_1_McClaren Lego Wall Mount V1.STL.stl");
// }

module trim() {
  union() {
    color("orange")
    cube([panel_width, trim_height, trim_thickness]);

    color("yellow")
    translate([panel_width, 0, 0])
    cube([trim_thickness, trim_height, panel_depth+trim_thickness]);

    color("green")
    translate([panel_width, 0, panel_depth])
    cube([panel_gap, trim_height, trim_thickness]);

    color("blue")
    translate([panel_width+panel_gap-trim_thickness, 0, 0])
    cube([trim_thickness, trim_height, panel_depth+trim_thickness]);
  }
}

module full_trim() {
  union() {
    trim();
    mirror([1, 0, 0])
    translate([-panel_width, 0, 0])
    trim();
  }
}

inner_width = 74.5;
inner_height = 114;

// union() {
//   outlet_trim();
//   translate([0, inner_height+trim_height, 0])
//   outlet_trim();

//   translate([-trim_thickness-15-trim_height, 0, 0])
//   cube([trim_height, inner_height+trim_height+trim_height, trim_thickness]);

//   color("blue")
//   translate([-trim_thickness-15-trim_height+inner_width+trim_height-trim_thickness, trim_height, 0])
//   cube([trim_thickness, inner_height+trim_height-trim_height, panel_depth+trim_thickness]);

//   color("aqua")
//   translate([-trim_thickness-15-trim_height+inner_width+trim_height-inner_width, trim_height, 0])
//   cube([trim_thickness, inner_height+trim_height-trim_height, panel_depth+trim_thickness]);

//   translate([-trim_thickness-15-trim_height+inner_width+trim_height, 0, 0])
//   cube([trim_height, inner_height+trim_height+trim_height, trim_thickness]);

//   color("pink")
//   translate([-trim_thickness-15, trim_height, 0])
//   cube([inner_width, trim_thickness, panel_depth+trim_thickness]);

//   color("purple")
//   translate([-trim_thickness-15, trim_height+inner_height-trim_thickness, 0])
//   cube([inner_width, trim_thickness, panel_depth+trim_thickness]);
// }

module outlet_trim() {
  union() {
    translate([-trim_thickness-15, 0, 0])
    color("orange")
    cube([trim_thickness+15, trim_height, trim_thickness]);

    color("blue")
    translate([-trim_thickness, 0, 0])
    cube([trim_thickness, trim_height, panel_depth+trim_thickness]);
    
    color("green")
    translate([-trim_thickness, 0, panel_depth])
    cube([panel_gap, trim_height, trim_thickness]);

    color("red")
    translate([panel_gap-trim_thickness*2, 0, 0])
    cube([trim_thickness, trim_height, panel_depth+trim_thickness]);

    translate([panel_gap-trim_thickness, 0, 0])
    color("orange")
    cube([panel_width, trim_height, trim_thickness]);

    color("yellow")
    translate([panel_gap+panel_width-trim_thickness, 0, 0])
    cube([trim_thickness, trim_height, panel_depth+trim_thickness]);

    color("green")
    translate([panel_gap+panel_width-trim_thickness, 0, panel_depth])
    cube([panel_gap, trim_height, trim_thickness]);

    color("blue")
    translate([panel_gap+panel_width+panel_gap-trim_thickness*2, 0, 0])
    cube([trim_thickness, trim_height, panel_depth+trim_thickness]);

    translate([panel_gap+panel_width+panel_gap-trim_thickness*2, 0, 0])
    color("orange")
    cube([trim_thickness+7, trim_height, trim_thickness]);
  }
}


// union() {
//   outlet_half_trim();
//   translate([0, inner_height+trim_height, 0])
//   outlet_half_trim();

//   translate([-trim_thickness-15-trim_height+inner_width+trim_height+2, 0, 0])
//   cube([trim_height, inner_height+trim_height+trim_height, trim_thickness]);

//   color("blue")
//   translate([-trim_thickness-15-trim_height+inner_width+trim_height+2, trim_height, 0])
//   cube([trim_thickness, inner_height+trim_height-trim_height, panel_depth+trim_thickness]);

//   color("pink")
//   translate([panel_gap-trim_thickness*2, trim_height, 0])
//   cube([50.25+trim_thickness, trim_thickness, panel_depth+trim_thickness]);

//   color("purple")
//   translate([panel_gap-trim_thickness*2, trim_height+inner_height, 0])
//   cube([50.25+trim_thickness, trim_thickness, panel_depth+trim_thickness]);
// }

module outlet_half_trim() {
  union() {
    color("red")
    translate([panel_gap-trim_thickness*2, 0, 0])
    cube([trim_thickness, trim_height, panel_depth+trim_thickness]);

    translate([panel_gap-trim_thickness, 0, 0])
    color("orange")
    cube([panel_width, trim_height, trim_thickness]);

    color("yellow")
    translate([panel_gap+panel_width-trim_thickness, 0, 0])
    cube([trim_thickness, trim_height, panel_depth+trim_thickness]);

    color("green")
    translate([panel_gap+panel_width-trim_thickness, 0, panel_depth])
    cube([panel_gap, trim_height, trim_thickness]);

    color("blue")
    translate([panel_gap+panel_width+panel_gap-trim_thickness*2, 0, 0])
    cube([trim_thickness, trim_height, panel_depth+trim_thickness]);

    translate([panel_gap+panel_width+panel_gap-trim_thickness*2, 0, 0])
    color("orange")
    cube([trim_thickness+9, trim_height, trim_thickness]);
  }
}