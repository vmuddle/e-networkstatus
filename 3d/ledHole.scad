//led measure
$fn=360;
largeLedDiameter_A=5.1;
largeLedDiameter_B=5.3;
largeLedDiameter_C=5.5;


difference() {
    translate([0,0,1])
    cube([30,50,2], true);
    translate([10,-20,0]) {
        cylinder(h=2, d=largeLedDiameter_A);
    }
    translate([10,0,0]) {
        cylinder(h=2, d=largeLedDiameter_B);
    }
    translate([10,20,0]) {
        cylinder(h=2, d=largeLedDiameter_C);
    }
}
linear_extrude(2.5) {
    translate([0,-22,0]) {
        rotate([0,0,90]) {
            text("A", size=8);
        }
    }
    translate([0,-3,0]) {
        rotate([0,0,90]) {
            text("B", size=8);
        }
    }
    translate([0,15,0]) {
        rotate([0,0,90]) {
            text("C", size=8);
        }
    }
}

