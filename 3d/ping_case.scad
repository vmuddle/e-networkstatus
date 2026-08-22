// Case for raspi w - with ping to website ability
$fn=360;
labels_only=0;
wall_thickness=1.6;
case_width=100;
case_length=100;
case_depth=20;
pcb_width=22;
pcb_length=53;
pcb_depth=10;
pcb_hole_diameter=2;
lug_diameter=3;
lug_height=2;
lug_width=11;
lug_length=47;

//text_font="Arial:style=Regular";

text_font="Arial:style=Bold";


// 3mm led
//led_diameter=3.5;
// 5mm led
led_diameter=5.3;
led_clearance=10;
edge_clearance=10;

usb_width=12;
usb_height=6;

module usb_port() {
    cube([usb_width, usb_height*4, usb_height], true);
}

module mounting_lug() {
    cylinder(h=lug_height*2, d=pcb_hole_diameter-.1);
    cylinder(h=lug_height, d=lug_diameter);    
}

module mounting_lugs() {
    translate([lug_width/2,lug_length/2,0])
        mounting_lug();
    translate([-lug_width/2,lug_length/2,0])
        mounting_lug();
    translate([-lug_width/2,-lug_length/2,0])
        mounting_lug();
    translate([lug_width/2,-lug_length/2,0])
        mounting_lug();
}

module mounting_plate() {
    translate([pcb_width*1.5, -((pcb_length/2)-5), -wall_thickness*4]) {
        difference() {
            cube([pcb_width+(wall_thickness*2),pcb_length+(wall_thickness*2),wall_thickness*8], true);
            cube([pcb_width,pcb_length,wall_thickness*8], true);
        }
    }
    translate([pcb_width*1.5, -((pcb_length/2)-5), -wall_thickness/2]) {
        cube([pcb_width,pcb_length,wall_thickness], true);
    }
}

module case_front() {
    cube([case_width, case_length, wall_thickness], true);
    translate([-20,22,0]) {
        label();
    }
    translate([+20,22,0]) {
        label();
    }
    translate([-20,-25,0]) {
        label();
    }
    translate([+30,-25,0]) {
        label();
    }
}

module case_front_holes(led_wall=0, led_depth=-wall_thickness/2) {
    led_offset=0;
    // ping_led
    translate([-(case_width/2)+edge_clearance, (case_length/2)-edge_clearance, led_depth-led_offset]) {
        cylinder(h=wall_thickness*4, d=led_diameter+led_wall);
    }
    // google.com
    translate([0, (case_length/2)-edge_clearance, led_depth-led_offset]) {
        cylinder(h=wall_thickness*4, d=led_diameter+led_wall);
    }
    // garage_wifi
    translate([0, ((case_length/2)-edge_clearance)-(led_clearance*1), led_depth-led_offset]) {
        cylinder(h=wall_thickness*4, d=led_diameter+led_wall);
    }
    // garage_lan
//    translate([0, ((case_length/2)-edge_clearance)-(led_clearance*1), led_depth]) {
//        cylinder(h=wall_thickness*4, d=led_diameter+led_wall);
//    }
    // google_wifi
    translate([0, ((case_length/2)-edge_clearance)-(led_clearance*2), led_depth-led_offset]) {
        cylinder(h=wall_thickness*4, d=led_diameter+led_wall);
    }
    // google_lan
//    translate([0, ((case_length/2)-edge_clearance)-(led_clearance*2), led_depth]) {
//        cylinder(h=wall_thickness*4, d=led_diameter+led_wall);
//    }
    // switch_a
    translate([0, ((case_length/2)-edge_clearance)-(led_clearance*3), led_depth-led_offset]) {
        cylinder(h=wall_thickness*4, d=led_diameter+led_wall);
    }
    // switch_b
    translate([0, ((case_length/2)-edge_clearance)-(led_clearance*4), led_depth-led_offset]) {
        cylinder(h=wall_thickness*4, d=led_diameter+led_wall);
    }

    // apple_tv_a_wifi
    translate([-(case_width/2)+edge_clearance, ((case_length/2)-edge_clearance)-(led_clearance*5), led_depth-led_offset]) {
        cylinder(h=wall_thickness*4, d=led_diameter+led_wall);
    }
    // apple_tv_a
//    translate([-(case_width/2)+edge_clearance*1.5, ((case_length/2)-edge_clearance)-(led_clearance*5), led_depth]) {
//        cylinder(h=wall_thickness*4, d=led_diameter+led_wall);
//    }
    // apple_tv_b_wifi
    translate([edge_clearance-3, ((case_length/2)-edge_clearance)-(led_clearance*5), led_depth-led_offset]) {
        cylinder(h=wall_thickness*4, d=led_diameter+led_wall);
    }
    // apple_tv_b
//    translate([edge_clearance*1.5, ((case_length/2)-edge_clearance)-(led_clearance*5), led_depth]) {
//        cylinder(h=wall_thickness*4, d=led_diameter+led_wall);
//    }
    // bike_tv_a_wifi
    translate([-(case_width/2)+edge_clearance, ((case_length/2)-edge_clearance)-(led_clearance*6), led_depth-led_offset]) {
        cylinder(h=wall_thickness*4, d=led_diameter+led_wall);
    }
    // bike_tv_a
//    translate([-(case_width/2)+edge_clearance*1.5, ((case_length/2)-edge_clearance)-(led_clearance*6), led_depth]) {
//        cylinder(h=wall_thickness*4, d=led_diameter+led_wall);
//    }
    // bike_tv_b_wifi
    translate([edge_clearance-3, ((case_length/2)-edge_clearance)-(led_clearance*6), led_depth-led_offset]) {
        cylinder(h=wall_thickness*4, d=led_diameter+led_wall);
    }
    // bike_tv_b
//    translate([edge_clearance*1.5, ((case_length/2)-edge_clearance)-(led_clearance*6), led_depth]) {
//        cylinder(h=wall_thickness*4, d=led_diameter+led_wall);
//    }
    // trainer_a_wifi
    translate([-(case_width/2)+edge_clearance, ((case_length/2)-edge_clearance)-(led_clearance*7), led_depth-led_offset]) {
        cylinder(h=wall_thickness*4, d=led_diameter+led_wall);
    }
    // trainer_a
//    translate([-(case_width/2)+edge_clearance*1.5, ((case_length/2)-edge_clearance)-(led_clearance*7), led_depth]) {
//        cylinder(h=wall_thickness*4, d=led_diameter+led_wall);
//    }
    // trainer_b_wifi
    translate([edge_clearance-3, ((case_length/2)-edge_clearance)-(led_clearance*7), led_depth-led_offset]) {
        cylinder(h=wall_thickness*4, d=led_diameter+led_wall);
    }
    // trainer_b
//    translate([edge_clearance*1.5, ((case_length/2)-edge_clearance)-(led_clearance*7), led_depth]) {
//        cylinder(h=wall_thickness*4, d=led_diameter+led_wall);
//    }
}


module case_labels() {
    // ping_led
    text_depth=1;
    #linear_extrude(text_depth) {
    translate([-(case_width/2)+edge_clearance+led_diameter, (case_length/2)-edge_clearance-1, -text_depth]) {
        text("power", size=5, font=text_font);
    }
    // google.com
    translate([led_diameter, (case_length/2)-edge_clearance-1, text_depth]) {
        text("internet", size=5, font=text_font);
    }
    // garage_wifi
    translate([led_diameter, ((case_length/2)-edge_clearance)-(led_clearance*1)-1, text_depth]) {
        text("garage", size=5, font=text_font);
    }
    // garage_lan
//    translate([0, ((case_length/2)-edge_clearance)-(led_clearance*1), led_depth]) {
//        cylinder(h=wall_thickness*4, d=led_diameter+led_wall);
//    }
    // google_wifi
    translate([led_diameter, ((case_length/2)-edge_clearance)-(led_clearance*2)-1, text_depth]) {
        text("google", size=5, font=text_font);
    }
    // google_lan
//    translate([0, ((case_length/2)-edge_clearance)-(led_clearance*2), led_depth]) {
//        cylinder(h=wall_thickness*4, d=led_diameter+led_wall);
//    }
    // switch_a
    translate([led_diameter, ((case_length/2)-edge_clearance)-(led_clearance*3)-1, text_depth]) {
        text("switch_a", size=5, font=text_font);
    }
    // switch_b
    translate([led_diameter, ((case_length/2)-edge_clearance)-(led_clearance*4)-1, text_depth]) {
        text("switch_b", size=5, font=text_font);
    }

    // apple_tv_a_wifi
    translate([-(case_width/2)+edge_clearance+led_diameter, ((case_length/2)-edge_clearance)-(led_clearance*5)-1, text_depth]) {
        text("apple_tv_a", size=5, font=text_font);
    }
    // apple_tv_a
//    translate([-(case_width/2)+edge_clearance*1.5, ((case_length/2)-edge_clearance)-(led_clearance*5), led_depth]) {
//        cylinder(h=wall_thickness*4, d=led_diameter+led_wall);
//    }
    // apple_tv_b_wifi
    translate([edge_clearance+led_diameter-3, ((case_length/2)-edge_clearance)-(led_clearance*5)-1, text_depth]) {
        text("apple_tv_b", size=5, font=text_font);
    }
    // apple_tv_b
//    translate([edge_clearance*1.5, ((case_length/2)-edge_clearance)-(led_clearance*5), led_depth]) {
//        cylinder(h=wall_thickness*4, d=led_diameter+led_wall);
//    }
    // bike_tv_a_wifi
    translate([-(case_width/2)+edge_clearance+led_diameter, ((case_length/2)-edge_clearance)-(led_clearance*6)-1, text_depth]) {
        text("bike_tv_a", size=5, font=text_font);
    }
    // bike_tv_a
//    translate([-(case_width/2)+edge_clearance*1.5, ((case_length/2)-edge_clearance)-(led_clearance*6), led_depth]) {
//        cylinder(h=wall_thickness*4, d=led_diameter+led_wall);
//    }
    // bike_tv_b_wifi
    translate([edge_clearance+led_diameter-3, ((case_length/2)-edge_clearance)-(led_clearance*6)-1, text_depth]) {
        text("bike_tv_b", size=5, font=text_font);
    }
    // bike_tv_b
//    translate([edge_clearance*1.5, ((case_length/2)-edge_clearance)-(led_clearance*6), led_depth]) {
//        cylinder(h=wall_thickness*4, d=led_diameter+led_wall);
//    }
    // trainer_a_wifi
    translate([-(case_width/2)+edge_clearance+led_diameter, ((case_length/2)-edge_clearance)-(led_clearance*7)-1, text_depth]) {
        text("trainer_a", size=5, font=text_font);
    }
    // trainer_a
//    translate([-(case_width/2)+edge_clearance*1.5, ((case_length/2)-edge_clearance)-(led_clearance*7), led_depth]) {
//        cylinder(h=wall_thickness*4, d=led_diameter+led_wall);
//    }
    // trainer_b_wifi
    translate([edge_clearance+led_diameter-3, ((case_length/2)-edge_clearance)-(led_clearance*7)-1, text_depth]) {
        text("trainer_b", size=5, font=text_font);
    }
    // trainer_b
//    translate([edge_clearance*1.5, ((case_length/2)-edge_clearance)-(led_clearance*7), led_depth]) {
//        cylinder(h=wall_thickness*4, d=led_diameter+led_wall);
//    }
    }
}



module display_holes() {
    difference() {
        union() {
            case_front();
            case_front_holes(2,-wall_thickness*3.5);
        }
        translate([0,0,0])
        case_front_holes(0, -wall_thickness*3.5);
    }
}

module label() {
    color("blue") {
//        cube([30,40,10], true);
    }
}

module walls() {
    translate([0,0,-case_depth/2]) {
        difference() {
            cube([case_width, case_length, case_depth], true);
            cube([case_width-(wall_thickness*2), case_length-(wall_thickness*2), case_depth], true);
            
        }
    }
}

module backPlate() {
    cube([case_width, case_length, wall_thickness], true);
    translate([0,0,wall_thickness*2])
    difference() {
        cube([(case_width-(wall_thickness*2))-.2, (case_length-(wall_thickness*2))-.2, wall_thickness*4], true);
        cube([(case_width-(wall_thickness*4))-.2, (case_length-(wall_thickness*4))-.2, wall_thickness*4], true);
    }
    peglength=14;
    translate([(-case_width/2)+15,(-case_length/2)+15,wall_thickness/2+(peglength/2)]) {
        cube([6,6,peglength], true);
    }
}

//difference() {
//    mounting_plate();
//    cylinder(h=wall_thickness, d=led_diameter);
//}

if(false) {
if (labels_only==0) {
    difference() {
        union() {
            display_holes();
            mounting_plate();
            walls();
                
        }
        translate([(case_width/2)-18,-((case_length/2)-wall_thickness*1.5),-wall_thickness*4]) {
            usb_port();
        }
        translate([0,0,-.2])
            case_labels();

    }
} else {
    if (labels_only==1) {
        translate([0,0,-.2])
            case_labels();
    } else {
        difference() {
            case_front_holes(0, -wall_thickness*3.5);

            translate([0,0,-0.4]) {

                case_front_holes(0, -wall_thickness*3.5);
            }
        }
    }
}
} else {
    backPlate();
}