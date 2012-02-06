include <wallace.scad>;

!for(b = [0:1]) mirror([0, b, 0]) for(a = [-1,1]) translate([a * bearing_size / 4, bearing_size - (bearing_size * 2/3) * a, 0]) rotate(90 + 90 * a) y_bearing_retainer();