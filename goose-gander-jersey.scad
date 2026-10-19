$fn = 180;
// Goose & Gander Jersey-Style T-Shirt Transfer
// Print each layer separately in TPU for multi-color transfer:
//   Layer 1 (gold outline): show_outline=true, show_fill=false
//   Layer 2 (navy fill):    show_outline=false, show_fill=true

/* [Print Selection] */
show_outline = true;
show_fill = true;

/* [Dimensions] */
height = 0.8;          // Extrusion height (mm)
outline_width = 2;     // Border thickness (mm)
outline_gap = 1;       // Gap between fill and outline (mm)

/* [Font] */
// Rockwell Bold gives a good slab-serif jersey look
// For an even more authentic look, install "Varsity Regular" or "Jersey M54"
font_name = "Rockwell:style=Bold";

/* [Layout] */
arch_radius = 120;
name_size = 22;
number_size = 60;
name_spacing = 2;
number_spacing = 1;
gap = 70;              // Space between left/right halves

// --- Modules ---

module arched_text(str, size, radius, spacing = 1) {
    chars = len(str);
    char_angle = (size + spacing) / (PI * radius / 180);
    start_angle = (chars - 1) * char_angle / 2;

    for (i = [0 : chars - 1]) {
        angle = start_angle - i * char_angle;
        rotate([0, 0, angle])
            translate([0, radius, 0])
                text(str[i], size = size, font = font_name,
                     halign = "center", valign = "center");
    }
}

module straight_text(str, size) {
    text(str, size = size, font = font_name,
         halign = "center", valign = "center",
         spacing = 1 + number_spacing / 10);
}

// Outline ring: expand outward with a gap between fill and border
module outline_of(width, gap) {
    difference() {
        offset(r = gap + width) children();
        offset(r = gap) children();
    }
}

module jersey_half(name, number) {
    // Arched name
    translate([0, number_size * 0.8, 0]) {
        if (show_outline)
            color("gold")
                linear_extrude(height)
                    outline_of(outline_width, outline_gap)
                        arched_text(name, name_size, arch_radius, name_spacing);
        if (show_fill)
            color("midnightblue")
                linear_extrude(height)
                    arched_text(name, name_size, arch_radius, name_spacing);
    }

    // Number below
    translate([0, -number_size * 0.3, 0]) {
        if (show_outline)
            color("gold")
                linear_extrude(height)
                    outline_of(outline_width, outline_gap)
                        straight_text(number, number_size);
        if (show_fill)
            color("midnightblue")
                linear_extrude(height)
                    straight_text(number, number_size);
    }
}

// --- Render ---

translate([-100, 0, 0])
mirror([1, 0, 0])
    jersey_half("GOOSE", "19");

translate([100, 0, 0])
mirror([1, 0, 0])
    jersey_half("GANDER", "99");
