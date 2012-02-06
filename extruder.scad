filament_d = 1.75;
spring_d = 8;
countersink = true;
hole_cuts = true;
idler_width = 10.6;
drive_gear_size = 10.56;

difference() {
	minkowski() {
		square(31, center = true);
		circle(5);
	}
	circle(11);
	for(a = [0:3]) rotate(45 + 90 * a) translate([31 / sqrt(2), 0, 0]) {
		circle(3 * 7/12, $fn = 6);
		if (hole_cuts) square([20,.1]);
	}
	for(a = [0:3]) rotate(-15 + 90 * a) translate([-20 / sqrt(2), 0, 0]) {
		circle(3 * 7/12, $fn = 6);
		if (hole_cuts) square([20,.1]);
	}
}

difference() {
	linear_extrude(height = idler_width, convexity = 5) difference() {
		minkowski() {
			translate([15.5, 15.5, 0]) rotate(170) translate([25, 5, 0]) square([20, .01]);
			circle(5);
		}
		circle(11);
		for(a = [0:3]) rotate(45 + 90 * a) translate([31 / sqrt(2), 0, 0]) {
			circle(3 * 7/12, $fn = 6);
			rotate(120) if (hole_cuts) square([10,.1]);
		}
		for(a = [0:3]) rotate(90 * a) translate([-20 / sqrt(2), 0, 0]) {
			circle(3 * 7/6, $fn = 6);
			if (hole_cuts) square([20,.1]);
		}
	}
	//#translate([15.5, 15.5, idler_width / 2]) rotate([-90, 0, -10]) translate([-31, 0, -2]) cylinder(r = spring_d * 7/12, h = 10, $fn = 6);
	translate([15.5, 15.5, 0]) intersection() {
		translate([0, 0, idler_width / 2]) rotate_extrude(convexity = 5) translate([31, 0, 0]) circle(spring_d * 7/12, $fn = 6);
		translate([0, 0, 0]) rotate(170) translate([0, -38, 0]) cube(40);
	}	
}

translate([15.5, 15.5, 0]) rotate(-9) idler();
module idler() difference() {
	linear_extrude(height = idler_width, convexity = 5) difference() {
		union() {
			circle(5);
			translate([0, -18.5, 0]) circle(5);
			rotate(180) translate([-5, 0, 0]) square([10, 18.5]);
			*rotate(60) translate([0, 0, 0]) square([5, 35]);
			rotate(60) translate([2.5, 0, 0]) minkowski() {
				union() {
					square([.01, 40]);
					translate([0, 40, 0]) rotate(-30) square([.01, 7]);
				}
				circle(2.5);
			}
			*#rotate(60) translate([2.5, 35, 0]) {
				circle(2.5);
				rotate(-30) {
					translate([-2.5, 0, 0]) square([5, 7]);
					translate([0, 7, 0]) circle(2.5);
				}
			}
			rotate(30) translate([-5, 0, 0]) square([5, 10]);
		}
		circle(3 * 7/12, $fn = 6);
		rotate(9) translate([-15.5 + drive_gear_size / 2 + 5 + filament_d, -15.5, 0]) circle(3 * 7/12, $fn = 6);
	}
	translate([0, 0, idler_width / 2]) {
		rotate(9) translate([-15.5 + drive_gear_size / 2 + 5 + filament_d, -15.5, 0]) linear_extrude(height = 5, convexity = 5, center = true) difference() {
			circle(6);
			circle(2.3, $fn = 6);
		}
		translate([drive_gear_size / 2 + 1.5, 0, 0]) rotate([-90, 0, 9]) translate([-15.5, 0, -15.5]) cylinder(r = 2, h = 50, $fn = 6);
		translate([drive_gear_size / 2 + 1.5, 0, 0]) rotate([-90, 0, 0]) translate([-15.5, 0, -15.5]) rotate([0, 0, 0]) cylinder(r = 2, h = 100, center = true, $fn = 6);
	}
	if (countersink) translate([0, 0, idler_width - 4]) cylinder(r1 = 0, r2 = 8, h = 8, $fn = 6);
	//translate([0, 0, idler_width / 2]) rotate([90, 0, -30]) translate([-31, 0, -2]) cylinder(r = spring_d * 7/12, h = 10, $fn = 6);
	intersection() {
		translate([0, 0, idler_width / 2]) rotate_extrude(convexity = 5) translate([31, 0, 0]) circle(spring_d * 7/12, $fn = 6);
		translate([0, 0, 0]) rotate(-120) translate([-2, -40, 0]) cube(40);
	}	
}