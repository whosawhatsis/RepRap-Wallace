include <wallace.scad>;

!for(x = [1, -1]) for(y = [1, -1]) translate([x * (rod_size * 1.5 + 2), y * (rod_size * 1.5 + 2), 0]) foot();