rod_size = 6;
rod_nut_size = 12; //12 for M6, 16 for M8
bearing_size = 12.5; //12 for LM6UU, 15 for LM8UU,LM8SUU
bearing_length = 20; //19 for LM6UU, 17 for LM8SUU, 24 for LM8UU
yz_motor_distance = 25;
motor_screw_spacing = 26; //26 for NEMA14, 31 for NEMA17
motor_casing = 38; //38 for NEMA14, 45 for NEMA17
end_height = 40;
bed_mount_height = 16;
//x_rod_spacing = motor_screw_spacing + 3 + rod_size;
x_rod_spacing = 30;
x_carriage_width = 70;
carriage_extruder_offset = 5;
pulley_size = 20;
idler_pulley_width = 10;
gusset_size = 15;

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
	translate([-yz_motor_distance / 2, rod_size, 200 - end_height]) rotate([-90, 0, -90]) z_top_clamp(0);

	




module z_top_clamp() difference() {
	union() {
		linear_extrude(height = rod_size * 2 + gusset_size, convexity = 5) difference() {
			union() {
				circle(r = rod_size * 7/6, $fn = 6);
				translate([0, -rod_size, 0]) square([rod_size * (1 + 7/12), rod_size * 2]);
				translate([rod_size - rod_size * 7/12, rod_size / 2, rod_size]) square([rod_size * 7/6, rod_size / 2 + gusset_size]);
			}
		}
		translate([rod_size, -rod_size - 1, rod_size]) rotate([-90, 0, 0]) cylinder(r = rod_size / cos(180 / 6), h = rod_size * 2 + gusset_size + 2, $fn = 6);
	}
	translate([rod_size, -rod_size - 2, rod_size]) rotate([-90, 0, 0]) cylinder(r = rod_size * 7/12, h = gusset_size + rod_size * 2 + 4, $fn = 6);
	translate([rod_size, rod_size + gusset_size, rod_size * 2 + gusset_size]) rotate([45, 0, 0]) cube([rod_size * 2, gusset_size * sqrt(2), gusset_size * sqrt(2)], center = true);
	translate([0, 0, -1]) linear_extrude(height = rod_size * 2 + gusset_size + 2, convexity = 5) {
		circle(r = rod_size * 7/12, $fn = 6);
		%translate([0, 0, -10]) cylinder(r = rod_size * 7/12, h = 160, $fn = 6);
		translate([0, -rod_size / 2, 0]) square([gusset_size + rod_size * 2 + 1, rod_size]);
	}
}

module foot() difference() {
	linear_extrude(height = rod_size, convexity = 5) difference() {
		minkowski() {
			square(rod_size + 2, center = true);
			circle(rod_size, $fn = 16);
		}
		circle(rod_size / 2, $fn = 12);
	}
	translate([0, 0, -rod_size / 16]) cylinder(r1 = rod_size * 3/4, r2 = rod_size / 4, h = rod_size / 2, $fn = 12);
	translate([0, 0, rod_size / 2 + rod_size / 16]) cylinder(r2 = rod_size * 3/4, r1 = rod_size / 4, h = rod_size / 2, $fn = 12);
}


module idler_pulley(double_bearing = true) difference() {
	intersection() {
		linear_extrude(height = idler_pulley_width + 1, convexity = 5) difference() {
			circle(pulley_size / 2 + 2);
			circle(5, $fn = 4);
		}
		union() {
			translate([0, 0, idler_pulley_width / 2 + 1]) scale([1, 1, 1.25]) sphere(pulley_size / 2);
			cylinder(r = pulley_size / 2 + 5, h = 1);
		}
	}
	for(h = [-idler_pulley_width + 4, idler_pulley_width * 2 + 1 - 4]) rotate(180 / 8) translate([0, 0, (double_bearing) ? h:0]) cylinder(r = 10 * 13/24, h = idler_pulley_width * 2, center = true, $fn = 8);
}

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

module x_carriage() difference() {
	intersection() {
		linear_extrude(height = x_carriage_width, convexity = 5) difference() {
			union() {
				square([bearing_size + 8, x_rod_spacing], center = true);
				translate([0, -x_rod_spacing / 2 - bearing_size / 2 - 4, 0]) square([bearing_size / 2 + 4 + 15, x_rod_spacing / 2 + bearing_size / 2 + 4 - 2 - pulley_size / 2]);
				translate([0, -pulley_size / 2, 0]) {
					square([bearing_size / 2 + 4 + 15, 8]);
					translate([bearing_size / 2 + 4 + 15, 4, 0]) circle(4);
				}
				rotate(180) translate([0, -x_rod_spacing / 2 - bearing_size / 2 - 4, 0]) square([bearing_size / 2 + 4 + 28, bearing_size / 2 + 4 + 3]);
				for(side = [1, -1]) translate([0, side * x_rod_spacing / 2, 0]) circle(bearing_size / 2 + 4, $fn = 30);
			}
			translate([bearing_size / 2 + 4, 2 - pulley_size / 2, 0]) {
				square([15, 4]);
				translate([0, -3, 0]) square([2, 4]);
				translate([15, 2, 0]) circle(2);
			}
			for(side = [1, -1]) translate([0, side * x_rod_spacing / 2, 0]) {
				circle(bearing_size / 2 -1, $fn = 30);
				rotate(90 * side) square([2, bearing_size / 2 + 40]);
			}
		}
		difference() {
			rotate([0, -90, 0]) linear_extrude(height = bearing_size + 100, convexity = 5, center = true) difference() {
				polygon([
					[
						0,
						(x_rod_spacing / 2 + bearing_size / 2 + 4)
					],[
						0,
						-(x_rod_spacing / 2 + bearing_size / 2 + 4)
					],[
						bearing_length + 4,
						-(x_rod_spacing / 2 + bearing_size / 2 + 4)
					],[
						bearing_length + 4,
						-(x_rod_spacing / 2 - bearing_size / 2 - 4)
					],[
						x_carriage_width,
						(x_rod_spacing / 2 - bearing_size / 2 - 4)
					],[
						x_carriage_width,
						(x_rod_spacing / 2 + bearing_size / 2 + 4)
					]
				]);
			}
			translate([bearing_size / 2 + 4, -50, bearing_length + 4]) cube(100);
		}
	}
	translate([0, x_rod_spacing / 2, 0]) rotate([0, 0, 0]) {
		%translate([0, 0, 20]) rotate(180 / 8) cylinder(r = rod_size * 13/24, h = 200, center = true, $fn = 8);
		for(end = [0, 1]) mirror([0, 0, end]) translate([0, 0, end * -x_carriage_width - 1]) cylinder(r = bearing_size / 2, h = bearing_length, $fn = 30);
	}
	translate([0, -x_rod_spacing / 2, 0]) rotate([0, 0, 0]) {
		translate([0, 0, 4]) cylinder(r = bearing_size / 2, h = x_carriage_width + 1, center = false, $fn = 30);
		%translate([0, 0,20]) rotate(180 / 8) cylinder(r = rod_size * 13/24, h = 200, center = true, $fn = 8);
	}
	translate([bearing_size / 2 + 4 + 10, 5 - pulley_size / 2, bearing_length / 2 + 2]) rotate([90, 0, 0]) {
		cylinder(r = 3 * 7/12, h = x_rod_spacing + bearing_size + 10, center = true, $fn = 6);
		rotate([180, 0, 0]) cylinder(r = 6 * 7/12, h = x_rod_spacing + bearing_size + 10, center = false, $fn = 6);
		translate([0, 0, x_rod_spacing / 2 + bearing_size / 2 + 6 - pulley_size / 2]) cylinder(r = 3 * 7/6, h = x_rod_spacing + bearing_size + 10, center = false, $fn = 6);
	}
	//#for(side = [1, -1]) translate([-bearing_size / 2 - 4 - 14, 0, x_carriage_width / 2 + carriage_extruder_offset + side * 25]) rotate([90, 0, 0]) cylinder(r = 4.1, h = x_rod_spacing - 10, center = true, $fn = 6);
	translate([-bearing_size / 2 - 4 - 14, 0, x_carriage_width / 2 + carriage_extruder_offset]) rotate([90, 0, 0]) linear_extrude(height = bearing_size + x_rod_spacing + 10, center = true, convexity = 5) {
		*translate([-14, 0, 0]) {
			circle(20);
			rotate(45) square(5);
		}
		intersection() {
			translate([18, 0, 0]) rotate(135) square(100);
			translate([-14, 0, 0]) square([56, 100], center = true);
		}
		for(side = [1, -1]) translate([0, side * 25, 0]) circle(4 * 7/12, $fn = 6);
	}
}

module x_end(motor = 0) mirror([(motor == 0) ? 1 : 0, 0, 0]) difference() {
	union() {
		if(motor > 0) translate([-(motor_casing / 2 + rod_size + bearing_size + 8) / 2 - motor_casing, 8 + rod_size, 0]) rotate([90, 0, 0]) {
			linear_extrude(height = 7) difference() {
				square([motor_casing + 3, x_rod_spacing + 8 + rod_size]);
				translate([motor_casing / 2, (x_rod_spacing + 8 + rod_size) / 2, 0]) {
					circle(motor_screw_spacing / 2);
					for(x = [1, -1]) for(y = [1, -1]) translate([x * motor_screw_spacing / 2, y * motor_screw_spacing / 2, 0]) circle(3 * 7/12, $fn = 6);
					translate([-(motor_casing * 1.5 - motor_screw_spacing), (motor > 1) ? (motor_casing /2 - motor_screw_spacing) : 0, 0]) square([motor_casing, x_rod_spacing + 8 + rod_size]);
				}
			}
			%translate([motor_casing / 2, (x_rod_spacing + 8 + rod_size) / 2, rod_size / 2 - 2 - bearing_size / 2 - 2 - idler_pulley_width / 2]) rotate([180, 0, 0]) linear_extrude(height = 5, convexity = 5) difference() {
				union() {
					circle(pulley_size / 2 + 2);
					translate([0, -pulley_size / 2 - 2, 0]) square([200.5, pulley_size + 4]);
					translate([200.5, 0, 0]) circle(pulley_size / 2 + 2);
				}
				circle(pulley_size / 2);
				translate([0, -pulley_size / 2, 0]) square([200.5, pulley_size]);
				translate([200.5, 0, 0]) circle(pulley_size/2);
			}

		}
		linear_extrude(height = x_rod_spacing + 8 + rod_size, convexity = 5) difference() {
			union() {
				for(side = [1, -1]) translate([side * (motor_casing / 4 + rod_size / 2), 0, 0]) circle(bearing_size / 2 + 3, $fn = 30);
				square([motor_casing / 2 + rod_size, bearing_size / 2 + 3], center = true);
				translate([-(motor_casing / 2 + rod_size + bearing_size + 6) / 2, 0, 0]) square([(motor_casing / 2 + rod_size + bearing_size / 2 + 3 + 3) / 2, bearing_size / 2 + 4 + rod_size / 2]);
				translate([-(motor_casing / 2 + rod_size + bearing_size + 6) / 2, 0, 0]) square([motor_casing / 2 + rod_size + bearing_size / 2 + 3 + 3, bearing_size / 2 + 3 + rod_size / 2]);
				translate([-(motor_casing / 2 + rod_size + bearing_size + 6) / 2 + rod_size / 2 + 2, 0, 0]) square([(motor_casing / 2 + rod_size + bearing_size + 6) / 2 + 5 - rod_size / 2 - 2, bearing_size / 2 + 6 + rod_size]);
				translate([-(motor_casing / 2 + rod_size + bearing_size + 6) / 2 + rod_size / 2 + 2, bearing_size / 2 + rod_size / 2 + 4, 0]) circle(rod_size / 2 + 2);
				translate([0, bearing_size / 2 + rod_size + 6, 0]) square(10, center = true);
			}
			square([motor_casing / 2 + rod_size, 3], center = true);
			translate([(motor_casing / 4 + rod_size / 2), 0, 0]) circle(bearing_size / 2 - .5, $fn = 30);
			translate([-(motor_casing / 4 + rod_size / 2), 0, 0]) circle(rod_nut_size * 6/14, $fn = 6);
			translate([4 + rod_size / 2, bearing_size / 2 + rod_size / 2 + 3, 0]) {
				square([motor_casing / 2 + rod_size + bearing_size + 8, rod_size / 2], center = true);
				translate([-(motor_casing / 2 + rod_size + bearing_size + 8) / 2, .5, 0]) circle(rod_size / 4 + .5, $fn = 12);
			}
		}
	}
	translate([0, 0, (x_rod_spacing + rod_size + 8) / 2]) {
		for(end = [0, 1]) mirror([0, 0, end]) translate([motor_casing / 4 + rod_size / 2, 0, -(x_rod_spacing + rod_size + 8) / 2 - 1]) cylinder(r = bearing_size / 2 - .05, h = bearing_length, $fn = 30);
		for(side = [1, -1]) render(convexity = 5) translate([0, bearing_size / 2 + rod_size / 2 + 3, side * x_rod_spacing / 2]) rotate([0, 90, 0]) {
			//cylinder(r = rod_size / 2, h = motor_casing / 2 + rod_size + bearing_size + 10, center = true, $fn = 30);
			difference() {
				translate([0, 0, (motor > -1) ? rod_size / 2 + 2 : 0]) intersection() {
					rotate(45) cube([rod_size + 2, rod_size + 2, motor_casing / 2 + rod_size + bearing_size + 10], center = true);
					cube([rod_size * 2, rod_size + 2, motor_casing / 2 + rod_size + bearing_size + 10], center = true);
				}
				translate([0, rod_size, 0]) cube([rod_size * 2, rod_size * 2, 6], center = true);
				for(end = [1, -1]) translate([0, -rod_size, end * (motor_casing / 4 + rod_size / 2)]) cube([rod_size * 2, rod_size * 2, 6], center = true);
			}
			translate([0, 0, rod_size / 2 + 2]) intersection() {
				rotate(45) cube([rod_size, rod_size, motor_casing / 2 + rod_size + bearing_size + 10], center = true);
				cube([rod_size * 2, rod_size + 1, motor_casing / 2 + rod_size + bearing_size + 10], center = true);
			}
		}
		rotate([90, 0, 0]) {
			cylinder(r = 3 * 7/12, h = 100, center = true, $fn = 6);
			translate([0, 0, bearing_size / 4 + .5]) cylinder(r = 3 * 7/6, h = 100, center = false, $fn = 6);
		}
	}
	translate([-(motor_casing / 4 + rod_size / 2), 0, 5]) rotate(90) cylinder(r = rod_nut_size / 2, h = x_rod_spacing + 8 + rod_size, $fn = 6);
	translate([(motor_casing / 4 + rod_size / 2), 0, 5]) %rotate(180 / 8) cylinder(r = rod_size * 13/24, h = 200, center = true, $fn = 8);
}

module bed_mount() difference() {
	linear_extrude(height = 10, convexity = 5) difference() {
		union() {
			rotate(180 / 8) circle((rod_size + 8) * 13/24, $fn = 8);
			translate([0, -rod_size / 2 - 4, 0]) square([rod_size / 2 + 8, max(rod_size + 8, rod_size / 2 + 4 + bed_mount_height)]);
		}
		rotate(180 / 8) circle(rod_size * 13/24, $fn = 8);
		translate([0, -rod_size / (1 + sqrt(2)) / 2, 0]) square([rod_size + 10, rod_size / (1 + sqrt(2))]);
	}
	translate([rod_size / 2 + 1.5, -rod_size / 2 - 6, 5]) rotate([-90, 0, 0]) {
		cylinder(r = 3 * 7/12, h = max(rod_size + 12, rod_size / 2 + 7 + bed_mount_height, $fn = 6));
		cylinder(r = 3 * 7/6, h = 4, $fn = 6);
	}
}

module y_bearing_retainer() intersection() {
	difference() {
		linear_extrude(height = 10, convexity = 5) difference() {
			union() {
				intersection() {
					translate([-yz_motor_distance / 2 + bearing_size / 2, 0, 0]) circle(bearing_size / 2 + 4);
					translate([-yz_motor_distance / 2 + bearing_size / 2 - bearing_size / 2 - 4, -bearing_size, 0]) square([bearing_size + 8, bearing_size]);
				}
				translate([-yz_motor_distance / 2 + bearing_size / 2 - bearing_size / 2 - 4, 0, 0]) square([bearing_size + 8, bearing_size * sqrt(2) / 4 - 1]);
				translate([0, bearing_size * sqrt(2) / 4 - 3, 0]) square([yz_motor_distance + motor_casing - motor_screw_spacing + 10, 4], center = true);
			}
			translate([-yz_motor_distance / 2 + bearing_size / 2, 0, 0]) circle(bearing_size / 2);
			translate([-yz_motor_distance / 2 + bearing_size / 2 - bearing_size / 2, 0, 0]) square(bearing_size);
		}
		for(side = [1, -1]) translate([side * (yz_motor_distance + motor_casing - motor_screw_spacing) / 2, 0, 5]) rotate(90) rotate([90, 0, 90]) {
			cylinder(r = 3 * 7/12, h = bearing_size, center = true, $fn = 6);
			translate([0, 0, bearing_size * sqrt(2) / 4 - 5]) rotate([180, 0, 0]) cylinder(r = 3, h = bearing_size, $fn = 30);
		}
	}
	translate([0, 0, 5]) rotate(90) rotate([90, 0, 90]) cylinder(r = (yz_motor_distance + motor_casing - motor_screw_spacing + 10) / 2, h = bearing_size + 10, center = true, $fn = 6);
}

module base_end() difference() {
	linear_extrude(height = end_height, convexity = 5) difference() {
		square([yz_motor_distance + motor_casing - motor_screw_spacing + 10, motor_casing + rod_size * 4], center = true);
		for(end = [1, -1]) {
			for(side = [1, -1]) translate([end * (yz_motor_distance + motor_casing - motor_screw_spacing) / 2, side * motor_screw_spacing / 2, 0]) circle(3 * 7/12, $fn = 6);
			translate([end * (yz_motor_distance + motor_casing) / 2, 0, 0]) circle(motor_screw_spacing / 2);
		}
	}
	for(end = [1, -1]) translate([end * (yz_motor_distance + motor_casing) / 2, 0, 3]) linear_extrude(height = end_height, convexity = 5) square(motor_casing, center = true);
	for(side = [1, -1]) translate([0, side * (motor_casing / 2 + rod_size), rod_size / 2 + bearing_size / 2]) rotate([90, 180 / 8, 90]) {
		cylinder(r = rod_size * 13/24, h = yz_motor_distance + motor_casing + 20, center = true, $fn = 8);
		%translate([0, 0, -70]) cylinder(r = rod_size * 13/24, h = 200, center = true, $fn = 8);
	}
	translate([0, 0, end_height]) scale([1, 1, .5]) rotate([90, 0, 90]) cylinder(r = motor_casing / 2, h = yz_motor_distance + 20, center = true);
	translate([yz_motor_distance / 2 - rod_size, 0, 0]) {
		translate([0, 0, -3]) linear_extrude(height = end_height - motor_casing / 4, convexity = 5) {
			rotate(180 / 8) circle(rod_size * 13/24, $fn = 8);
			translate([0, -rod_size / 4, 0]) square([rod_size * .6, rod_size / 2]);
		}
		for(h = [8, end_height - motor_casing / 4 - 8]) translate([0, 0, h]) rotate([90, 0, 90]) {
			cylinder(r = 3 * 7/12, h = yz_motor_distance + motor_casing, center = true, $fn = 6);
			translate([0, 0, -rod_size / 2 - 3]) cylinder(r = 3
* 7/6, h = yz_motor_distance + motor_casing, $fn = 6);
			translate([0, 0, 0]) cylinder(r = 3.5, h = yz_motor_distance + motor_casing, $fn = 6);
			translate([0, 0, -rod_size / 2 - 8]) rotate([0, 180, 0]) cylinder(r = 3.5, h = yz_motor_distance + motor_casing, $fn = 6);
		}
	}
	translate([-yz_motor_distance / 2 + bearing_size / 2, 0, -bearing_size * sqrt(2) / 4]) rotate([90, -45, 0]) {
		%cylinder(r = rod_size * 13/24, h = 100, center = true, $fn = 8);
		for(side = [0, 1]) mirror([0, 0, side]) translate([0, 0, rod_size / 2 + 2]) {
			cylinder(r = bearing_size / 2, h = bearing_length, center = false, $fn = 80);
			cube([bearing_size / 2, bearing_size / 2, bearing_length]);
		}
	}
	translate([0, 0, end_height - rod_size * 1.5]) rotate([90, 180 / 8, 0]) cylinder(r = rod_size * 13/24, h = motor_casing + rod_size * 5, $fn = 8, center = true);
	%translate([0, 0, end_height - rod_size * 1.5]) rotate([90, 180 / 8, 0]) cylinder(r = rod_size * 13/24, h = 100, $fn = 8, center = true);
}