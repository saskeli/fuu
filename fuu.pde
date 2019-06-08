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
    translate(0, 50, -450);
    // Get current value of a track
    double value = moonlander.getValue("1003.mp3");
    road(value);s
}

void road(double value) {
    int rlen = 450;
    int v = (int)map((float)(value - (int)value), 0.0, 1.0, 0.0, rlen);
    int voff = (v + 150) % rlen;
    int vofff = (v + 300) % rlen;
    pushMatrix();
    noStroke();
    noCursor();
    fill(0);
    rotateX(PI/2);
    scale(2.0);
    //road
    rect(2, 0, 50, rlen);
    rect(-52, 0, 50, rlen);
    
    //blacks
    rect(-2, 0, 4, min(v, voff, vofff));
    rect(-2, min(v, voff, vofff) + 16, 4, 150 - 16);
    rect(-2, max(v, voff, vofff), 4, 16 - 150);
    rect(-2, max(v, voff, vofff) + 16, 4, rlen - (max(v, voff, vofff) + 16));
    
    fill(255);
    //whites
    rect(-2, v, 4, 16);
    rect(-2, voff, 4, 16);
    rect(-2, vofff, 4, 16);
    
    popMatrix();
}
