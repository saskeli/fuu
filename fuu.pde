import moonlander.library.*;

// Minim must be imported when using Moonlander with soundtrack.
import ddf.minim.*;

Moonlander moonlander;

int BPM = 107;

void setup() {
    frameRate(60);
    size(720, 480, P3D);
    scale(height/1000.0);
    noCursor();
    colorMode(HSB, 360, 100, 100);
    
    moonlander = Moonlander.initWithSoundtrack(this, "Ouroboros.mp3", BPM, 4);

    moonlander.start();
}

void draw() {
    
    moonlander.update();
    translate(width/2, height/2, 0);
    translate(0, 50, -450);
    // Get current value of a track
    
    double time = moonlander.getValue("1003.mp3");
    int scene = moonlander.getIntValue("scene");
    switch(scene) {
      case 0: scene0(time);
        break;
      case 1: scene1(time);
        break;
      case 2: scene2(time);
        break;
      case 3: scene3(time);
        break;
      case 4: scene4(time);
        break;
      case 5: scene5(time);
        break;
      case 6: scene6(time);
        break;
      case 7: scene7(time);
        break;
      default:
        break;
    }
}

// scene name goes here
void scene0(double time) {
  background(180,50,50);
  road(time);
  buildings(time);
}

void scene1(double time) {
  background(200, 255, 100);
  road(time);
  buildings(time);
}

void scene2(double time) {
  background(100, 100, (int) time * 3);
  road(time);
}

void scene3(double time) {
  background(10, 10, 10);
  road(time);
}

void scene4(double time) {
  background((int) time * 2, (int) time * 2, (int) time * 2);
  road(time);
}

void scene5(double time) {
  background(255, 100, 100);
  road(time);
}

void scene6(double time) {
  background(255, 255, 255);
  road(time); 
}

void scene7(double time) {
  background(100, 100, 255);
  road(time);
}

void house(double time, int offset, int side, int w, int h, int d) {
  int len = 400;
  int start = -50;
  int loop = 12;
  
  double x = time + (double) offset;
  
  if (x < 0) {
    return;
  }
  
  float v = map((float) x % loop, 0.0, loop, start, (float) len);
  float bSize = map((float) x % loop, 0, loop, 0.0, 1);
  
  int xPos = side * 120;
  
  pushMatrix();
  scale(2);
  translate(xPos + (side*w*bSize), (-h * bSize) / 2, v);
  noFill();
  stroke(0, 100, 100);
  // fill(0, 0, 50);
  box(w * bSize, h * bSize, d * bSize);
  popMatrix();
}

void buildings(double time) {
  house(time, 0, -1, 100, 200, 100);
  house(time, -4, -1, 80, 180, 80);
  house(time, -2, 1, 100, 200, 100);
}

void road(double value) {
    int rlen = 450;
    int v = (int)map((float)(value - (int)value), 0.0, 1.0, 0.0, rlen);
    int voff = (v + 150) % rlen;
    int vofff = (v + 300) % rlen;
    pushMatrix();
    noStroke();
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
