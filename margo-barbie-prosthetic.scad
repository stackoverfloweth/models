upper_d1 = 22;
upper_d2 = 14;
upper_length = 30;

upper_inset_length = 21.15;

knee_length = 10;
knee_d1 = 10;
knee_width = 19.08;

lower_d1 = 12;
lower_d2 = 8;
lower_length = 77;

foot_length = 21;
foot_height = 4;
foot_width = 7.8;

space = 12;

difference() {
  union() {
    upperLeg();

    translate([0, 0, upper_length + knee_length + space])
      lowerLeg();

    translate([0, 0, upper_length + knee_length + space + lower_length])
      foot();
  }

  // knee hole
  // translate([0, foot_length/2, (upper_length + lower_length) * 0.4])
  //   rotate([90, 0, 0])
  //     cylinder(h=foot_length, d=6, $fn=180);
}

module thigh(length) {
  translate([-1, 0, 0])
  hull() {
    cylinder(h=length, d1=upper_d1, d2=upper_d2, $fn=180);
    translate([2, 0, 0])
      cylinder(h=length, d1=upper_d1, d2=upper_d2, $fn=180);
    translate([-1, 0, length+4])
      sphere(d=10, $fn=180);
  }
}

module upperLeg() {
  difference() {
    union() {
      hull() {  
        // smooth part
        scale([1.2, 1.2, 1])
          thigh(upper_length*0.8);

        // blocky transition
        translate([0, 0, upper_length*0.85])
          cylinder(h=upper_length*0.2, d1=upper_d2, d2=lower_d1+4, $fn=8);
      }

      translate([0, 0, upper_length-5])
        knee();
    }

    // thigh insert
    thigh(upper_length*.95);
  }
}

module knee() {
    inset_difference = 2;

  union() {
    difference() {
      hull() {
        translate([0, -knee_width/4, 0])
          rotate([0, 90, 90])
            cylinder(h=knee_width/2, d=knee_d1, $fn=180);

        translate([0, -knee_width/2, knee_length])
          rotate([0, 90, 90])
            cylinder(h=knee_width, d=knee_d1, $fn=180);
      }

      // knee_inside cutout
      translate([0, -knee_width/2+inset_difference/2, knee_width/2+.5])
        rotate([0, 90, 90])
          cylinder(h=knee_width-inset_difference, d=knee_d1-2, $fn=180);

      // cylinder cutout (front)
      translate([0, 0, knee_d1*1.5])
        rotate([0, 90, 0])
          cylinder(h=knee_width, d=12, $fn=180);

      // cube cutout (front)
      translate([-5, 0, knee_length + 5])
        rotate([0, 90, 0])
          cube([knee_d1, knee_d1 + inset_difference * 2 -2, knee_length], center=true);
    }

    // knee cap
    difference() {
      translate([-3, 0, -8])
        cylinder(h=knee_length+8, d=upper_d2, $fn=6);

      translate([0, 0, 3])
        cube([knee_d1, knee_width, knee_length+5], center=true);
    }
  }
}

module inside_knee() {
  inset_difference = 2.75;

  union() {
    translate([0, -knee_width/2+inset_difference/2, 0])
      rotate([0, 90, 90])
        cylinder(h=knee_width-inset_difference, d=knee_d1-2, $fn=180);
  }
}

module lowerLeg() {
  union() {
    inside_knee();

    difference() {
      cylinder(h=lower_length, d1=lower_d1, d2=lower_d2, $fn=7);

      translate([6, -knee_width/2, 2])
        rotate([0, 90, 90])
          cylinder(h=knee_width, d=8, $fn=180);
    }

    // knee cap
    translate([-3, 0, 0])
      cylinder(h=knee_length+5, d1=upper_d2, d2=5, $fn=6);

    // calf
    calf_length=34;
    hull() {
      translate([1, 0, 12 + calf_length])
        sphere(d=8, $fn=7);

      translate([4, 0, 12])
        sphere(d=13, $fn=7);
    }
  }
}

module foot() {
  hull() {
    // ankle
    cylinder(h=2, d=lower_d2, $fn=7);

    translate([1, 0, foot_height])
      cylinder(d=foot_width, h=2.5, center=true);
      
    translate([-foot_length+foot_width+1, 0, foot_height])
      cylinder(d=foot_width, h=2.5, center=true);
  }
}