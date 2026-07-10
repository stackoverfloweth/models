width=22.25;
length=24.65;
height=53.5;
cap_width=29.5;
cap_height=2.5;

union() {
    cube([width, length, height], center=true);

    translate([0, 0, height/2+cap_height/2])
    cube([cap_width, cap_width, cap_height], center=true);
}