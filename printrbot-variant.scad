//header


//extruder
carriage_extruder_offset = 0;
extruder_hole_spacing = 50; //doesn't work (yet)

//motor vars
motor_screw_spacing = 26; //26 for NEMA14, 31 for NEMA17
motor_casing = 38; //38 for NEMA14, 45 for NEMA17
motor_length = 29; //make this 4 or 5mm longer than actual so the motors aren't supporting the whole printer!
motor_shaft = 5; //diameter of motor shaft, does nothing

//hardware
threaded_rod_size = 6;
smooth_rod_size = 8;
small_screw_size = 3; //m3 
rod_nut_size = 16; //12 for M6, 16 for M8

//bearings
bearing_size = 15; //12 for LM6UU, 15 for LM8UU,LM8SUU
bearing_length = 24; //19 for LM6UU, 17 for LM8SUU, 24 for LM8UU

//pulley vars
pulley_size = 11.5;
idler_pulley_width = 8;
belt_height = 2;

//breakout vars
bed_mount_height = -smooth_rod_size + bearing_size + 4 + 3; //clear the y bearing holder with 3mm(last number) 
y_bearing_thick = smooth_rod_size/2; //this simplifies the math alot
end_height = motor_length + 3; 
x_rod_spacing = smooth_rod_size + pulley_size + belt_height * 2;
yz_motor_distance = smooth_rod_size + bearing_size + small_screw_size;
x_carriage_width = extruder_hole_spacing + small_screw_size * 3;

//Comment out all of the lines in the following section to render the assembled machine. Uncomment one of them to export that part for printing.

//!base_end();
//!for(b = [0:1]) mirror([0, b, 0]) for(a = [-1,1]) translate([a * bearing_size / 4, bearing_size - (bearing_size * 2/3) * a, 0]) rotate(90 + 90 * a)!y_bearing_retainer();
//!for(b = [0:1]) mirror([0, b, 0]) for(a = [-1,1]) translate([a * -7.5, 18 - 5 * a, 0]) rotate(180 + 90 * a) bed_mount();
//!x_end(2);
//!x_end(0);
//!x_carriage();
//!for(side = [-1,1]) translate([0, side * motor_screw_spacing / 2, 0]) leadscrew_coupler();
//!y_idler();
//!for(x = [1, -1]) for(y = [1, -1]) translate([x * (pulley_size / 2 + 3), y * (pulley_size / 2 + 3), 0]) idler_pulley();
//!for(x = [1, -1]) for(y = [1, -1]) translate([x * (pulley_size / 2 + small_screw_size), y * (pulley_size / 2 + small_screw_size), 0]) idler_pulley();
//!for(x = [1, -1]) for(y = [1, -1]) translate([x * (pulley_size / 2 + small_screw_size), y * (pulley_size / 2 + small_screw_size), 0]) idler_pulley_cap();
//!for(x = [1, -1]) for(y = [1, -1]) translate([x * (smooth_rod_size * 2.5 + 1), y * (smooth_rod_size * 2.5 + 1), 0]) foot();



//The following section positions parts for rendering the assembled machine.

	translate([0, 0, -bearing_size]) rotate([0, 180, 0]) base_end();
	for(end = [1, -1]) translate([0, end * motor_screw_spacing / 2 + 5, -bearing_size + bearing_size * sqrt(2) / 4]) rotate([-90, 0, 180]) y_bearing_retainer();
	for(side = [0, 1]) mirror([0, side, 0]) translate([smooth_rod_size / 2, -motor_casing / 2 - smooth_rod_size * 2 - 10, -bearing_size+smooth_rod_size / 2]) rotate([90, 0, 0]) bed_mount();
	translate([-yz_motor_distance / 2 + smooth_rod_size - motor_casing / 4 - smooth_rod_size / 2, 0, 60 + (x_rod_spacing + 8 + smooth_rod_size) / 2]) rotate([0, 180, 0]) x_end(2);
	translate([140, 0, 60 + (x_rod_spacing + 8 + smooth_rod_size) / 2]) rotate([0, 180, 0]) {
		x_end(0);
		translate([0, 8 + smooth_rod_size, 0]) rotate([90, 0, 0]) translate([0, (x_rod_spacing + 8 + smooth_rod_size) / 2, smooth_rod_size / 2 - 2 - bearing_size / 2 - 4 - idler_pulley_width - 1.5]) idler_pulley();
	}
	translate([40, smooth_rod_size + bearing_size / 2 + 1 - smooth_rod_size / 2 + 2, 60]) {
		rotate([90, 0, 90]) x_carriage();
		translate([x_carriage_width / 2 + carriage_extruder_offset, -14 - bearing_size / 2 - 4, x_rod_spacing / 2 + bearing_size / 2 + 4]) {
			rotate([90, 0, 180]) translate([10.57, 30.3, -14]) import_stl("gregs/gregs_accessible_wade-wildseyed_mount.stl", convexity = 5);
			%rotate(180 / 8) cylinder(r = 2, h = 150, center = true, $fn = 8);
		}
	}
	translate([-yz_motor_distance / 2 - motor_casing / 2, 0, -bearing_size / 2]) leadscrew_coupler();
	translate([60, 0, -bearing_size - threaded_rod_size / 2 - bearing_size / 2]) {
		rotate([0, 90, 0]) y_idler();
		for(side = [1, -1]) translate([5, side * (motor_casing / 2 - smooth_rod_size / 2), idler_pulley_width + 1.5 + smooth_rod_size]) rotate([180, 0, 0]) idler_pulley(true);
	}
	for(side = [0, 1]) mirror([0, side, 0]) translate([threaded_rod_size/2, -motor_casing / 2 - smooth_rod_size * 2 - 10, -bearing_size - end_height + threaded_rod_size * 1.5]) rotate([90, 0, 0]) foot();








module foot() difference() {
	linear_extrude(height = threaded_rod_size, convexity = 5) difference() {
		minkowski() {
			square(threaded_rod_size * 3, center = true);
			circle(threaded_rod_size, $fn = 16);
		}
		circle(threaded_rod_size / 2, $fn = 12);
	}
	translate([0, 0, -threaded_rod_size / 16]) cylinder(r1 = threaded_rod_size * 3/4, r2 = threaded_rod_size / 4, h = threaded_rod_size / 2, $fn = 12);
	translate([0, 0, threaded_rod_size / 2 + threaded_rod_size / 16]) cylinder(r2 = threaded_rod_size * 3/4, r1 = threaded_rod_size / 4, h = threaded_rod_size / 2, $fn = 12);
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

module idler_pulley_cap() difference() {
	cylinder(r = pulley_size / 2 + belt_height, h = 1);
	translate([0,0,-1])cylinder(r = small_screw_size * 13/24, h = 3,$fn = 8);
}


module y_idler() difference() {
	linear_extrude(height = 10, convexity = 5) difference() {
		union() {
			square([threaded_rod_size * 2, motor_casing + threaded_rod_size * 2], center = true);
			for(side = [1, -1]) translate([0, side * (motor_casing / 2 + threaded_rod_size), threaded_rod_size / 2 + bearing_size / 2]) rotate(180 / 8) circle(threaded_rod_size * 13/12, h = yz_motor_distance + motor_casing + 20, center = true, $fn = 8);
		}
		for(side = [1, -1]) translate([0, side * (motor_casing / 2 + threaded_rod_size), threaded_rod_size / 2 + bearing_size / 2]) rotate(180 / 8) circle(threaded_rod_size * 13/24, h = yz_motor_distance + motor_casing + 20, center = true, $fn = 8);

	}
	for(side = [1, -1]) translate([-3, side * (motor_casing / 2 - threaded_rod_size / 2), 5]) rotate([90, 0, 90]) {
		cylinder(r = small_screw_size * 7/12, h = threaded_rod_size * 2, center = true, $fn = 6);
		translate([0, 0, threaded_rod_size]) cylinder(r = small_screw_size * 7/6, h = 4, $fn = 6);
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
				#translate([0, -x_rod_spacing / 2 - bearing_size / 2 - 4, 0]) square([bearing_size / 2 + 4 + 15, x_rod_spacing / 2 + bearing_size / 2 + 4 - 2 - pulley_size / 2]);
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
		%translate([0, 0, 20]) rotate(180 / 8) cylinder(r = smooth_rod_size * 13/24, h = 200, center = true, $fn = 8);
		for(end = [0, 1]) mirror([0, 0, end]) translate([0, 0, end * -x_carriage_width - 1]) cylinder(r = bearing_size / 2, h = bearing_length, $fn = 30);
	}
	translate([0, -x_rod_spacing / 2, 0]) rotate([0, 0, 0]) {
		translate([0, 0, 4]) cylinder(r = bearing_size / 2, h = x_carriage_width + 1, center = false, $fn = 30);
		%translate([0, 0,20]) rotate(180 / 8) cylinder(r = smooth_rod_size * 13/24, h = 200, center = true, $fn = 8);
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

module x_end(motor = 0) mirror([motor, 0, 0]) difference() {
	union() {
		if(motor > 0) translate([-(motor_casing / 2 + smooth_rod_size + bearing_size + 8) / 2 - motor_casing, 8 + smooth_rod_size, 0]) rotate([90, 0, 0]) {
			linear_extrude(height = 7) difference() {
				square([motor_casing + 3, x_rod_spacing + 8 + smooth_rod_size]);
				translate([motor_casing / 2, (x_rod_spacing + 8 + smooth_rod_size) / 2, 0]) {
					circle(motor_screw_spacing / 2);
					for(x = [1, -1]) for(y = [1, -1]) translate([x * motor_screw_spacing / 2, y * motor_screw_spacing / 2, 0]) circle(3 * 7/12, $fn = 6);
					translate([-(motor_casing * 1.5 - motor_screw_spacing), (motor > 1) ? (motor_casing /2 - motor_screw_spacing) : 0, 0]) square([motor_casing, x_rod_spacing + 8 + smooth_rod_size]);
				}
			}
			%translate([motor_casing / 2, (x_rod_spacing + 8 + smooth_rod_size) / 2, smooth_rod_size / 2 - 2 - bearing_size / 2 - 2 - idler_pulley_width / 2]) rotate([180, 0, 0]) linear_extrude(height = 5, convexity = 5) difference() {
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
		linear_extrude(height = x_rod_spacing + 8 + smooth_rod_size, convexity = 5) difference() {
			union() {
				for(side = [1, -1]) translate([side * (motor_casing / 4 + smooth_rod_size / 2), 0, 0]) circle(bearing_size / 2 + 3, $fn = 30);
				square([motor_casing / 2 + smooth_rod_size, bearing_size / 2 + 3], center = true);
				translate([-(motor_casing / 2 + smooth_rod_size + bearing_size + 6) / 2, 0, 0]) square([(motor_casing / 2 + smooth_rod_size + bearing_size / 2 + 3 + 3) / 2, bearing_size / 2 + 4 + smooth_rod_size / 2]);
				translate([-(motor_casing / 2 + smooth_rod_size + bearing_size + 6) / 2, 0, 0]) square([motor_casing / 2 + smooth_rod_size + bearing_size / 2 + 3 + 3, bearing_size / 2 + 3 + smooth_rod_size / 2]);
				translate([-(motor_casing / 2 + smooth_rod_size + bearing_size + 6) / 2 + smooth_rod_size / 2 + 2, 0, 0]) square([(motor_casing / 2 + smooth_rod_size + bearing_size + 6) / 2 + 5 - smooth_rod_size / 2 - 2, bearing_size / 2 + 6 + smooth_rod_size]);
				translate([-(motor_casing / 2 + smooth_rod_size + bearing_size + 6) / 2 + smooth_rod_size / 2 + 2, bearing_size / 2 + smooth_rod_size / 2 + 4, 0]) circle(smooth_rod_size / 2 + 2);
				translate([0, bearing_size / 2 + smooth_rod_size + 6, 0]) square(10, center = true);
			}
			square([motor_casing / 2 + smooth_rod_size, 3], center = true);
			translate([(motor_casing / 4 + smooth_rod_size / 2), 0, 0]) circle(bearing_size / 2 - .5, $fn = 30);
			translate([-(motor_casing / 4 + smooth_rod_size / 2), 0, 0]) circle(rod_nut_size / 2 - 2, $fn = 6);
			translate([4 + smooth_rod_size / 2, bearing_size / 2 + smooth_rod_size / 2 + 3, 0]) {
				square([motor_casing / 2 + smooth_rod_size + bearing_size + 8, smooth_rod_size / 2], center = true);
				translate([-(motor_casing / 2 + smooth_rod_size + bearing_size + 8) / 2, .5, 0]) circle(smooth_rod_size / 4 + .5, $fn = 12);
			}
		}
	}
	translate([0, 0, (x_rod_spacing + smooth_rod_size + 8) / 2]) {
		for(end = [0, 1]) mirror([0, 0, end]) translate([motor_casing / 4 + smooth_rod_size / 2, 0, -(x_rod_spacing + smooth_rod_size + 8) / 2 - 1]) cylinder(r = bearing_size / 2 - .05, h = bearing_length, $fn = 30);
		for(side = [1, -1]) render(convexity = 5) translate([0, bearing_size / 2 + smooth_rod_size / 2 + 3, side * x_rod_spacing / 2]) rotate([0, 90, 0]) {
			//cylinder(r = smooth_rod_size / 2, h = motor_casing / 2 + smooth_rod_size + bearing_size + 10, center = true, $fn = 30);
			difference() {
				translate([0, 0, (motor > -1) ? smooth_rod_size / 2 + 2 : 0]) intersection() {
					rotate(45) cube([smooth_rod_size + 2, smooth_rod_size + 2, motor_casing / 2 + smooth_rod_size + bearing_size + 10], center = true);
					cube([smooth_rod_size * 2, smooth_rod_size + 2, motor_casing / 2 + smooth_rod_size + bearing_size + 10], center = true);
				}
				translate([0, smooth_rod_size, 0]) cube([smooth_rod_size * 2, smooth_rod_size * 2, 6], center = true);
				for(end = [1, -1]) translate([0, -smooth_rod_size, end * (motor_casing / 4 + smooth_rod_size / 2)]) cube([smooth_rod_size * 2, smooth_rod_size * 2, 6], center = true);
			}
			translate([0, 0, smooth_rod_size / 2 + 2]) intersection() {
				rotate(45) cube([smooth_rod_size, smooth_rod_size, motor_casing / 2 + smooth_rod_size + bearing_size + 10], center = true);
				cube([smooth_rod_size * 2, smooth_rod_size + 1, motor_casing / 2 + smooth_rod_size + bearing_size + 10], center = true);
			}
		}
		rotate([90, 0, 0]) cylinder(r = 3 * 7/12, h = 100, center = true, $fn = 6);
	}
	translate([-(motor_casing / 4 + smooth_rod_size / 2), 0, 5]) cylinder(r = rod_nut_size / 2, h = x_rod_spacing + 8 + smooth_rod_size, $fn = 6);
	translate([(motor_casing / 4 + smooth_rod_size / 2), 0, 5]) %rotate(180 / 8) cylinder(r = smooth_rod_size * 13/24, h = 200, center = true, $fn = 8);
}

module bed_mount() difference() {
	linear_extrude(height = 10, convexity = 5) difference() {
		union() {
			rotate(180 / 8) circle((smooth_rod_size + 8) * 13/24, $fn = 8);
			translate([0, -smooth_rod_size / 2 - 4, 0]) square([smooth_rod_size / 2 + 8, max(smooth_rod_size + 8, smooth_rod_size / 2 + 4 + bed_mount_height)]);
		}
		rotate(180 / 8) circle(smooth_rod_size * 13/24, $fn = 8);
		translate([0, -smooth_rod_size / (1 + sqrt(2)) / 2, 0]) square([smooth_rod_size + 10, smooth_rod_size / (1 + sqrt(2))]);
	}
	translate([smooth_rod_size / 2 + 1.5, -smooth_rod_size / 2 - 6, 5]) rotate([-90, 0, 0]) {
		cylinder(r = 3 * 7/12, h = max(smooth_rod_size + 12, smooth_rod_size / 2 + 7 + bed_mount_height, $fn = 6));
		cylinder(r = 3 * 7/6, h = 4, $fn = 6);
	}
}

module y_bearing_retainer() intersection() {
	difference() {
		linear_extrude(height = small_screw_size*3, convexity = 5) difference() {
			union() {
				intersection() {
					translate([-smooth_rod_size / 2, 0, 0]) circle(bearing_size / 2 + y_bearing_thick);
					translate([-smooth_rod_size / 2 - bearing_size / 2 - y_bearing_thick, -bearing_size, 0]) square([bearing_size + 8, bearing_size]);
				}
				translate([-smooth_rod_size/2-bearing_size/2-y_bearing_thick, 0, 0]) square([y_bearing_thick * 2 + bearing_size, bearing_size * sqrt(2) / 4 - 1]);
				translate([0, bearing_size * sqrt(2) / 4 - 3, 0]) square([yz_motor_distance + motor_casing - motor_screw_spacing + 10, 4], center = true);
			}
			translate([-smooth_rod_size / 2, 0, 0]) circle(bearing_size / 2);
			translate([-smooth_rod_size / 2 - bearing_size / 2, 0, 0]) square(bearing_size);
		}
		for(side = [1, -1]) translate([side * (yz_motor_distance + motor_casing - motor_screw_spacing) / 2, 0, small_screw_size * 1.5]) rotate(90) rotate([90, 0, 90]) {
			cylinder(r = small_screw_size * 7/12, h = bearing_size, center = true, $fn = 6);
			translate([0, 0, bearing_size * sqrt(2) / 4 - 5]) rotate([180, 0, 0]) cylinder(r = 3, h = bearing_size, $fn = 30);
		}
	}
	translate([0, 0, 5]) rotate(90) rotate([90, 0, 90]) cylinder(r = (yz_motor_distance + motor_casing - motor_screw_spacing + 10) / 2, h = bearing_size + 10, center = true, $fn = 6);
}


module base_end() difference() {
	linear_extrude(height = end_height, convexity = 5) difference() {
		square([yz_motor_distance + motor_casing - motor_screw_spacing + 10, motor_casing + threaded_rod_size * 4], center = true);
		for(end = [1, -1]) {
			for(side = [1, -1]) translate([end * (yz_motor_distance + motor_casing - motor_screw_spacing) / 2, side * motor_screw_spacing / 2, 0]) circle(3 * 7/12, $fn = 6);
			translate([end * (yz_motor_distance + motor_casing) / 2, 0, 0]) circle(motor_screw_spacing / 2);
		}
	}
	for(end = [1, -1]) translate([end * (yz_motor_distance + motor_casing) / 2, 0, 3]) linear_extrude(height = end_height, convexity = 5) square(motor_casing, center = true);
	for(side = [1, -1]) translate([0, side * (motor_casing / 2 + threaded_rod_size), threaded_rod_size / 2 + bearing_size / 2]) rotate([90, 180 / 8, 90]) {
		cylinder(r = threaded_rod_size * 13/24, h = yz_motor_distance + motor_casing + 20, center = true, $fn = 8);
		%translate([0, 0, -70]) cylinder(r = threaded_rod_size * 13/24, h = 200, center = true, $fn = 8);
	}
	translate([0, 0, end_height]) scale([1, 1, .5]) rotate([90, 0, 90]) cylinder(r = motor_casing / 2, h = yz_motor_distance + 20, center = true);
	translate([smooth_rod_size/2+1, 0, 0]) { //allow 1mm gap between Y and z rods
		translate([0, 0, -1]) linear_extrude(height = end_height, convexity = 5) {
			rotate(180 / 8) circle(smooth_rod_size * 13/24, $fn = 8);
			//translate([0, -smooth_rod_size / 4, 0]) square([smooth_rod_size * .6, smooth_rod_size / 2]);
		}
		for(h = [8, end_height - motor_casing / 4 - 8]) translate([0, 0, h]) rotate([90, 0, 90]) {
			cylinder(r = 3 * 7/12, h = yz_motor_distance + motor_casing, center = true, $fn = 6);
			translate([0, 0, -smooth_rod_size / 2 - 3]) cylinder(r = 3
* 7/6, h = yz_motor_distance + motor_casing, $fn = 6);
			translate([0, 0, 0]) cylinder(r = 3.5, h = yz_motor_distance + motor_casing, $fn = 6);
			translate([0, 0, -smooth_rod_size / 2 - 8]) rotate([0, 180, 0]) cylinder(r = 3.5, h = yz_motor_distance + motor_casing, $fn = 6);
		}
	}
	translate([-smooth_rod_size / 2, 0, -bearing_size/2 + smooth_rod_size/2]) rotate([90, 22.5, 0]) {
		%cylinder(r = smooth_rod_size * 13/24, h = 100, center = true, $fn = 8);
		for(side = [0, 1]) mirror([0, 0, side]) translate([0, 0, smooth_rod_size / 2]) {
			cylinder(r = bearing_size / 2, h = bearing_length, center = false, $fn = 8);
			//cylinder(r = bearing_size * 13/24, h = bearing_length, center = true, $fn = 8);
			//cube([bearing_size / 2, bearing_size / 2, bearing_length]);
		}
	}
	translate([-threaded_rod_size/2, 0, end_height - threaded_rod_size * 1.5]) rotate([90, 180 / 8, 0]) cylinder(r = threaded_rod_size * 13/24, h = motor_casing + smooth_rod_size * 5, $fn = 8, center = true);
	%translate([-threaded_rod_size/2, 0, end_height - threaded_rod_size * 1.5]) rotate([90, 180 / 8, 0]) cylinder(r = threaded_rod_size * 13/24, h = 100, $fn = 8, center = true);
}
