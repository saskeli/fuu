import moonlander.library.*;

// Minim must be imported when using Moonlander with soundtrack.
import ddf.minim.*;

Moonlander moonlander;

PFont font;
int BPM = 107;

void setup() {
    frameRate(60);
    size(720, 480, P3D);
    scale(height/1000.0);
    noCursor();
    colorMode(HSB, 360, 100, 100);
    
    font = createFont("FiraCode-Medium.ttf", 200);
    
    moonlander = Moonlander.initWithSoundtrack(this, "Ouroboros.mp3", BPM, 4);

    moonlander.start();
}

void draw() {
    moonlander.update();
    translate(width/2, height/2, 0);
    translate(-35, 30, -420);

    ambientLight(0, 0, 75);
    pointLight(0, 0, 100, 10, 10, 0);

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
  // buildings(time);
  pole(time);
  grass(0, 0, 0);
  sign(time, "MOI!", 0.5, true);
  sign(time, "Mitä kuuluu?", 3, false);
}

void scene1(double time) {
  background(210, 90, 70);
  println(time);
  road(time);
  buildings(time - 32); // buildings start at beat 32
  pole(time);
  grass(90, 90, 60);
  trafficLight((float) time);
}


void scene2(double time) {
  float t = (float)time;
  background(248, 70, 70);
  road(320);
  float train = (float) moonlander.getValue("train");
  train(train, t);
  trafficLight(t);
}

void scene3(double time) {
  background(10, 10, 10);
  road(time);
  trafficLight((float)time);
}

void scene4(double time) {
  background((float) (time * 8) % 360, 90, 90);
  road(time);
  buildings(time);
  pole(time);
  grass(90, 90, 50);
}

void scene5(double time) {
  background(0, 0, 0);
  road(time);
  pole(time);
}

void scene6(double time) {
  background(0, 0, 100);
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
  stroke(0, 0, 0);
  fill(0, 0, 50);
  box(w * bSize, h * bSize, d * bSize);
  popMatrix();
}

void buildings(double time) {
  house(time, 0, -1, 240, 600, 100);
  house(time, -4, -1, 200, 550, 80);
  house(time, -2, -1, 240, 600, 100);
  house(time, -8, -1, 240, 550, 100);
  
  house(time, -1, 1, 240, 600, 100);
  house(time, -3, 1, 240, 550, 80);
  house(time, -7, 1, 240, 600, 100);
  house(time, -9, 1, 240, 600, 100);
  house(time, -11 , 1, 240, 600, 80);
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
    float p5 = p1 - 400;
    float p6 = p1 < 200 ? p1 - 200 : p1 - 600;
    int offset = 130;
    onepole(p1, offset);
    onepole(p2, offset);
    onepole(p3, -offset);
    onepole(p4, -offset);
    onepole(p5, offset);
    onepole(p6, -offset);
}


void grass(int h, int s, int b) {
    int w = 400;
    int offset = 52; 
    pushMatrix();
    noStroke();
    fill(0);
    rotateX(PI/2);
    scale(2.0);
    fill(h, s, b);
    rect(offset, 0, w, 800);
    rect(-(w + offset), 0, w, 800);
    popMatrix();
}

void onepole(float pos, float offset) {
    int bs = offset > 0 ? 12 : -12;
    fill(0, 0, 0);
    pushMatrix();
    float hl = pos > 0 ? 0 : -pos;
    translate(offset, -100 + hl, pos);
    box(3, 200, 3);
    pushMatrix();
    translate(- bs/2, -100, 0); 
    box(bs, 3, 3);
    popMatrix();
    
    pushMatrix();
    noStroke();
    fill(0, 0, 100);
    translate(- (4 *  bs / 6), -(100 - 2), 0);
    sphere(2);
    popMatrix();
    popMatrix();
}


void sign(double time, String text, float start, boolean right) {
  int mul = right ? 1 : -1;
  int dur = 12;
  if (time < start || time > start + dur) {
    return;
  }
  float depth = map((float)time, start, start + dur, -450, 900);
  float he = depth < 0 ? map(depth, -450, 0, -120, 0) : map(depth, 0, 900, 0, 30); 
  float tSize = 50;
  pushMatrix();
  fill(0, 0, 0);
  float tw = textWidth(text);
  translate(mul * (140 + tw / 2), - 3 * tSize / 8 - he, depth - 1.1);
  box(tw, tSize, 1);
  noStroke();
  popMatrix();
  textFont(font);
  textSize(tSize);
  fill(0, 0, 100);
  float tpos = right ? 140 : -140 - tw;
  text(text, tpos, -he, depth);
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
    
    if (pos > -tWidth && pos < 2*tWidth + 2*width) {
      if(i==0)
        rect(pos, -40, tWidth, 80, 10, 70, 20, 10);
      else
        rect(pos, -40, tWidth, 80, 10);
    }
  }
  popMatrix();
}

void trafficLight(float time) {
  if (time < 36)
    return;
  float beat = time;
  if (time >= 40 && time <= 47)
    time = 40;
  float beg = 36;
  float end = 40;
  if (time > 47) {
    beg += 7;
    end += 7;
  }
  pushMatrix();
  noStroke();
  fill(0);
  float x1 = map(time, beg, end, -100, -300);
  float x2 = map(time, beg, end, 100, 200);
  float y = map(time, beg, end, 2, -220);
  float w1 = map(time, beg, end, 2, 6);
  float h = map(time, beg, end, 0, 250);
  rect(x1, y, w1, h);
  rect(x2, y, w1, h);
  rect(x1, y, x2-x1, w1);
  float w3 = w1*6.5;
  float x3 = (x1+x2)*0.25;
  float y3 = y-w3/2;
  rect(x3, y3, (x2-x1)/4, w3);
  popMatrix();
  
  pushMatrix();
  int col = (int) map(beat, 40, 47, 0, 122);
  float x = map(beat, 40, 47.5, 0, 80);
  fill(col, 83, 92);
  //translate(0, -103);
  if (time < 40)
    circle(x3+w3/2+2, y3+w3/2+1, w3*.8);
  else if (time < 47)
    circle(x, -abs(cos(2*beat*PI))*117-103, 29.5);
  else {
    fill(112, 83, 92);
    circle(x3+(x2-x1)/4-w3/2-2, y3+w3/2+1, w3*.8);
  }
  popMatrix();
}
