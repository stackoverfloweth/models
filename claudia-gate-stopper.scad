barWidth=20;
barHeight=30;

magnetLength=20;
magnetWidth=10;
magnetDepth=2;

difference() {
    cube([barWidth + 40, barHeight+3, barHeight+.5], true);   
    
    translate([-16.5, 1.5, 0])
    cube([barWidth+.5, barHeight+.5, barHeight+.5], true);    
 
    translate([22, -16.5, 0])
    cube([magnetWidth+.5, magnetDepth, magnetLength+.5], true);  
} 