leg_length=187;
leg_thickness=14;
leg_height=52;
foot_length=22;
foot_transition=8;
connector_length=49;
connector_thickness=8.7;
connector_depth=2.7;
connector_bridge_thickness=3;
$fn=180;

union() {
  //connector
  translate([-connector_bridge_thickness-connector_depth, leg_thickness/2-connector_thickness/2, 0])
  cube([connector_depth, connector_thickness, connector_length]);

  //connector bridge
  translate([-connector_bridge_thickness, leg_thickness/2-connector_bridge_thickness/2, 0])
  cube([connector_bridge_thickness, connector_bridge_thickness, connector_length]);

  hull() {
    cube([1, leg_thickness, leg_height]);

    translate([40, leg_thickness, 30])
    rotate([90, 0, 0])
    cylinder(d=40, h=leg_thickness);

    translate([leg_length-foot_length, leg_thickness, 0])
    rotate([90, 0, 0])
    cylinder(d=20, h=leg_thickness);

    translate([leg_length, 0, -10])
    cube([1, leg_thickness, 1]);
  }
}