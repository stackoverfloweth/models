difference() {
    union() {
        import("/Users/evansutherland/Downloads/Losi Micro-B Wing V2.stl");
        
        translate([11.5, 0.5, -5])
            cube([6.5, 22, 0.75]);
        
        translate([42, 0.5, -5])
            cube([6.5, 22, 0.75]);
    }
    
    rotate([90, 90, 90])
    translate([-1.1, 12, 36])
    scale(2)
    import("/Users/evansutherland/Downloads/Dickbutt - 675373/files/dickbutt__1_.stl");
}