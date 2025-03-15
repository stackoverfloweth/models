insideHose=39;
outsideSander=36;

union(){
    tube(50, insideHose, outsideSander);
}

module tube(height, lower, upper) {
    difference() {
        cylinder(h=height, d1=lower, d2=lower);
        translate([0, 0, -1])
        cylinder(h=height+2, d1=upper, d2=upper);
    }
}