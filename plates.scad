include <wallace.scad>;
include <pulley with collar.scad>;

!translate() {
	%square(200, center = true);

	translate() {
		translate([25, 32, 0]) base_end();
		translate([25, 75, 0]) rotate(0) x_end(0);
		translate([74, 26, 0]) for(x = [1, -1]) for(y = [1, -1]) translate([x * (pulley_size / 2 + 3), y * (pulley_size / 2 + 3), 0]) idler_pulley(true);
		translate([75, 75, 0]) for(x = [1, -1]) for(y = [1, -1]) translate([x * (rod_size * 1.5 + 2), y * (rod_size * 1.5 + 2), 0]) foot();
	}

	translate() {
		translate([-84, 77, 0]) for(i = [1, -1]) translate([0, 11 * i, 0]) pulley();
		translate([-25, 32, 0]) base_end();
		translate([-73, 30, 0]) for(b = [0:1]) mirror([0, b, 0]) for(a = [-1,1]) translate([a * bearing_size / 4, bearing_size - (bearing_size * 2/3) * a, 0]) rotate(90 + 90 * a) y_bearing_retainer();
		translate([-36, 82, 0]) rotate(-90) for(b = [0:1]) mirror([0, b, 0]) for(a = [-1,1]) translate([a * -7.5, 18 - 5 * a, 0]) rotate(180 + 90 * a) bed_mount();
	}

	translate() {
		translate([-77, -13, 0]) rotate(180) x_end(2);
		translate([-27, -40, 0]) rotate(-90) x_carriage();
		translate([-70, -65, 0]) for(side = [-1,1]) translate([0, side * motor_screw_spacing / 2, 0]) leadscrew_coupler();
		translate([-92, -60, 0]) y_idler();
		translate([-33, -90, 0]) for(side = [0, 1]) mirror([side, 0, 0]) translate([-rod_size * 2.5 - 3, 0, 0]) z_top_clamp();
	}
}