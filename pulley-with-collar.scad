shaft_diameter = 5.35;
collar_diameter = 21;
collar_thick = 5.6;
screws = 1;
fn = max(6, screws * 3);
//$fn = fn;




min_diameter = 20;
tooth_width = .87;//2.3;//1.75 * 1.5;
tooth_height = 1.2;//.5;
tooth_pitch = 2.2;//5;
teeth = ceil(min_diameter * 3.14159 / tooth_pitch);
diameter = teeth * tooth_pitch / 3.4159;
echo("teeth:", teeth);
echo("thread width (1 shell):", tooth_width / 2);
echo("thread width (2 shells):", tooth_width / 4);
echo("thread width (3 shells):", tooth_width / 6);




%cylinder(r = shaft_diameter / 2, h = 100, center = true, $fn = 180); 


for(x = [-.5, .5]) for(y = [-.5, .5]) translate([21.5 * x, 21.5 * 0, 0]) {
	difference() {
		linear_extrude(height = collar_thick, convexity = 3) difference() {
			union() {
				//rotate(180) translate([-15, -15, 0]) square([30, 55]);
				circle(collar_diameter / 2);
				for(a = [0:screws - 1]) rotate([0, 0, -90 + a * 360 / screws]) translate([-4.5, 0, 0]) square([9, shaft_diameter / 2 + 6]);
			}
			//#circle(3.5, $fn = 6);
			#circle(shaft_diameter / 2 / sin(360 / fn), $fn = fn);
		}
		translate([0, 0, collar_thick / 2]) for(a = [0:screws - 1]) rotate([90, 0, 90 + a * 360 / screws]) {
		#	cylinder(r = 3.35, h = shaft_diameter / 2 + 3, $fn = 6);
			translate([0, 0, 10 + shaft_diameter / 2]) cylinder(r = 3.25, h = collar_diameter + 1, $fn = 6);
			cylinder(r = 1.75, h = collar_diameter + 1, $fn = 6);
		}
	}
	
	translate([0, 0, collar_thick]) linear_extrude(height = 7, convexity = 3) difference() {
		union() {
			circle(diameter / 2 - tooth_height);
			for(a = [1:teeth]) rotate(a * 360 / teeth) intersection() {
				translate([-tooth_width / 2, 0, 0]) square([tooth_width, diameter]);
				circle(diameter / 2);
			}
		}
		#rotate(90) circle(shaft_diameter / 2 / sin(360 / fn), $fn = fn);
	}
	
	rotate(360 / fn / 2) translate([0, 0, collar_thick + 6]) {
		intersection() {
			cylinder(r1 = diameter / 2, r2 = (collar_diameter * 2 - diameter) / 2, h = collar_diameter - diameter);
			linear_extrude(height = 6, convexity = 3) difference() {
				circle(r = collar_diameter / 2);
				circle(shaft_diameter / 2 / sin(360 / fn), $fn = fn);
			}
		}
		linear_extrude(height = collar_diameter - diameter + 1, convexity = 3) difference() {
			circle((shaft_diameter + tooth_width * 4) / 2 / sin(360 / fn), $fn = fn);
			circle(shaft_diameter / 2 / sin(360 / fn), $fn = fn);
		}
	}
}