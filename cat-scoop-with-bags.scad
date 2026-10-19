$fn = 100;
bag_width = 64;
bag_height = 32;
hole_diameter = 30;
parts_scale = 1.25;

pin_d        = 7.0;   // clearance fit in 7.2mm hole
pin_length   = 75;    // passes through 67mm bag + overhang for c-clamp
groove_depth = 1.0;   // how deep the groove is cut
groove_width = 1.5;   // width of groove channel
groove_pos   = 4.0;   // distance from pin end to groove center

union() {
  // rest();
  // body();
  // translate([0, -120, 0])
    filter();
  // translate([0, 120, 0]) {
  //   pin();
  //   translate([20, 0, 0])
  //   c_clamp();
  // }
}

module rest() {
  scale(parts_scale)
  import("cat-scoop-rest.stl");
}

// The socket (negative Z, including the flange) is clipped straight out of
// the original mesh, so the fit with the other parts stays the same.
// Above that, the arched tip is replaced by a straight extrusion of the
// cross-section — a square end — and sifting slots are cut through the sides.
filter_square_from = -5.5;  // inside the solid rib above the original slot row
filter_z_max = 70.875;

// The mesh below the cut keeps one row of back slots. Measured off the STL:
// opening 7.96 wide, pitch 13.375, capsule tops at z=-7.45. The rib between
// those openings is the margin every new slot keeps — between neighbors,
// above that row, and in from the rim.
filter_slot_w = 7.96;
filter_slot_pitch = 13.375;
filter_margin = filter_slot_pitch - filter_slot_w;
filter_row1_top = -7.45;
filter_slot_x0 = -25.92;
// Five columns line up with that original row. One extra column on each
// side, same pitch, sits on the square end only — the mesh has no hole
// there to line up with. Both stop about one margin short of the corner.
filter_slot_xs = [for (i = [-1:5]) filter_slot_x0 + i * filter_slot_pitch];

// Two equal rows fill the square end. Same margin above the original row,
// between the rows, and below the rim.
filter_band_bottom = filter_row1_top + filter_margin;
filter_band_top = filter_z_max - filter_margin;
filter_row_len = (filter_band_top - filter_band_bottom - filter_margin) / 2;

module filter_kept() {
  intersection() {
    import("cat-scoop-filter.stl");
    // from below the mating face up to the cut plane
    translate([-100, -100, -80])
      cube([200, 200, filter_square_from + 80]);
  }
}

module filter_section_at_cut() {
  projection(cut = true)
  translate([0, 0, -filter_square_from])
  import("cat-scoop-filter.stl");
}

module filter_square_end() {
  overlap = 0.4;
  translate([0, 0, filter_square_from - overlap])
  linear_extrude(height = filter_z_max - (filter_square_from - overlap), convexity = 8)
  filter_section_at_cut();
}

// Capsule lying along Z, driven through the part along X (side walls).
module filter_side_slot(y, z, length, width) {
  for (x0 = [-66, 46])
    translate([x0, y, z])
    hull() {
      rotate([0, 90, 0])
        cylinder(d = width, h = 20);
      translate([0, 0, length - width])
        rotate([0, 90, 0])
          cylinder(d = width, h = 20);
    }
}

// Capsule lying along Z, driven through the back wall along Y.
module filter_back_slot(x, z, length, width) {
  translate([x, 32, z])
  hull() {
    rotate([-90, 0, 0])
      cylinder(d = width, h = 20);
    translate([0, 0, length - width])
      rotate([-90, 0, 0])
        cylinder(d = width, h = 20);
  }
}

module filter() {
  scale(parts_scale)
  difference() {
    union() {
      filter_kept();
      filter_square_end();
    }

    // Back slots. The inner five line up with the original row. The outer
    // two are square-end only, at the same pitch.
    for (x = filter_slot_xs) {
      for (i = [0:1]) {
        bottom = filter_band_bottom + i * (filter_row_len + filter_margin);
        filter_back_slot(x, bottom + filter_slot_w/2, filter_row_len, filter_slot_w);
      }
    }

    // Deep cheek. The flat (about y=2 to y=22, both sides) holds one slot
    // at this margin; the old pair was 3.2mm apart and the rear one sat in
    // the corner. Stops where the cheek's front edge rises into the slot.
    filter_side_slot(13, -36 + filter_slot_w/2, 14, filter_slot_w);

    // Square-end cheeks, same rows and margin as the back. The section's
    // front tip is y=15.2; the slot starts one margin above that.
    side_y = 15.2 + filter_margin + filter_slot_w/2;
    for (i = [0:1]) {
      bottom = filter_band_bottom + i * (filter_row_len + filter_margin);
      filter_side_slot(side_y, bottom + filter_slot_w/2, filter_row_len, filter_slot_w);
    }
  }
}

module body() {
  difference() {
    union() {
      scale(parts_scale)
      import("cat-scoop-body.stl");
      translate([0, -60, 17.5])
      rotate([0, 90, 0])
      rotate([0, 0, 90])
      color("red")
      bag();
    }

    // cutout (holds next bag)
    default_body_height = 140;
    translate([-20, 0, default_body_height*parts_scale])
    cube([500, 3, 20], center=true);

    cylinder(h=10, d=hole_diameter);
  }
}

module bag() {
  difference() {
    cube([bag_height+10, bag_height+3, bag_width+3], center=true);
    hull() {
      cylinder(h=bag_width, d=bag_height, center=true);
      translate([-20, 0, 0])
      cylinder(h=bag_width, d=bag_height, center=true);
    }

    cylinder(h=100, d=7.2, center=true);
  }
}

module pin() {
  head_d = pin_d + 6;
  head_h = 3;

  difference() {
    union() {
      cylinder(h=pin_length, d=pin_d);
      cylinder(h=head_h, d=head_d);
    }
    
    translate([0, 0, pin_length - groove_pos])
    rotate_extrude()
    translate([pin_d/2 - groove_depth, -groove_width/2])
    square([groove_depth + 1, groove_width]);
  }
}

module c_clamp() {
  import("c-clip.stl");
}
