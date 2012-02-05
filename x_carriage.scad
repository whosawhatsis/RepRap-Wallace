//x carriage

include <configuration.scad>



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

x_carriage();