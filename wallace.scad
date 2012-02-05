// all modules for wallace

// rename configuration.scad_m6 or configuration.scad_m8 to configuration.scad
include <configuration.scad>

// include modules
use <base_end.scad>
use <bed_mount.scad>
use <foot.scad>
use <idler_pulley.scad>
use <leadscrew_coupler.scad>
use <x_carriage.scad>
use <x_end.scad>
use <y_bearing_retainer.scad>
use <y_idler.scad>
use <z_top_clamp.scad>

//Comment out all of the lines in the following section to render the assembled machine. Uncomment one of them to export that part for printing.

//!base_end();
//!for(b = [0:1]) mirror([0, b, 0]) for(a = [-1,1]) translate([a * bearing_size / 4, bearing_size - (bearing_size * 2/3) * a, 0]) rotate(90 + 90 * a) y_bearing_retainer();
//!for(b = [0:1]) mirror([0, b, 0]) for(a = [-1,1]) translate([a * -7.5, 18 - 5 * a, 0]) rotate(180 + 90 * a) bed_mount();
//!x_end(2);
//!x_end(0);
//!x_carriage();
//!for(side = [-1,1]) translate([0, side * motor_screw_spacing / 2, 0]) leadscrew_coupler();
//!y_idler();
//!for(x = [1, -1]) for(y = [1, -1]) translate([x * (pulley_size / 2 + 3), y * (pulley_size / 2 + 3), 0]) idler_pulley(true);
//!for(x = [1, -1]) for(y = [1, -1]) translate([x * (rod_size * 1.5 + 2), y * (rod_size * 1.5 + 2), 0]) foot();
//!for(side = [0, 1]) mirror([side, 0, 0]) translate([-rod_size * 2.5, 0, 0]) z_top_clamp();


//The following section positions parts for rendering the assembled machine.

	translate([0, 0, -bearing_size]) rotate([0, 180, 0]) base_end();
	for(end = [1, -1]) translate([0, end * motor_screw_spacing / 2 + 5, -bearing_size + bearing_size * sqrt(2) / 4]) rotate([-90, 0, 180]) y_bearing_retainer();
	for(side = [0, 1]) mirror([0, side, 0]) translate([yz_motor_distance / 2 - bearing_size / 2, -motor_casing / 2 - rod_size * 2 - 10, -bearing_size + bearing_size * sqrt(2) / 4]) rotate([90, 0, 0]) bed_mount();
	translate([-yz_motor_distance / 2 + rod_size - motor_casing / 4 - rod_size / 2, 0, 60 + (x_rod_spacing + 8 + rod_size) / 2]) rotate([0, 180, 0]) x_end(0);
	translate([140, 0, 60 + (x_rod_spacing + 8 + rod_size) / 2]) rotate([0, 180, 0]) {
		x_end(2);
		translate([0, 8 + rod_size, 0]) rotate([90, 0, 0]) translate([0, (x_rod_spacing + 8 + rod_size) / 2, rod_size / 2 - 2 - bearing_size / 2 - 4 - idler_pulley_width - 1.5]) idler_pulley(true);
	}
	translate([40, rod_size + bearing_size / 2 + 1 - rod_size / 2 + 2, 60]) {
		rotate([90, 0, 90]) x_carriage();
		translate([x_carriage_width / 2 + carriage_extruder_offset, -14 - bearing_size / 2 - 4, x_rod_spacing / 2 + bearing_size / 2 + 4]) {
			rotate([90, 0, 180]) translate([10.57, 30.3, -14]) import_stl("gregs/gregs_accessible_wade-wildseyed_mount.stl", convexity = 5);
			%rotate(180 / 8) cylinder(r = 2, h = 150, center = true, $fn = 8);
		}
	}
	translate([-yz_motor_distance / 2 - motor_casing / 2, 0, -bearing_size / 2]) leadscrew_coupler();
	translate([60, 0, -bearing_size - rod_size / 2 - bearing_size / 2]) {
		rotate([0, 90, 0]) y_idler();
		for(side = [1, -1]) translate([5, side * (motor_casing / 2 - rod_size / 2), idler_pulley_width + 1.5 + rod_size]) rotate([180, 0, 0]) idler_pulley(true);
	}
	for(side = [0, 1]) mirror([0, side, 0]) translate([0, -motor_casing / 2 - rod_size * 2 - 10, -bearing_size - end_height + rod_size * 1.5]) rotate([90, 0, 0]) foot();
	translate([-yz_motor_distance / 2 + rod_size, 0, 210 - end_height]) rotate([180, 0, 90]) z_top_clamp(0);

	
