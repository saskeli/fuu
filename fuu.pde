import moonlander.library.*;

// Minim must be imported when using Moonlander with soundtrack.
import ddf.minim.*;

Moonlander moonlander;

PFont font;
int BPM = 107;

int[] rainbow_l = new int[9];
int[] rainbow_r = new int[9];
int p_skip = 0;
int center_hue = (int)random(0, 361);
int center_hue_counter = 2;

void setup() {
    frameRate(60);
    //size(720, 480, P3D);
    scale(height/1000.0);
    fullScreen(P3D);
    noCursor();
    colorMode(HSB, 360, 100, 100);
    
    font = createFont("FiraCode-Medium.ttf", 200);
    
    for (int i = 0; i < 9; i++) {
      rainbow_l[i] = (int)random(0, 361);
      rainbow_r[i] = (int)random(0, 361);
    }
    
    moonlander = Moonlander.initWithSoundtrack(this, "Ouroboros.mp3", BPM, 4);

    moonlander.start();
}

void draw() {
    moonlander.update();
    translate(width/2, height/2, 0);
    translate(-35, 50, 45);

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
  background(0, 0, 5);
  road(time);
  // buildings(time);
  pole(time);
  grass(0, 0, 0);
  sign(time, "Straight into", -1.5, false);
  sign(time, "production", -1.5, true);
  sign(time, "Vegan", 2, false);
  sign(time, "demo", 2.5, true);
  sign(time, "killed", 5, true);
  sign(time, "No bugs", 5, false);
}

void scene1(double time) {
  background(210, 90, 70);
  println(time);
  road(time);
  buildings(time - 24); // buildings start at beat 32
  pole(time);
  grass(90, 90, 60);
  trafficLight((float) time);
  sign(time, "killed", 5, true);
  sign(time, "No bugs", 5, false);
  pushMatrix();
  translate(0, -100, -3);
  for (int i = 0; i < 12; i++) {
    cloud(time + 0.5 + i * 30, 50 + (int)random(0, 51), false);
  }
  popMatrix();
  for (int i = 0; i < 12; i++) {
    cloud(time + i * 30, 60 + (int)random(0, 41), false);
  }
  sign(time, "TEAM", 14, false);
  sign(time, "kypertek", 14.5, true);
}


void scene2(double time) {
  float t = (float)time;
  background(210, 90, 70);
  if(time > 47) {
    road(time);
    pole(time);
    buildings(time - 32); 
  }
  else {
    road(40);
    pole(40);
    buildings(40 - 32); 
  }
  buildings(40 - 32); 
  grass(90, 90, 60);
  train(t);
  trafficLight(t);
  pushMatrix();
  translate(0, -100, -3);
  for (int i = 0; i < 12; i++) {
    cloud(time + 0.5 + i * 30, 50 + (int)random(0, 51), false);
  }
  popMatrix();
  for (int i = 0; i < 12; i++) {
    cloud(time + i * 30, 60 + (int)random(0, 41), false);
  }
}


void scene3(double time) {
  background(10, 10, 10);
  // ambientLight(0, 0, 100);
  pointLight(0, 0, 100, 0, 0, 0);
  rainbow_road(time, 48);
  trafficLight((float)time);
  
  int failCubeNumber = moonlander.getIntValue("failCubeNumber");
  int textCue = moonlander.getIntValue("textCue");
    
  pushMatrix();
  stroke(90, 100, 100);
  
  textFont(font);
  textSize(48);
  fill(0, 0, 100);
  
  if (textCue >= 0 && textCue < 3) text("And now", -500, -350, 100);
  if (textCue >= 1 && textCue < 3) text("Some failed attempts", -500, -280, 100);
  if (textCue >= 2 && textCue < 3) text("at rendering cubes", -500, -210, 100);
  if (textCue == 3) text("FailCube #" + failCubeNumber, -500, -200, 150);
  // if (textCue == 0) text("Here are some failed attempts at rendering cubes", -500, -200, 100);
  // if (textCue == 0) text("Here are some failed attempts at rendering cubes", -500, -200, 100);
  
  
  for (int i=0; i<5; i++) {
    translate(noise(i, (float) time), -100, i*50);
    rotateX((float) time + (i*PI /5));
    rotateY((float) time + (i*PI /5));
    rotateZ((float) time + (i*PI /5));
    if (failCubeNumber == 0) failCube0();
    else if (failCubeNumber == 1) failCube1();
    else if (failCubeNumber == 2) failCube2();
    else if (failCubeNumber == 3) failCube3();
    else if (failCubeNumber == 4) failCube4();
  // else if (failCubeNumber == 5) failCube5();
  }
  
  popMatrix();
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
  pushMatrix();
  scale(0.3);
  translate(0, 85, 1500);
  cloud(time, 100, true);
  popMatrix();
  sign(time, "Music:", 86, false);
  sign(time, "Ouroboros", 86, true);
  sign(time, "By Kevin", 88.5, false);
  sign(time, "MacLeod", 88.5, true);
  sign(time, "Font:", 91, false);
  sign(time, "FiraCode", 91, true);
  sign(time, "Graffathon", 93.5, false);
  sign(time, "JesJes!", 93.5, true);
  sign(time, "Greetz!", 96, false);
  sign(time, "Team", 98.5, false);
  sign(time, "Gurula", 98.5, true);
}

void scene6(double time) {
  background(0, 70, 90);
  road(time); 
  sign(time, "Music:", 86, false);
  sign(time, "Ouroboros", 86, true);
  sign(time, "By Kevin", 88.5, false);
  sign(time, "MacLeod", 88.5, true);
  sign(time, "Font:", 91, false);
  sign(time, "FiraCode", 91, true);
  sign(time, "Graffathon", 93.5, false);
  sign(time, "JesJes!", 93.5, true);
  sign(time, "Greetz!", 96, false);
  sign(time, "Team", 98.5, false);
  sign(time, "Gurula", 98.5, true);
  sign(time, "KTHXBY", 101, false);
  sign(time, "beep beep", 103.5, true);
}

void scene7(double time) {
  exit();
}

void cloud(double time, int light, boolean legs)
{
  pushMatrix();
  scale(3);
  fill(0, 0, light);
  float posX_incr = 50 * (float) time;
  posX_incr %= width;
  
  float n = noise(-250+posX_incr, 50);
  int scale = 25;
  translate(-200, -160, -100);
  rect(-250+posX_incr, 50+scale*n, 150, 40, 80, 80, 20, 20);
  ellipse(-250+115+posX_incr, 50+scale*n, 50, 50);
  ellipse(-250+35+posX_incr, 50+scale*n, 50, 50);
  ellipse(-250+75+posX_incr, 40+scale*n, 50, 50);
  if (legs) {
    pushMatrix();
    fill(0, 0, 50);
    translate(0, 0, -5);
    rect(-250+posX_incr + 30, 50+scale*n + 30, 8, 40);
    rect(-250+posX_incr + 110, 50+scale*n + 30, 8, 40);
    fill(0, 0, 70);
    rect(-250+posX_incr + 37, 50+scale*n + 30, 8, 40);
    rect(-250+posX_incr + 117, 50+scale*n + 30, 8, 40);
    popMatrix();
  }
  popMatrix();
}

void house(double time, int offset, int side, int w, int h, int d) {
  int scene = moonlander.getIntValue("scene");
  
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
  
  if (scene == 4) {
    int style = moonlander.getIntValue("house-style");
    pushMatrix();
    noStroke();
    // translate(xPos + (side*w*bSize), (-h * bSize) / 2, v);
    translate(xPos + (side * 100), 0, 1.7 * v);
    
    scale(bSize);
    
    for (int i=0; i < 100; i += 10) {
      for (int j=0; j < 300; j += 10) {
        pushMatrix();
        if (side == 1) {
          translate(i, -j, 0);
        } else {
          translate(-i, -j, 0);
        }
        float b = (float) (2*time) % 10;
        int beatIdx = i / 10;
        if (style == 0) {
          if (beatIdx < b) { //&& b <= beatIdx + 10) {
            box(10, 10, (noise(i, j, (float) (2*time)) * 60) + 40);
          } else {
            box(10, 10, 100);
          }
        } else if (style == 1) {
          int longerB = (int) ((2*time) % 40) -20;
          int sumIdx = (i+j) / 10;
          if (sumIdx < longerB) { //&& b <= beatIdx + 10) {
            box(10, 10, (noise(i, j, (float) (2*time)) * 60) + 40);
          } else if (36 - sumIdx < longerB) {
            box(10, 10, (noise(i, j, (float) (2*time)) * 60) + 40);
          } else {
            box(10, 10, 100);
          }
        } else if (style == 2) {
          double houseRotation = moonlander.getValue("rotation");
          float lambda = noise(i,j);
          rotateX((float) houseRotation * lambda);
          rotateY((float) houseRotation * (1-lambda));
          rotateZ((float) houseRotation * (1-lambda));
          box(8, 8, (noise(i, j, (float) (2*time)) * 60) + 40);
        } else {
          // default to lines (style 0)
          if (beatIdx < b) { //&& b <= beatIdx + 10) {
            box(10, 10, (noise(i, j, (float) (2*time)) * 60) + 40);
          } else {
            box(10, 10, 100);
          } 
        }
        popMatrix();
      }
    }
    popMatrix();
  } else {
    pushMatrix();
    strokeWeight(1);
    scale(2);
    translate(xPos + (side*w*bSize), (-h * bSize) / 2, v);
    stroke(0, 0, 0);
    fill(0, 0, 50);
    box(w * bSize, h * bSize, d * bSize);
    popMatrix();
  }
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
    fill(1);
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

void rainbow_road(double value, int start) {
    int rlen = 400;
    int delta = rlen / 4;
    int i_skip = 8 - (((int)value * 4 - start) % 8);
    if (i_skip != p_skip) {
      for (int i = 0; i < 9; i++) {
        rainbow_r[i] = (int)random(0, 361);
        rainbow_l[i] = (int)random(0, 361);
      }
      if (center_hue_counter == 0) {
        center_hue = (int)random(0, 361);
      }
      center_hue_counter = (center_hue_counter + 1) % 4;
      p_skip = i_skip;
    }
    int v1 = (int)map((float)(value - (int)value), 0.0, 1.0, 0.0, rlen);
    int v2 = (v1 + 100) % rlen;
    int v3 = (v1 + 200) % rlen;
    int v4 = (v1 + 300) % rlen;
    float r_len = map((float)value % 1, 0, 1, 0, 50);
    pushMatrix();
    noStroke();
    rotateX(PI/2);
    scale(2.0);
    //road
    fill(rainbow_r[i_skip], 100, 100);
    rect(2, 0, 50, r_len);
    fill(rainbow_l[i_skip], 100, 100);
    rect(-52, 0, 50, r_len);
    for (int i = 1; i < 9; i++) {
      float spos = (i - 1) * 50 + r_len;
      fill(rainbow_r[(i + i_skip) % 8], 100, 100);
      rect(2, spos, 50, 50); 
      fill(rainbow_l[(i + i_skip) % 8], 100, 100);
      rect(-52, spos, 50, 50);
    }
    
    int minv = min(min(v1, v2), min(v3, v4));
    int maxv = max(max(v1, v2), max(v3, v4));
    int blen = delta - 16;
    fill(center_hue, 100, 100);
    //blacks
    rect(-2, 0, 4, minv);
    rect(-2, minv + 16 , 4, blen);
    rect(-2, minv + 16 + delta, 4, blen);
    rect(-2, minv + 16 + delta * 2, 4, blen);
    rect(-2, maxv + 16, 4, rlen - (maxv + 16));
    
    fill(0, 0, 100);
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
  float pad = textWidth("i");
  translate(mul * (140 + tw / 2), - 3 * tSize / 8 - he, depth - 1.1);
  box(tw + pad, tSize, 1);
  noStroke();
  popMatrix();
  textFont(font);
  textSize(tSize);
  fill(0, 0, 100);
  float tpos = right ? 140 : -140 - tw;
  text(text, tpos, -he, depth);
}


void train(float time) {
  float train = (time - 40)*8 + 1;
  int x = width * 2 + 300;
  int tCount = 8;
  float tWidth = x/tCount - 5;
  float wWidth = tWidth/4 - 8;
  float trainLoc = train * (tWidth + 5) + tWidth;
  pushMatrix();
  translate(-width-300, -50);
  for(int i=0; i < 52; i++) {
    float pos = trainLoc - i*(tWidth+5);
    fill(73,0,27);
    
    if (pos > -tWidth && pos < 2*tWidth + 2*width) {
      if(i==0) {
        rect(pos, -40, tWidth, 80, 10, 70, 20, 10);
      }
      else {
        rect(pos, -40, tWidth, 80, 10);
        fill(73,0,200);
          
        for(int j = 0; j < 4; j++)
          rect(pos + j*(wWidth+7)+5, -30, wWidth, 30);
      }
    }
  }
  popMatrix();
}

void trafficLight(float time) {
  if (time < 36)
    return;
  
  pushMatrix();
  translate(0,-33,400);
  float beat = time;
  if (time >= 40 && time <= 47)
    time = 40;
  float beg = 36;
  float end = 40;
  float x1, x2, y, w1, h;
  if (time >= 47) {
    beg = 47;
    end = 47.5;
    x1 = map(time, beg, end, -300, -600);
    x2 = map(time, beg, end, 200, 400);
    y = map(time, beg, end, -187, -300);
    w1 = map(time, beg, end, 6, 10);
    h = map(time, beg, end, 250, 400);
  } else {
    x1 = map(time, beg, end, -100, -300);
    x2 = map(time, beg, end, 100, 200);
    y = map(time, beg, end, 10, -187);
    w1 = map(time, beg, end, 2, 6);
    h = map(time, beg, end, 10, 250);
  }
  noStroke();
  fill(0);
  
  rect(x1, y, w1, h);
  rect(x2, y, w1, h);
  rect(x1, y, x2-x1, w1);
  float w3 = w1*6.5;
  float x3 = (x1+x2)*0.25;
  float y3 = y-w3/2;
  rect(x3, y3, (x2-x1)/4, w3);
  
  int col = (int) map(beat, 40, 47, 0, 122);
  float x = map(beat, 40, 47.5, 0, 80);
  fill(col, 83, 92);
  if (time < 40)
    circle(x3+w3/2+2, y3+w3/2+1, w3*.8);
  else if (time < 47)
    circle(x, -abs(cos(2*beat*PI))*145-42, 29.5);
  else {
    fill(112, 83, 92);
    circle(x3+(x2-x1)/4-w3/2-2, y3+w3/2+1, w3*.8);
  }
  popMatrix();
}

/*
FAILCUBES!
*/
void failCube0() {
    beginShape();
    vertex(0, 0, 0);
    vertex(50, 0, 0);
    vertex(0, 50, 0);
    vertex(0, 0, 50);
    
    vertex(50, 50, 0);
    vertex(0, 50, 50);
    vertex(50, 0, 50);
    
    vertex(50, 50, 50);
    endShape();
}


void failCube1() {
    beginShape();
    vertex(0, 0, 0);
    vertex(50, 0, 0);
    vertex(0, 50, 0);
    vertex(50, 50, 0);
    vertex(50, 0, 50);
    vertex(50, 50, 50);
    vertex(0, 0, 50);
    vertex(0, 50, 50);
    endShape();
}
void failCube3() {
    beginShape(QUAD);
    vertex(0, 0, 0);
    vertex(50, 0, 0);
    vertex(50, 50, 0);
    vertex(0, 50, 0);
    vertex(0, 0, 0);

    vertex(50, 0, 0);
    vertex(50, 0, 50);
    vertex(50, 50, 50);
    vertex(50, 50, 0);

    vertex(50, 0, 0);
    vertex(50, 0, 50);
    vertex(50, 50, 50);
    vertex(50, 50, 0);

    vertex(50, 50, 0);
    vertex(50, 50, 50);
    vertex(0, 50, 50);
    vertex(0, 50, 0);

    vertex(0, 0, 0);
    vertex(0, 0, 50);
    vertex(0, 50, 50);
    vertex(0, 50, 0);

    vertex(0, 0, 50);
    vertex(0, 50, 50);
    vertex(50, 50, 50);
    vertex(50, 0, 50);

    endShape();
}
void failCube2() {
    beginShape();
    vertex(0, 0, 0);
    vertex(50, 0, 0);
    vertex(50, 0, 50);
    vertex(50, 50, 50);
    vertex(50, 50, 0);
    vertex(0, 50, 0);
    vertex(0, 50, 50);
    vertex(0, 0, 50);
    
    endShape();
}

void failCube4() {
   beginShape(QUAD);
    vertex(0, 0, 0);
    vertex(50, 0, 0);
    vertex(50, 50, 0);
    vertex(0, 50, 0);

    vertex(50, 0, 0);
    vertex(50, 0, 50);
    vertex(50, 50, 50);
    vertex(50, 50, 0);

    vertex(50, 0, 0);
    vertex(50, 0, 50);
    vertex(50, 50, 50);
    vertex(50, 50, 0);

    vertex(50, 50, 0);
    vertex(50, 50, 50);
    vertex(0, 50, 50);
    vertex(0, 50, 0);

    vertex(0, 0, 0);
    vertex(0, 0, 50);
    vertex(0, 50, 50);
    vertex(0, 50, 0);

    vertex(0, 0, 50);
    vertex(0, 50, 50);
    vertex(50, 50, 50);
    vertex(50, 0, 50);

    endShape();
}
