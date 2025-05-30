width=11.5;
height=22;
depth=7.5;

difference() {
  cube([width, height, depth], center=true);

  translate([0, 1, 0])
  cube([width-2, height+3, depth-2], center=true);
}

translate([0, -10, 0])
roof();

door();
mirror([1, 0, 0])
rotate([180, 0, 0])
door();

feet();

translate([0, 22, 0])
pad(false);

foot_size=0.75;
foot_offset=0.375;

pad_height=4;
pad_length=12;
pad_width=18;

module feet() {
  difference(){
    union() {
      translate([-width/2+foot_offset, height/2, -depth/2+foot_offset])
      foot();

      translate([width/2-foot_offset, height/2, -depth/2+foot_offset])
      foot();

      translate([-width/2+foot_offset, height/2, depth/2-foot_offset])
      foot();
      
      translate([width/2-foot_offset, height/2, depth/2-foot_offset])
      foot();

      translate([0, height/2+2.5, 0])
      cube([width, pad_height-2, depth], center=true);
    }

    cube([width-2, height*2, depth-2], center=true);
  }
}

module foot() {
  cube([foot_size, 6, foot_size], center=true);
}

module door() {
  translate([0, 0, depth/2])
  cube([width-1, height-1, 1], center=true);

  // handle
  color("orange")
  translate([4, 0, depth/2+0.75])
  cube([0.5, 2, 0.5], center=true);

  // grates low
  color("orange")
  translate([0, 10, depth/2+0.25])
  rotate([25, 0, 0])
  cube([2, .75, .75], center=true);
  
  color("orange")
  translate([0, 9.2, depth/2+0.25])
  rotate([25, 0, 0])
  cube([2, .75, .75], center=true);

  color("orange")
  translate([0, 8.4, depth/2+0.25])
  rotate([25, 0, 0])
  cube([2, .75, .75], center=true);

  // grates high
  color("orange")
  translate([0, -10, depth/2+0.25])
  rotate([25, 0, 0])
  cube([2, .75, .75], center=true);
  
  color("orange")
  translate([0, -9.2, depth/2+0.25])
  rotate([25, 0, 0])
  cube([2, .75, .75], center=true);

  color("orange")
  translate([0, -8.4, depth/2+0.25])
  rotate([25, 0, 0])
  cube([2, .75, .75], center=true);


  // hinges
  color("orange")
  translate([-5, 0, depth/2])
  cube([1, .75, 2], center=true);

  color("orange")
  translate([-5, 10, depth/2])
  cube([1, .75, 2], center=true);

  color("orange")
  translate([-5, -10, depth/2])
  cube([1, .75, 2], center=true);
}

module roof() {
  union() {
    translate([-width/2-0.5, -12.2, 0])
      roofSide();
    rotate([0, 180, 0])
    translate([-width/2-0.5, -12.2, 0])
      roofSide();

      
    translate([0, -10, 0])
    cube([width-2.5, 2, depth-2.5], center=true);
  }
}

module pad(withEars=true) {

  difference() {
    union() {
      cube([pad_width, pad_height , pad_length], center=true);

      if (withEars) {
        // mouse ears
        mouse_height=0.1;
        mouse_width=5;
        translate([pad_width/2, pad_height/2-mouse_height, pad_length/2])
        rotate([90, 0, 0])
        cylinder(h=mouse_height, d=mouse_width, center=true, $fn=100);

        translate([-pad_width/2, pad_height/2-mouse_height, pad_length/2])
        rotate([90, 0, 0])
        cylinder(h=mouse_height, d=mouse_width, center=true, $fn=100);

        translate([-pad_width/2, pad_height/2-mouse_height, -pad_length/2])
        rotate([90, 0, 0])
        cylinder(h=mouse_height, d=mouse_width, center=true, $fn=100);

        translate([pad_width/2, pad_height/2-mouse_height, -pad_length/2])
        rotate([90, 0, 0])
        cylinder(h=mouse_height, d=mouse_width, center=true, $fn=100);
      }
    }

    cube([width-2, pad_height, depth-2], center=true);

    translate([0, -1, 0])
    cube([width+0.25, pad_height-2, depth+0.25], center=true);
  }
}

module roofSide() {
  height=1.2;
  width=12.5;
  depth=4.25;

  polyhedron(
    points=[[0,0,0], [width,0,0], [width,height,0], [0,height,0], [0,height,depth], [width,height,depth]],
    faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
  );
}