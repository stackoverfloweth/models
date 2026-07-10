aInsideDiameter=0;
aOutsideDiameter=26.5;
bInsideDiameter=31.5;
bOutsideDiameter=0;

wallThickness=5;
fitTolerance=0.5;
transitionLength=10;
sideLength=30;
$fn=180;

union() {
    circle_slice(aOutsideDiameter, aInsideDiameter, fitTolerance, sideLength);

    translate([0, 0, sideLength])
    difference() {
        hull() {
            circle_slice(aOutsideDiameter, aInsideDiameter, fitTolerance, 1);

            translate([0, 0, transitionLength])
            circle_slice(bOutsideDiameter, bInsideDiameter, fitTolerance, 1);
        }

        hull() {
            circle_slice(aOutsideDiameter, aInsideDiameter, fitTolerance - wallThickness, 1);

            translate([0, 0, transitionLength])
            circle_slice(bOutsideDiameter, bInsideDiameter, fitTolerance - wallThickness, 1);
        }
    }

    translate([0, 0, sideLength+transitionLength])
    circle_slice(bOutsideDiameter, bInsideDiameter, fitTolerance, sideLength);
}

module circle_slice(outsideDiameter, insideDiameter, fitTolerance, height) {
    linear_extrude(height=height)
    if(outsideDiameter > 0) {
        difference() {
            circle(d=outsideDiameter + fitTolerance);
            circle(d=outsideDiameter + fitTolerance - wallThickness);
        }
    }
    else {
        difference() {
            circle(d=insideDiameter + fitTolerance + wallThickness);
            circle(d=insideDiameter + fitTolerance);
        }
    }
}
