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
    moonlander = Moonlander.initWithSoundtrack(this, "Ouroboros.mp3", BPM, 4);

    moonlander.start();
}

void draw() {
    
    moonlander.update();
    translate(width/2, height/2, 0);
    translate(-35, 30, -420);
    double time = moonlander.getValue("Ouroboros.mp3");
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
  background(0, 0, 0);
  road(time);
  pole(time);
  //grass(0, 150, 0);
}

void scene1(double time) {
  background(255, 255, 100);
  road(time);
  pole(time);
  grass(0, 150, 0);
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

void pole(double value) {
    float p1 = (((int)value % 4) + ((float)value - (int)value)) * 100;
    float p2 = p1 + 400;
    float p3 = p1 + 200;
    float p4 = (p3 + 400) % 800;
    int offset = 130;
    onepole(p1, offset);
    onepole(p2, offset);
    onepole(p3, -offset);
    onepole(p4, -offset);
    
}


void grass(int r, int g, int b) {
    int w = 400;
    int offset = 52; 
    pushMatrix();
    noStroke();
    fill(0);
    rotateX(PI/2);
    scale(2.0);
    fill(r, g, b);
    rect(offset, 0, w, 800);
    rect(-(w + offset), 0, w, 800);
    popMatrix();
}

void onepole(float pos, float offset) {
    int bs = offset > 0 ? 12 : -12; 
    fill(0);
    pushMatrix();
    translate(offset, -pos / 4, pos);
    box(3, pos / 2, 3);
    pushMatrix();
    translate(- bs/2, -pos / 4, 0); 
    box(bs, 3, 3);
    popMatrix();
    pushMatrix();
    fill(255);
    translate(- (4 *  bs / 6), -(pos/4 - 2), 0);
    sphere(2);
    popMatrix();
    popMatrix();
}
