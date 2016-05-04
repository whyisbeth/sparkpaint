//IMPORTS
import processing.opengl.*;
import processing.video.*;
import s373.flob.*;

Capture video;
Flob flob;
ArrayList blobs;

//TIMER VARS
int i = 1000;
int s = 60;
int m = 2;

//FLOB VARS
int tresh = 50;
int fade = 25;
int om = 1;
int videores=128; //64 //256
float fps = 60;
int videotex = 2;

//COLOR VARS
int randColorR;
int randColorG;
int randColorB;
int randAlpha;
int randSize;
boolean colorOrange = false;
boolean colorPurple = true;
boolean colorGreen = false;

//SETUP
void setup() {

  //flob mac hack?
  try { 
    quicktime.QTSession.open();
  } 
  catch (quicktime.QTException qte) { 
    qte.printStackTrace();
  }

  //flob stuff
  size(800, 600, OPENGL);
  frameRate(fps);
  rectMode(CENTER);

  video = new Capture(this, videores, videores, (int)fps);

  flob = new Flob(video, width,height);
  flob = new Flob(video, this); 
  flob = new Flob(videores, videores, width, height);
  flob.setTresh(tresh);
  flob.setSrcImage(videotex);
  flob.setImage(videotex);
  flob.setBlur(0);
  flob.setMirror(true,false);
  flob.setOm(0);
  flob.setOm(1);
  flob.setFade(fade);

  blobs = new ArrayList();
  background(255);
}//end setup


//DRAW
void draw() {

  //change colors
  int sec = int(random(second()-1, second()+1));

  if (0 <= sec && sec >= 9) {
    colorOrange = false;
    colorGreen = true;
    colorPurple = false;
  }

  if (10 <= sec && sec >= 19) {
    colorOrange = false;
    colorGreen = false;
    colorPurple = true;
  }

  if(20 <= sec && sec >= 29) {
    colorOrange = true;
    colorGreen = false;
    colorPurple = false;
  }
  
  if (30 <= sec && sec >= 39) {
    colorOrange = false;
    colorGreen = true;
    colorPurple = false;
  }

  if (40 <= sec && sec >= 49) {
    colorOrange = false;
    colorGreen = false;
    colorPurple = true;
  }

  if (50 <= sec && sec >= 59) {
    colorOrange = true;
    colorGreen = false;
    colorPurple = false;
  }

  if (colorOrange == true) {
    paintOrange();
  }

  if (colorGreen == true) {
    paintGreen();
  }

  if (colorPurple == true) {
    paintPurple();
  }

  //save
  if (millis() >= i*s*m) {
    clearAndSave();
    m+=2;
  }
}//end draw

//PAINT ORAGNGE
void paintOrange() {
  if(video.available()) {
    video.read();
    blobs = flob.calc(flob.binarize(video));
  }

  rectMode(CENTER);
  int numblobs = blobs.size();

  for(int i = 0; i < numblobs; i++) {
    ABlob ab = (ABlob)flob.getABlob(i); 
    randAlpha = int(random (25, 100));
    randSize = int(random (5, 150));
    fill(int(random(180, 255)), int(random(100, 150)), int(random(0, 10)), randAlpha);
    noStroke();
    smooth();
    ellipse(ab.cx, ab.cy, ab.dimx-(ab.dimx-randSize), ab.dimx-(ab.dimx-randSize));
  }
}//end paintorange


//PAINT PURPLE
void paintPurple() {
  if(video.available()) {
    video.read();
    blobs = flob.calc(flob.binarize(video));
  }

  rectMode(CENTER);
  int numblobs = blobs.size();

  for(int i = 0; i < numblobs; i++) {
    ABlob ab = (ABlob)flob.getABlob(i); 
    randAlpha = int(random (25, 100));
    randSize = int(random (5, 150));
    fill(int(random(100, 180)), int(random(0, 30)), int(random(15, 255)), randAlpha);
    noStroke();
    smooth();
    ellipse(ab.cx, ab.cy, ab.dimx-(ab.dimx-randSize), ab.dimx-(ab.dimx-randSize));
  }
}//end paintpurple

//PAINT GREEN
void paintGreen() {
  if(video.available()) {
    video.read();
    blobs = flob.calc(flob.binarize(video));
  }

  rectMode(CENTER);
  int numblobs = blobs.size();

  for(int i = 0; i < numblobs; i++) {
    ABlob ab = (ABlob)flob.getABlob(i); 
    randAlpha = int(random (25, 100));
    randSize = int(random (5, 150));
    fill(int(random(100, 180)), int(random(160, 255)), int(random(0, 30)), randAlpha);
    noStroke();
    smooth();
    ellipse(ab.cx, ab.cy, ab.dimx-(ab.dimx-randSize), ab.dimx-(ab.dimx-randSize));
  }
}//end paintgreen


//CLEAR AND SAVE
void clearAndSave() {
  saveFrame("sparkpaint/sparkpaint-####.jpg");
  saveFrame("sparkpaint/sparkpaint-####-thumb.jpg");
  println("clear");
  background(255);
}//end clearandsave

