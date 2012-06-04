// 6mm endstop for Wallace Reprap by PlanoRepRap 17May2012
// Derrived from y-endstop-holer http://www.thingiverse.com/thing:15683
// Derrived from http://www.thingiverse.com/thing:13482
// Derrived from Prusa Simplifed Mendel by prusajr http://www.thingiverse.com/thing:4148
// Cleanup and additional parameterization by PlanoRepRap for 6mm rods for the Wallace Z axis.

// the rod that this holder will clamp onto
rod_size = 6.2;
// the thickness of the body
clamp_size = 4;
// height of endstop holder
height=9;
// distance between hole centers on your switch
hole_separation = 10; 
//use hole separation of 0 for the under the bed switch to only print one hole -- mount the switch sideways and secure a long bolt through one of the unused bed holes to trip it.

// extra_distance from clamp body to first hole 
hole_extra_distance = 1;



// placement of the switch holes
switch_hole_1 = 1;  // 1 cuts the clamp radius just a bit with the nut hole (adjust using hole_extra_distance of 0  above
switch_hole_2 = switch_hole_1 + hole_separation;

extra_length_switch = hole_separation + switch_hole_1 + 1 ;

// the width of the wedge in the clamp
wedge_size = rod_size -1;

echo("height is", height);
clamp_height = height + 5;

// m3 nut data
m3_size = 3 / cos(180 / 8) + 0.4;
m3_nut_size = 5.5 / cos(180 / 6) + 0.4;
m3_nut_depth = 2.5;

// screws that match your endstop assume m3 - most switches can have their holes drilled out to that size by hand even if they only have 2.5mm holes to start.
// hole_size = 3 / cos(180 / 8) + 0.4;
hole_size = m3_size;
// nut traps for switch assume m3
hole_nut_size = m3_nut_size;
hole_nut_depth = m3_nut_depth;

difference() {
	union() {
		cylinder(r=rod_size / 2 + clamp_size, h=clamp_height, $fn=(rod_size + clamp_size * 2) * 3.14159 * 2);
		translate([wedge_size / -2 - clamp_size, 0, 0]) cube([wedge_size + clamp_size * 2, rod_size / 2 + m3_nut_size + 1, clamp_height]);
//		%translate([-rod_size / 2, 0, 0]) rotate([0, 0, 180]) cube([clamp_size, hole_separation + height / 2 + hole_size / 2 + rod_size / 2 + clamp_size + hole_extra_distance, height]);
	translate([-rod_size / 2, 0, 0]) rotate([0, 0, 180]) cube([clamp_size, extra_length_switch   + hole_size  + rod_size  + clamp_size + hole_extra_distance, height]);
	}

	// rod hole
	translate([0, 0, -2.5]) cylinder(r=rod_size / 2, h=clamp_height + 5, $fn=rod_size * 3.14159 * 2);

	// clamp wedge
	translate([wedge_size / -2, 0, -1]) cube([wedge_size, clamp_size * 3 + 1, clamp_height + 2]);
	
	// clamp screw hole
	translate([0, rod_size / 2 + m3_nut_size / 2, clamp_height / 2]) rotate([0, 90, 0]) rotate([0, 0, 180 / 8]) cylinder(r = m3_size / 2, h = rod_size + clamp_size * 2 + 2, center=true, $fn=8);
	// clamp nut trap
	translate([wedge_size / -2 - clamp_size + m3_nut_depth, rod_size / 2 + m3_nut_size / 2, clamp_height / 2]) rotate([0, -90, 0]) rotate([0, 0, 180 / 6])  cylinder(r = m3_nut_size / 2, h = rod_size / 2 + clamp_size, $fn=6);

	// switch hole 1
	translate([rod_size / -2 - clamp_size - 1, -switch_hole_1 - rod_size / 2 - clamp_size - hole_size / 2 - hole_extra_distance, height / 2]) rotate([0, 90, 0]) rotate([0, 0, 180 / 8]) cylinder(r=hole_size / 2, h=clamp_size + 2, $fn=8);
	// switch hole 1 nut trap
	translate([rod_size / -2 + 0.01 - hole_nut_depth, -switch_hole_1 - rod_size / 2 - clamp_size - hole_size / 2 - hole_extra_distance, height / 2]) rotate([0, 90, 0]) rotate([0, 0, 180 / 6]) cylinder(r=hole_nut_size / 2, h=hole_nut_depth + 10, $fn=6);

	// switch hole 2
	translate([rod_size / -2 - clamp_size - 1, -switch_hole_2 + rod_size / -2 - clamp_size - hole_size / 2 - hole_extra_distance, height / 2]) rotate([0, 90, 0]) rotate([0, 0, 180 / 8]) cylinder(r=hole_size / 2, h=clamp_size + 2, $fn=8);
	// switch hole 2 nut trap
	translate([rod_size / -2 + 0.01 - hole_nut_depth, -switch_hole_2 + rod_size / -2 - clamp_size - hole_size / 2 - hole_extra_distance, height / 2]) rotate([0, 90, 0]) rotate([0, 0, 180 / 6]) cylinder(r=hole_nut_size / 2, h=hole_nut_depth + 10, $fn=6);
   }


