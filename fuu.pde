import moonlander.library.*;

// Minim must be imported when using Moonlander with soundtrack.
import ddf.minim.*;

Moonlander moonlander;

PImage sprite;

int BPM = 107;

void setup() {
    frameRate(60);
    size(720, 480, P3D);
    scale(height/1000.0);
    noCursor();
    loadImage("sprite.png");
    moonlander = Moonlander.initWithSoundtrack(this, "Ouroboros.mp3", BPM, 4);

    moonlander.start();
}

void draw() {
    
    moonlander.update();
    background(255, 100, 100);
    translate(width/2, height/2, 0);
    translate(0, 50, -450);
    // Get current value of a track
    double value = moonlander.getValue("Ouroboros.mp3");
    road(value);
    pole(value);
}

void pole(double value) {
    float p1 = (((int)value % 4) + ((float)value - (int)value)) * 100;
    float p2 = p1 + 400;
    float p3 = p1 + 200;
    float p4 = (p3 + 400) % 800;
    println(p4 + " " + p2 + " " + p3 + " " + p1);
    pushMatrix();
    fill(0);
    translate(140, -p1 / 4, p1);
    box(3, p1 / 2, 3);
    popMatrix();
    pushMatrix();
    translate(140, -p2 / 4, p2);
    box(3, p2 / 2, 3);
    popMatrix();
    pushMatrix();
    translate(-140, -p3 / 4, p3);
    box(3, p3 / 2, 3);
    popMatrix();
    pushMatrix();
    translate(-140, -p4 / 4, p4);
    box(3, p4 / 2, 3);
    popMatrix();
    PShape part = createShape();
    part.beginShape(QUAD);
    part.noStroke();
    part.texture(sprite);
    part.normal(0, 0, 1);
    part.vertex(-partSize/2, -partSize/2, 0, 0);
    part.vertex(+partSize/2, -partSize/2, sprite.width, 0);
    part.vertex(+partSize/2, +partSize/2, sprite.width, sprite.height);
    part.vertex(-partSize/2, +partSize/2, 0, sprite.height);
    part.endShape();
}

void road(double value) {
    int rlen = 400;
    int delta = rlen / 4;
    int v1 = (int)map((float)(value - (int)value), 0.0, 1.0, 0.0, rlen);
    int v2 = (v1 + 100) % rlen;
    int v3 = (v1 + 200) % rlen;
    int v4 = (v1 + 300) % rlen;
    pushMatrix();
    noStroke();
    fill(0);
    rotateX(PI/2);
    scale(2.0);
    //road
    rect(2, 0, 50, rlen);
    rect(-52, 0, 50, rlen);
    
    int minv = min(min(v1, v2), min(v3, v4));
    int maxv = max(max(v1, v2), max(v3, v4));
    int blen = delta - 16;
    
    //blacks
    rect(-2, 0, 4, minv);
    rect(-2, minv + 16 , 4, blen);
    rect(-2, minv + 16 + delta, 4, blen);
    rect(-2, minv + 16 + delta * 2, 4, blen);
    rect(-2, maxv + 16, 4, rlen - (maxv + 16));
    
    fill(255);
    //whites
    rect(-2, v1, 4, 16);
    rect(-2, v2, 4, 16);
    rect(-2, v3, 4, 16);
    rect(-2, v4, 4, 16);
    
    popMatrix();
}
