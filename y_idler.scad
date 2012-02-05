// y idler

include <configuration.scad>

module y_idler() difference() {
	linear_extrude(height = 10, convexity = 5) difference() {
		union() {
			square([rod_size * 2, motor_casing + rod_size * 2], center = true);
			for(side = [1, -1]) translate([0, side * (motor_casing / 2 + rod_size), rod_size / 2 + bearing_size / 2]) rotate(180 / 8) circle(rod_size * 13/12, h = yz_motor_distance + motor_casing + 20, center = true, $fn = 8);
		}
		for(side = [1, -1]) translate([0, side * (motor_casing / 2 + rod_size), rod_size / 2 + bearing_size / 2]) rotate(180 / 8) circle(rod_size * 13/24, h = yz_motor_distance + motor_casing + 20, center = true, $fn = 8);

	}
	rotate([90, 0, 90]) {
		for(side = [1, -1]) translate([side * (motor_casing / 2 - rod_size / 2), 5, -3]) {
			cylinder(r = 3 * 7/12, h = rod_size * 2, center = true, $fn = 6);
			translate([0, 0, rod_size]) cylinder(r = 3 * 7/6, h = 4, $fn = 6);
		}
		%translate([0, 5, -rod_size - idler_pulley_width / 2]) linear_extrude(height = 5, center = true, convexity = 5) for(side = [1, 0]) mirror([side, 0, 0]) {
			translate([-(motor_casing / 2 - rod_size / 2), 0, 0]) {
				intersection() {
					difference() {
						circle(pulley_size / 2 + 2);
						circle(pulley_size / 2);
					}
					square(pulley_size);
				}
				rotate(90) difference() {
					translate([2, 0, 0]) square([pulley_size / 2, 40]);
					square([pulley_size / 2, 40]);
				}
				rotate(-90) difference() {
					translate([0, 2, 0]) square([60 - yz_motor_distance / 2 - motor_screw_spacing / 2, pulley_size / 2]);
					square([60, pulley_size / 2]);
				}
			}
			translate([0, -(60 - yz_motor_distance / 2 - motor_screw_spacing / 2), 0]) difference() {
				circle(motor_casing / 2 - rod_size / 2 - pulley_size / 2);
				circle(motor_casing / 2 - rod_size / 2 - pulley_size / 2 - 2);
				translate([-(motor_casing / 2 - rod_size / 2 - pulley_size / 2), 0, 0]) square(motor_casing - rod_size - pulley_size);
			}
		}
	}
}

y_idler();