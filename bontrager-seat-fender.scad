$fn = 180;

screw_gap = 46;
screw_diameter = 5.25;
screw_head_diameter = 12;
bottom_front_gap = 40;
bottom_rear_gap = 65;
top_front_gap = 48.5;
top_rear_gap = 65;
level_1_height = 7;
level_2_height = 14.6;
width = 15;
rear_bulge = 5;
rear_bulge_power = 2; // higher = flatter near ends, sharper in middle
front_bulge = 1; // concave dip on front edge
front_bulge_power = 2;
arc_steps = 30;

difference() {
  union() {
    cleat();
    hull() {
      translate([0, 0, level_1_height])
        linear_extrude(height = 0.01)
          cleat_polygon(top_front_gap, top_rear_gap, rear_offset = -front_drop);
      translate([0, 0, -1])
      top_bar();
      
      translate([0, 0, 10])
      mirror([0, 0, 1])
      fender();
    }
  }

  front_concave_cutout();
  miter_cuts();

  // Screws
  translate([-screw_gap / 2, width - 7, 0])
    cylinder(h = level_2_height, d = screw_diameter);
  translate([-screw_gap / 2, width - 7, 4])
    cylinder(h = 14, d = screw_head_diameter);
  translate([screw_gap / 2, width - 7, 0])
    cylinder(h = width, d = screw_diameter);
  translate([screw_gap / 2, width - 7, 4])
    cylinder(h = 14, d = screw_head_diameter);
}

module top_bar(bar_width = 80, bar_depth = 4, droop = true, bar_droop = 4) {
  effective_droop = droop ? bar_droop : 0;

  for (i = [0 : arc_steps - 1]) {
      a1 = 180 * i / arc_steps;
      a2 = 180 * (i + 1) / arc_steps;

      x1 = bar_width / 2 * cos(a1);
      x2 = bar_width / 2 * cos(a2);
      z1 = level_2_height - effective_droop * pow(cos(a1), 2);
      z2 = level_2_height - effective_droop * pow(cos(a2), 2);
      y1 = bar_depth + (rear_bulge + 2) * pow(sin(a1), rear_bulge_power);
      y2 = bar_depth + (rear_bulge + 2) * pow(sin(a2), rear_bulge_power);

      hull() {
          translate([x1, -1 + y1 / 2, z1])
              cube([0.01, y1, 0.01], center = true);
          translate([x2, -1 + y2 / 2, z2])
              cube([0.01, y2, 0.01], center = true);
      }
  }
}

front_drop = 5;

module cleat_polygon(front, rear, rear_offset = 0) {
    polygon(concat(
        [[-front / 2, 0], [front / 2, 0]],
        [for (i = [0 : arc_steps])
            let(a = 180 * i / arc_steps)
            [rear / 2 * cos(a), width + rear_bulge * pow(sin(a), rear_bulge_power) + rear_offset]
        ]
    ));
}

module miter_cuts() {
    bar_width = 75;
    bar_droop = 4;
    miter_angle = atan2(bar_droop, bar_width / 2 - top_rear_gap / 2) - 12;

    // Right miter
    translate([(top_rear_gap / 2) + 3, 0, 0])
        rotate([0, 0, -miter_angle])
            translate([0, -50, 0])
                cube([100, 100, 100]);

    // Left miter (mirrored)
    mirror([1, 0, 0])
        translate([(top_rear_gap / 2) + 3, 0, 0])
            rotate([0, 0, -miter_angle])
                translate([0, -50, 0])
                    cube([100, 100, 100]);
}

module front_concave_cutout() {
    // Cylinder-based concave scoop along the front edge
    // Radius is calculated so the sagitta (depth) equals front_bulge
    r = (top_front_gap / 2) * (top_front_gap / 2) / (2 * front_bulge) + front_bulge / 2;
    translate([0, -r + front_bulge, 0])
        cylinder(h = level_2_height*2, r = r);
}

module cleat() {
  steps = 20;

  for (i = [0 : steps - 1]) {
      t1 = i / steps;
      t2 = (i + 1) / steps;
      hull() {
          translate([0, 0, t1 * level_1_height])
              linear_extrude(height = 0.01)
                  cleat_polygon(
                      bottom_front_gap + t1 * (top_front_gap - bottom_front_gap),
                      bottom_rear_gap + t1 * (top_rear_gap - bottom_rear_gap),
                      rear_offset = -front_drop * t1
                  );

          translate([0, 0, t2 * level_1_height])
              linear_extrude(height = 0.01)
                  cleat_polygon(
                      bottom_front_gap + t2 * (top_front_gap - bottom_front_gap),
                      bottom_rear_gap + t2 * (top_rear_gap - bottom_rear_gap),
                      rear_offset = -front_drop * t2
                  );
      }
  }
}

module fender(length = 200, base_width = 60, thickness = 1, lift = 45, tip_width = 10, lift_curve = 3, steps = 40) {
    for (i = [0 : steps - 1]) {
        t1 = i / steps;
        t2 = (i + 1) / steps;

        w1 = tip_width + (base_width - tip_width) * pow(1 - t1, 0.7);
        w2 = tip_width + (base_width - tip_width) * pow(1 - t2, 0.7);

        th1 = thickness * max(1 - t1 * 0.9, 0.1);
        th2 = thickness * max(1 - t2 * 0.9, 0.1);

        y1 = t1 * length;
        y2 = t2 * length;
        z1 = fender_z(t1, lift);
        z2 = fender_z(t2, lift);

        if (w2 > 0.3) {
            hull() {
                translate([0, y1, z1])
                    rotate([90, 0, 0])
                        linear_extrude(height = 0.01)
                            fender_cross(w1, th1);
                translate([0, y2, z2])
                    rotate([90, 0, 0])
                        linear_extrude(height = 0.01)
                            fender_cross(w2, th2);
            }
        }
    }
}

// Piecewise linear: 3 sections with a sharp rise in the middle
//   Section 1 (0 to rise_start): flat on build plate
//   Section 2 (rise_start to rise_end): steep rise
//   Section 3 (rise_end to 1): gentle slope
function fender_z(t, lift, rise_start = 0.15, rise_end = 0.55, rise_share = 0.85) =
    let(
        steep = lift * rise_share
    )
    t <= rise_start
        ? 0
        : t <= rise_end
            ? steep * ((t - rise_start) / (rise_end - rise_start))
            : steep;

module fender_cross(w, thick) {
    square([w, thick], center = true);
}