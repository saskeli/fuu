import moonlander.library.*;

// Minim must be imported when using Moonlander with soundtrack.
import ddf.minim.*;

Moonlander moonlander;

int BPM = 125;

void setup() {
    frameRate(60);
    size(720, 480, P3D);
    scale(height/1000.0);
    
    moonlander = Moonlander.initWithSoundtrack(this, "1003.mp3", BPM, 4);

    moonlander.start();
}

void draw() {
    
    moonlander.update();
    background(255, 100, 100);
    translate(width/2, height/2, 0);
    translate(0, 100, -400);
    // Get current value of a track
    double value = moonlander.getValue("1003.mp3");
    println(value);
    int v = (int)map((float)value - (int)value, 0.0, 1.0, 0.0, 300.0);
    pushMatrix();
    noStroke();
    fill(0);
    rotateX(PI/2);
    scale(6.0);
    rect(2, 0, 50, 300);
    rect(-52, 0, 50, 300);
    rect(-2, v + 16, 4, 300 - (v + 16));
    rect(-2, 0, 4, v); 
    fill(255);
    rect(-2, (int)v, 4, 16);
    popMatrix();
    


}
