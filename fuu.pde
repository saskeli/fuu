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
  background(0, 0, 0);
  road(time);
}

void scene1(double time) {
  background(255, 255, 100);
  road(time);
}


void scene2(double time) {
  float t = (float)time;
  background(100, 100, (int) time * 3);
  road(time);
  float train = (float) moonlander.getValue("train");
  train(train, t);
  ball(t);
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

void train(float train, float time) {
  int x = width * 2 + 300;
  int tCount = 8;
  int tWidth = x/tCount - 5;
  float trainLoc = train * (tWidth + 5);
  pushMatrix();
  translate(-width-300, -50);
  for(int i=0; i < 58; i++) {
    float pos = trainLoc - i*(tWidth+5);
    
    if (pos > -tWidth && pos < tWidth + 2*width)
      rect(pos, -40, tWidth, 80, 10);
  }
  popMatrix();
}

void ball(float time) {
  
  pushMatrix();
  translate(0, -100);
  circle(0, -abs(cos(2*time*PI))*150, 30);
  popMatrix();
}
