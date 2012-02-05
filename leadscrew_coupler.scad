// leadscrew coupler

include <configuration.scad>


module leadscrew_coupler() difference() {
	linear_extrude(height = 10 + rod_nut_size / 2 + 1, convexity = 5) difference() {
		circle(motor_screw_spacing / 2 - 1);
		circle(5 * 7/12, $fn = 6);
	}
	translate([0, 0, 3]) rotate([-90, 0, 90]) {
		cylinder(r = 3 * 7/12, h = motor_screw_spacing / 2 + 1);
		%rotate(90) cylinder(r = 6 / 2, h = 5.5, $fn = 6);
		translate([0, 0, 12]) cylinder(r = 6 * 7/12, h = motor_screw_spacing / 2);
		translate([-2.85, -3, 0]) cube([5.5, 10, 5.7]);
	}
	translate([0, 0, 10]) cylinder(r = rod_nut_size / 2, h = rod_nut_size + 1, $fn = 6);
	//translate([0, 0, -1]) cube(100);
}

for(side = [-1,1]) translate([0, side * motor_screw_spacing / 2, 0]) leadscrew_coupler();