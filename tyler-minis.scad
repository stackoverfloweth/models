union() {
    translate([35, -80, 10])
    scale([0.1, 0.1, 0.005])
    surface("/Users/evansutherland/Downloads/basket-inverted.png");

    rotate([90, 0, 0])
    import("/Users/evansutherland/Downloads/Disc Golf Mini Marker (1).STL");
}
