// 2021 (c) KAKL
// protection against beating of dogs legs

$fn = 50;

inner = 36;
cheight=50;
tl = 14;
screw = 3.6;
size =  inner + tl;
packy = size + 20;
spike_length=size/3;
spike_r=size/15;


module Spike()
{
    offset=4;
    translate([0,0,size/2-offset])
    cylinder(r1=spike_r,r2=0,h=spike_length, $fn=16);
}

module ACylinder()
{
    cylinder(d=size, h=cheight, $fn=300);
    Spikes();
}


module Spikes()
{
    
    d=5;
    nx=20;
    ny=3;


    for (j=[0:1:ny])
    {
        hj=(cheight-10)*j/ny;
        nxi=nx;
        for (i=[0:1:nxi-1])
        {
            ai=360/nxi*i*nxi/floor(nxi);
            translate([0,0,hj+5])
            rotate([0,0,ai])
            rotate([0,90,0])
            Spike();
            

        }
    }

}

module hole()
{
    rotate([0,90,0]) cylinder(d=screw, h=size * 2, center = true, $fn=100);
}

difference()
{
    union()
    {
        translate([-tl/2,-packy/2,0]) cube(size = [size,packy,cheight], center = false);
        ACylinder();
    };

    // diry v packach
    translate([0,packy/2-5,11]) hole();
    translate([0,packy/2-5,cheight-11]) hole();
    translate([0,-packy/2+5,11]) hole();
    translate([0,-packy/2+5,cheight-11]) hole();
    
    cylinder(d=inner, h=cheight+10);
    translate([0,-size-1,-1]) cube(size = [size,size*3,cheight+10], center = false);

    difference()
    {
        translate([-100,-100,cheight-10]) cube(size = [200,200,10], center = false);
        rotate_extrude() translate([size/2,cheight-10,0]) circle(10);
        translate([-100,-100,cheight-10-10]) cube(size = [200,200,10], center = false);
    };
    difference()
    {
        cylinder(d=packy*2, h=cheight+10);
        cylinder(d=packy-3, h=cheight+10);
    };
};

