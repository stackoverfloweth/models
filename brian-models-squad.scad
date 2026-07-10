base_width=25;
base_extra_spacing=0.5;
base_depth=1.5;
min_size=150;
max_size=200;
squad_spacing=5;
$fn=180;

squad_base(9, per_row=3);

module squad_base(squad_size, per_row=6, skip=true) {
  actual_size = skip ? squad_size * 2 : squad_size;
  actual_per_row = skip ? per_row * 2 : per_row;

  num_rows = ceil(actual_size / actual_per_row);
  actual_cols = min(actual_size, actual_per_row);

  // Include equal margin (squad_spacing) around the grid on all sides
  squad_width = actual_cols * base_width + (actual_cols + 1) * squad_spacing;
  squad_length = num_rows * base_width + (num_rows + 1) * squad_spacing;

  difference() {
    cube([squad_width, squad_length, base_depth+1]);

    translate([1, 1, -1.5])
    cube([squad_width-2, squad_length-2, base_depth+1]);
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