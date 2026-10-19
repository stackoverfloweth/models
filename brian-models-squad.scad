base_width=25;
base_extra_spacing=0.5;
base_depth=1.5;
min_size=150;
max_size=200;
squad_spacing=5;

ten_man_tray_width=120;
ten_man_tray_depth=90;
ten_man_tray_corner_radius=5;
// Flat gap between socket edges on the tray (same idea as squad_spacing).
ten_man_socket_spacing=5;
skirmisher_tray_width=120;
skirmisher_tray_depth=60;
heavy_riders_tray_size=120;
// 25x50mm cavalry bases. Four files fit the 120mm width.
heavy_rider_base_length=50;
heavy_riders_per_rank=4;
heavy_rider_rank_gap=10;
$fn=180;

// squad_base(8, 4, false);
// tenManBase();
// skirmisherBase();
heavyRidersBase(6);

module squad_base(
  squad_size,
  per_row=6,
  skip=true,
  corner_radius=ten_man_tray_corner_radius
) {
  actual_size = skip ? squad_size * 2 : squad_size;
  actual_per_row = skip ? per_row * 2 : per_row;

  num_rows = ceil(actual_size / actual_per_row);
  actual_cols = min(actual_size, actual_per_row);

  // Include equal margin (squad_spacing) around the grid on all sides
  squad_width = actual_cols * base_width + (actual_cols + 1) * squad_spacing;
  squad_length = num_rows * base_width + (num_rows + 1) * squad_spacing;

  difference() {
    tray_plate(squad_width, squad_length, corner_radius, base_depth + 1);

    translate([1, 1, -1.5])
    tray_plate(
      squad_width - 2,
      squad_length - 2,
      max(corner_radius - 1, 1),
      base_depth + 1
    );
    translate([0, 0, 0.5])
    for (row = [0:num_rows-1]) {
      // Handle partial final row
      cols_in_row = min(actual_per_row, actual_size - row * actual_per_row);
      row_pos = squad_spacing + base_width/2 + row * (base_width + squad_spacing);
      translate([0, row_pos, 0])
      for (col = [0:cols_in_row-1]) {
        if(!skip || !should_skip(row, col)) {
          col_pos = squad_spacing + base_width/2 + col * (base_width + squad_spacing);
          translate([col_pos, 0, 0])
          cylinder(h=base_depth, d=base_width + base_extra_spacing);
        }
      }
    }
  }
}

function should_skip(row, col) = (row + col) % 2 == 0;

// Warrior unit: 10 models on 25mm bases, 3-4-3 hex stagger on a 120x90mm tray.
module tenManBase(
  width=ten_man_tray_width,
  depth=ten_man_tray_depth,
  corner_radius=ten_man_tray_corner_radius,
  socket_spacing=ten_man_socket_spacing
) {
  pitch = base_width + socket_spacing;
  row_dy = sqrt(pitch * pitch - (pitch / 2) * (pitch / 2));
  y0 = (depth - base_width - 2 * row_dy) / 2 + base_width / 2;
  x4 = (width - 3 * pitch) / 2;
  x3 = x4 + pitch / 2;

  difference() {
    tray_plate(width, depth, corner_radius, base_depth + 1);

    translate([1, 1, -1.5])
    tray_plate(
      width - 2,
      depth - 2,
      max(corner_radius - 1, 1),
      base_depth + 1
    );

    translate([0, 0, 0.5])
    union() {
      ten_man_row(x3, y0, pitch, 3);
      ten_man_row(x4, y0 + row_dy, pitch, 4);
      ten_man_row(x3, y0 + 2 * row_dy, pitch, 3);
    }
  }
}

// Skirmisher unit: 4 models on 25mm bases, loose stagger on a 120x60mm tray.
// Centers match the unit diagram (origin at the front-left corner):
// (15, 28), (45, 34), (75, 25), (105, 30).
module skirmisherBase(
  width=skirmisher_tray_width,
  depth=skirmisher_tray_depth,
  corner_radius=ten_man_tray_corner_radius,
  socket_spacing=ten_man_socket_spacing
) {
  pitch = base_width + socket_spacing;
  x0 = (width - 3 * pitch) / 2;
  // Offsets from the depth centerline, left to right.
  y_offsets = [-2, 4, -5, 0];

  difference() {
    tray_plate(width, depth, corner_radius, base_depth + 1);

    translate([1, 1, -1.5])
    tray_plate(
      width - 2,
      depth - 2,
      max(corner_radius - 1, 1),
      base_depth + 1
    );

    translate([0, 0, 0.5])
    for (i = [0:len(y_offsets) - 1])
      translate([x0 + i * pitch, depth / 2 + y_offsets[i], 0])
      cylinder(h=base_depth, d=base_width + base_extra_spacing);
  }
}

// Heavy Riders: 25x50mm bases on a fixed 120x120mm tray.
// The full unit is 4 files by 2 ranks. Fewer slots keep two ranks,
// split as evenly as possible with the extra socket on the front rank.
// Each rank spreads across the full tray width: the side margins equal
// the gaps between bases, and that gap grows as the rank gets shorter.
module heavyRidersBase(
  slots=8,
  corner_radius=ten_man_tray_corner_radius
) {
  width = heavy_riders_tray_size;
  depth = heavy_riders_tray_size;
  assert(slots >= 1 && slots <= heavy_riders_per_rank * 2);

  rank_count = slots == 1 ? 1 : 2;
  front_count = ceil(slots / rank_count);
  back_count = slots - front_count;

  margin_y = (depth - 2 * heavy_rider_base_length - heavy_rider_rank_gap) / 2;
  y_front = margin_y + heavy_rider_base_length / 2;
  y_back = y_front + heavy_rider_base_length + heavy_rider_rank_gap;

  difference() {
    tray_plate(width, depth, corner_radius, base_depth + 1);

    translate([1, 1, -1.5])
    tray_plate(
      width - 2,
      depth - 2,
      max(corner_radius - 1, 1),
      base_depth + 1
    );

    translate([0, 0, 0.5])
    union() {
      heavy_rider_rank(front_count, rank_count == 1 ? depth / 2 : y_front);
      if (back_count > 0)
        heavy_rider_rank(back_count, y_back);
    }
  }
}

module heavy_rider_rank(count, y) {
  // count + 1 gaps: both side margins and the space between each base.
  gap = (heavy_riders_tray_size - count * base_width) / (count + 1);
  x0 = gap + base_width / 2;
  slot_w = base_width + base_extra_spacing;
  slot_l = heavy_rider_base_length + base_extra_spacing;

  for (col = [0:count - 1])
    translate([x0 + col * (base_width + gap), y, base_depth / 2])
    cube([slot_w, slot_l, base_depth], center=true);
}

module ten_man_row(x_start, y, pitch, count) {
  for (col = [0:count - 1]) {
    translate([x_start + col * pitch, y, 0])
    cylinder(h=base_depth, d=base_width + base_extra_spacing);
  }
}

module tray_plate(width, depth, corner_radius, height) {
  linear_extrude(height)
  rounded_rect(width, depth, corner_radius);
}

module rounded_rect(width, depth, radius) {
  r = min(radius, width / 2 - 0.01, depth / 2 - 0.01);
  translate([r, r, 0])
  minkowski() {
    square([width - 2 * r, depth - 2 * r]);
    circle(r=r, $fn=32);
  }
}