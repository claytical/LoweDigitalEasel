import milchreis.imageprocessing.*;
import milchreis.imageprocessing.utils.*;

char EASEL_BG_TOGGLE = ' ';
char EASEL_BG_NONE = 'y';
char EASEL_BG_IMAGE_UP = 'a';
char EASEL_BG_IMAGE_DOWN = 'b';
char EASEL_MOOD_UP = 'd';
char EASEL_MOOD_DOWN = 'e';
char EASEL_WIDTH_UP = 'f';
char EASEL_WIDTH_DOWN = 'g';
char EASEL_OPACITY_UP = 'i';
char EASEL_OPACITY_DOWN = 'h';
char EASEL_CONTOUR_TOGGLE = 'c';
char EASEL_BRUSH_UP = 'j';
char EASEL_BRUSH_DOWN = 'k';
char EASEL_SCREENSHOT = 'z';
public static final int EASEL_BRUSH_STANDARD = 0;
public static final int EASEL_BRUSH_OUTLINE = 1;
public static final int EASEL_BRUSH_STANDARD_SQUARE = 2;
public static final int EASEL_BRUSH_OUTLINE_SQUARE = 3;

public static final int EASEL_BRUSH_FIVE_X_AXIS = 4;
public static final int EASEL_BRUSH_FIVE_X_AXIS_OUTLINE = 5;
public static final int EASEL_BRUSH_FIVE_X_AXIS_SQUARE = 6;
public static final int EASEL_BRUSH_FIVE_X_AXIS_OUTLINE_SQUARE = 7;

public static final int EASEL_BRUSH_FIVE_Y_AXIS = 8;
public static final int EASEL_BRUSH_FIVE_Y_AXIS_OUTLINE = 9;
public static final int EASEL_BRUSH_FIVE_Y_AXIS_SQUARE = 10;
public static final int EASEL_BRUSH_FIVE_Y_AXIS_OUTLINE_SQUARE = 11;

public static final int EASEL_BRUSH_SPLATTER = 12;
public static final int EASEL_BRUSH_SPLATTER_OUTLINE = 13;
public static final int EASEL_BRUSH_SPLATTER_SQUARE = 14;
public static final int EASEL_BRUSH_SPLATTER_OUTLINE_SQUARE = 15;
public static final int EASEL_BRUSH_GRAFFITI = 16;
public static final int EASEL_BRUSH_GRAFFITI_SQUARE = 17;
public static final int EASEL_BRUSH_FIVE_X_AXIS_MOTION = 18;
public static final int EASEL_BRUSH_FIVE_X_AXIS_MOTION_SQUARE = 19;

public static final int MAX_WIDTH = 360;
public static final int PALETTE_OFFSET = 60;
public static final int FONT_SIZE = 23;
public static final  int BIG_FONT_SIZE = 50;
String PHOTO_URL = "http://bit.do/easel";

PImage[] backgroundImage;
PImage[] thresholdImage;
int currentBackgroundImage;

Palette[] moods;
Paint p;

int currentOpacity;
int currentWidth;
int currentMood;
int currentBrush;
int currentScreenshot;



PFont text;
PFont bigText;
PImage qr;
boolean showBackgroundImage;
boolean showContours;

boolean movingBrush;



void setup() {
  fullScreen();
  rectMode(CORNER);
  File dir;
  File[]  files;
  dir = new File(sketchPath("data/images"));
  files = dir.listFiles();
  backgroundImage = new PImage[files.length-1];
  thresholdImage = new PImage[files.length-1];
  qr = loadImage("url_qr.png");

  for (int i = 0; i < files.length - 1; i++) {
    backgroundImage[i] = loadImage(files[i].getAbsolutePath());
    thresholdImage[i] = Threshold.apply(backgroundImage[i]);
  }
  text = createFont("rawe.ttf", FONT_SIZE);
  bigText = createFont("rawe.ttf", BIG_FONT_SIZE);
  setMoods();
  currentWidth = 50;
  currentOpacity = 100;
  currentMood = 0;
  currentBrush = 0;
  currentScreenshot = 0;
  movingBrush = false;

  fill(255);
  rect(0, 0, width, height);
  drawCurrentBrush();
}

void setMoods() {
  moods =  new Palette[14];

  Palette mood = new Palette(new PVector(width - MAX_WIDTH, height - MAX_WIDTH), 
    new PVector(width - MAX_WIDTH * 2 + PALETTE_OFFSET, height - (MAX_WIDTH * 2) - 75), //TOP
    new PVector(width - MAX_WIDTH * 3 + (PALETTE_OFFSET * 2), height - MAX_WIDTH), 
    new PVector(width - MAX_WIDTH * 4 + (PALETTE_OFFSET * 3), height - (MAX_WIDTH * 2) - 75), //TOP
    new PVector(width - MAX_WIDTH * 5 + (PALETTE_OFFSET * 4), height - MAX_WIDTH));


  mood.setResolution(MAX_WIDTH, MAX_WIDTH+75);
  mood.setColors(color(186, 145, 209), color(98, 134, 84), color(203, 255, 255), color(89, 154, 158), color(229, 205, 78));

  moods[0] = mood;

  mood = new Palette(new PVector(width - MAX_WIDTH, height - MAX_WIDTH), 
    new PVector(width - MAX_WIDTH * 2 + PALETTE_OFFSET, height - (MAX_WIDTH * 2) - 75), //TOP
    new PVector(width - MAX_WIDTH * 3 + (PALETTE_OFFSET * 2), height - MAX_WIDTH), 
    new PVector(width - MAX_WIDTH * 4 + (PALETTE_OFFSET * 3), height - (MAX_WIDTH * 2) - 75), //TOP
    new PVector(width - MAX_WIDTH * 5 + (PALETTE_OFFSET * 4), height - MAX_WIDTH));
  mood.setResolution(MAX_WIDTH, MAX_WIDTH+75);
  mood.setColors(color(112, 100, 140), color(0, 1, 13), color(64, 30, 1), color(38, 18, 1), color(115, 44, 2));
  moods[1] = mood;

  mood = new Palette(new PVector(width - MAX_WIDTH, height - MAX_WIDTH), 
    new PVector(width - MAX_WIDTH * 2 + PALETTE_OFFSET, height - (MAX_WIDTH * 2) - 75), //TOP
    new PVector(width - MAX_WIDTH * 3 + (PALETTE_OFFSET * 2), height - MAX_WIDTH), 
    new PVector(width - MAX_WIDTH * 4 + (PALETTE_OFFSET * 3), height - (MAX_WIDTH * 2) - 75), //TOP
    new PVector(width - MAX_WIDTH * 5 + (PALETTE_OFFSET * 4), height - MAX_WIDTH));
  mood.setResolution(MAX_WIDTH, MAX_WIDTH+75);
  mood.setColors(color(157, 140, 119), color(203, 180, 165), color(225, 210, 197), color(155, 137, 113), color(203, 186, 166));
  moods[2] = mood;

  mood = new Palette(new PVector(width - MAX_WIDTH, height - MAX_WIDTH), 
    new PVector(width - MAX_WIDTH * 2 + PALETTE_OFFSET, height - (MAX_WIDTH * 2) - 75), //TOP
    new PVector(width - MAX_WIDTH * 3 + (PALETTE_OFFSET * 2), height - MAX_WIDTH), 
    new PVector(width - MAX_WIDTH * 4 + (PALETTE_OFFSET * 3), height - (MAX_WIDTH * 2) - 75), //TOP
    new PVector(width - MAX_WIDTH * 5 + (PALETTE_OFFSET * 4), height - MAX_WIDTH));
  mood.setResolution(MAX_WIDTH, MAX_WIDTH+75);
  mood.setColors(color(148, 131, 115), color(178, 230, 181), color(225, 210, 197), color(144, 135, 174), color(129, 123, 148));
  moods[3] = mood;

  mood = new Palette(new PVector(width - MAX_WIDTH, height - MAX_WIDTH), 
    new PVector(width - MAX_WIDTH * 2 + PALETTE_OFFSET, height - (MAX_WIDTH * 2) - 75), //TOP
    new PVector(width - MAX_WIDTH * 3 + (PALETTE_OFFSET * 2), height - MAX_WIDTH), 
    new PVector(width - MAX_WIDTH * 4 + (PALETTE_OFFSET * 3), height - (MAX_WIDTH * 2) - 75), //TOP
    new PVector(width - MAX_WIDTH * 5 + (PALETTE_OFFSET * 4), height - MAX_WIDTH));
  mood.setResolution(MAX_WIDTH, MAX_WIDTH+75);
  mood.setColors(color(97, 91, 85), color(230, 178, 132), color(225, 210, 197), color(97, 75, 56), color(174, 162, 152));
  moods[4] = mood;

  mood = new Palette(new PVector(width - MAX_WIDTH, height - MAX_WIDTH), 
    new PVector(width - MAX_WIDTH * 2 + PALETTE_OFFSET, height - (MAX_WIDTH * 2) - 75), //TOP
    new PVector(width - MAX_WIDTH * 3 + (PALETTE_OFFSET * 2), height - MAX_WIDTH), 
    new PVector(width - MAX_WIDTH * 4 + (PALETTE_OFFSET * 3), height - (MAX_WIDTH * 2) - 75), //TOP
    new PVector(width - MAX_WIDTH * 5 + (PALETTE_OFFSET * 4), height - MAX_WIDTH));
  mood.setResolution(MAX_WIDTH, MAX_WIDTH+75);
  mood.setColors(color(148, 18, 77), color(230, 214, 75), color(225, 51, 129), color(22, 151, 174), color(26, 130, 148));
  moods[5] = mood;

  mood = new Palette(new PVector(width - MAX_WIDTH, height - MAX_WIDTH), 
    new PVector(width - MAX_WIDTH * 2 + PALETTE_OFFSET, height - (MAX_WIDTH * 2) - 75), //TOP
    new PVector(width - MAX_WIDTH * 3 + (PALETTE_OFFSET * 2), height - MAX_WIDTH), 
    new PVector(width - MAX_WIDTH * 4 + (PALETTE_OFFSET * 3), height - (MAX_WIDTH * 2) - 75), //TOP
    new PVector(width - MAX_WIDTH * 5 + (PALETTE_OFFSET * 4), height - MAX_WIDTH));
  mood.setResolution(MAX_WIDTH, MAX_WIDTH+75);
  mood.setColors(color(148, 18, 77), color(255, 83, 160), color(225, 51, 129), color(4, 148, 8), color(51, 225, 55));
  moods[6] = mood;

  mood = new Palette(new PVector(width - MAX_WIDTH, height - MAX_WIDTH), 
    new PVector(width - MAX_WIDTH * 2 + PALETTE_OFFSET, height - (MAX_WIDTH * 2) - 75), //TOP
    new PVector(width - MAX_WIDTH * 3 + (PALETTE_OFFSET * 2), height - MAX_WIDTH), 
    new PVector(width - MAX_WIDTH * 4 + (PALETTE_OFFSET * 3), height - (MAX_WIDTH * 2) - 75), //TOP
    new PVector(width - MAX_WIDTH * 5 + (PALETTE_OFFSET * 4), height - MAX_WIDTH));
  mood.setResolution(MAX_WIDTH, MAX_WIDTH+75);
  mood.setColors(color(174, 46, 22), color(123, 84, 77), color(225, 51, 129), color(146, 229, 109), color(123, 174, 22));
  moods[7] = mood;


  mood = new Palette(new PVector(width - MAX_WIDTH, height - MAX_WIDTH), 
    new PVector(width - MAX_WIDTH * 2 + PALETTE_OFFSET, height - (MAX_WIDTH * 2) - 75), //TOP
    new PVector(width - MAX_WIDTH * 3 + (PALETTE_OFFSET * 2), height - MAX_WIDTH), 
    new PVector(width - MAX_WIDTH * 4 + (PALETTE_OFFSET * 3), height - (MAX_WIDTH * 2) - 75), //TOP
    new PVector(width - MAX_WIDTH * 5 + (PALETTE_OFFSET * 4), height - MAX_WIDTH));
  mood.setResolution(MAX_WIDTH, MAX_WIDTH+75);
  mood.setColors(color(132, 34, 174), color(112, 85, 123), color(91, 66, 225), color(229, 205, 124), color(174, 128, 34));
  moods[8] = mood;

  mood = new Palette(new PVector(width - MAX_WIDTH, height - MAX_WIDTH), 
    new PVector(width - MAX_WIDTH * 2 + PALETTE_OFFSET, height - (MAX_WIDTH * 2) - 75), //TOP
    new PVector(width - MAX_WIDTH * 3 + (PALETTE_OFFSET * 2), height - MAX_WIDTH), 
    new PVector(width - MAX_WIDTH * 4 + (PALETTE_OFFSET * 3), height - (MAX_WIDTH * 2) - 75), //TOP
    new PVector(width - MAX_WIDTH * 5 + (PALETTE_OFFSET * 4), height - MAX_WIDTH));
  mood.setResolution(MAX_WIDTH, MAX_WIDTH+75);
  mood.setColors(color(48, 29, 148), color(125, 100, 255), color(91, 66, 225), color(148, 132, 14), color(225, 205, 66));
  moods[9] = mood;

  mood = new Palette(new PVector(width - MAX_WIDTH, height - MAX_WIDTH), 
    new PVector(width - MAX_WIDTH * 2 + PALETTE_OFFSET, height - (MAX_WIDTH * 2) - 75), //TOP
    new PVector(width - MAX_WIDTH * 3 + (PALETTE_OFFSET * 2), height - MAX_WIDTH), 
    new PVector(width - MAX_WIDTH * 4 + (PALETTE_OFFSET * 3), height - (MAX_WIDTH * 2) - 75), //TOP
    new PVector(width - MAX_WIDTH * 5 + (PALETTE_OFFSET * 4), height - MAX_WIDTH));
  mood.setResolution(MAX_WIDTH, MAX_WIDTH+75);
  mood.setColors(color(48, 29, 148), color(230, 150, 90), color(91, 66, 225), color(38, 174, 34), color(39, 148, 36));
  moods[10] = mood;

  mood = new Palette(new PVector(width - MAX_WIDTH, height - MAX_WIDTH), 
    new PVector(width - MAX_WIDTH * 2 + PALETTE_OFFSET, height - (MAX_WIDTH * 2) - 75), //TOP
    new PVector(width - MAX_WIDTH * 3 + (PALETTE_OFFSET * 2), height - MAX_WIDTH), 
    new PVector(width - MAX_WIDTH * 4 + (PALETTE_OFFSET * 3), height - (MAX_WIDTH * 2) - 75), //TOP
    new PVector(width - MAX_WIDTH * 5 + (PALETTE_OFFSET * 4), height - MAX_WIDTH));
  mood.setResolution(MAX_WIDTH, MAX_WIDTH+75);
  mood.setColors(color(73, 148, 148), color(230, 159, 209), color(133, 224, 225), color(174, 160, 85), color(148, 138, 80));
  moods[11] = mood;

  mood = new Palette(new PVector(width - MAX_WIDTH, height - MAX_WIDTH), 
    new PVector(width - MAX_WIDTH * 2 + PALETTE_OFFSET, height - (MAX_WIDTH * 2) - 75), //TOP
    new PVector(width - MAX_WIDTH * 3 + (PALETTE_OFFSET * 2), height - MAX_WIDTH), 
    new PVector(width - MAX_WIDTH * 4 + (PALETTE_OFFSET * 3), height - (MAX_WIDTH * 2) - 75), //TOP
    new PVector(width - MAX_WIDTH * 5 + (PALETTE_OFFSET * 4), height - MAX_WIDTH));
  mood.setResolution(MAX_WIDTH, MAX_WIDTH+75);
  mood.setColors(color(73, 148, 148), color(176, 254, 255), color(133, 224, 225), color(148, 92, 58), color(225, 167, 133));
  moods[12] = mood;

  mood = new Palette(new PVector(width - MAX_WIDTH, height - MAX_WIDTH), 
    new PVector(width - MAX_WIDTH * 2 + PALETTE_OFFSET, height - (MAX_WIDTH * 2) - 75), //TOP
    new PVector(width - MAX_WIDTH * 3 + (PALETTE_OFFSET * 2), height - MAX_WIDTH), 
    new PVector(width - MAX_WIDTH * 4 + (PALETTE_OFFSET * 3), height - (MAX_WIDTH * 2) - 75), //TOP
    new PVector(width - MAX_WIDTH * 5 + (PALETTE_OFFSET * 4), height - MAX_WIDTH));
  mood.setResolution(MAX_WIDTH, MAX_WIDTH+75);
  mood.setColors(color(85, 126, 174), color(23, 69, 123), color(133, 224, 225), color(229, 201, 192), color(174, 93, 85));
  moods[13] = mood;
}

void drawInterface() {
  rectMode(CORNER);
  moods[currentMood].draw();
  if(movingBrush) {
    drawCurrentBrush();
  }
  noStroke();
  fill(0);
  //top bar
  //50
  if (height > 2900) {
    rect(0, 2900, width, FONT_SIZE * 3 + 125);
    rect(0, 2900, width - MAX_WIDTH * 4 + (PALETTE_OFFSET * 3), FONT_SIZE * 3 + 250);
  } else {
    rect(0, height - MAX_WIDTH * 2.5, width, FONT_SIZE * 3 + 100);
    rect(0, height - MAX_WIDTH * 2.5, width - MAX_WIDTH * 4 + (PALETTE_OFFSET * 3), FONT_SIZE * 3 + 200);
  }
  //padding bar
  fill(255);
  textFont(bigText);
  float brushY = height - MAX_WIDTH * 2.2 + (FONT_SIZE * 2);
  switch (currentBrush) {
  case EASEL_BRUSH_STANDARD:
    text("CIRCLE", 20, brushY);
    break;
  case EASEL_BRUSH_STANDARD_SQUARE:
    text("SQUARE", 20, brushY);
    break;
  case EASEL_BRUSH_OUTLINE:
    text("CIRCLE OUTLINED", 20, brushY);
    break;
  case EASEL_BRUSH_FIVE_X_AXIS_OUTLINE:
    text("FIVE POINT HORIZONTAL OUTLINED CIRCLE", 20, brushY);
    break;
  case EASEL_BRUSH_FIVE_X_AXIS:
    text("FIVE POINT HORIZONTAL CIRCLE", 20, brushY);
    break;
  case EASEL_BRUSH_FIVE_Y_AXIS:
    text("FIVE POINT VERTICAL CIRCLE", 20, brushY);
    break;
  case EASEL_BRUSH_FIVE_Y_AXIS_OUTLINE:
    text("FIVE POINT VERTICAL OUTLINED CIRCLE", 20, brushY);
    break;

  case EASEL_BRUSH_SPLATTER:
    text("SPLATTER CIRCLE", 20, brushY);
    break;

  case EASEL_BRUSH_SPLATTER_OUTLINE:
    text("SPLATTER OUTLINED CIRCLE", 20, brushY);
    break;
  case EASEL_BRUSH_GRAFFITI:
    text("CIRCLE GRAFFITI", 20, brushY);
    break;
  case EASEL_BRUSH_FIVE_X_AXIS_MOTION:
    text("FIVE POINT MOVING CIRCLE", 20, brushY);
    break;
  case EASEL_BRUSH_OUTLINE_SQUARE:
    text("SQUARE OUTLINED", 20, brushY);
    break;
  case EASEL_BRUSH_FIVE_X_AXIS_OUTLINE_SQUARE:
    text("FIVE POINT HORIZONTAL OUTLINED SQUARE", 20, brushY);
    break;
  case EASEL_BRUSH_FIVE_X_AXIS_SQUARE:
    text("FIVE POINT HORIZONTAL SQUARE", 20, brushY);
    break;
  case EASEL_BRUSH_FIVE_Y_AXIS_SQUARE:
    text("FIVE POINT VERTICAL SQUARE", 20, brushY);
    break;
  case EASEL_BRUSH_FIVE_Y_AXIS_OUTLINE_SQUARE:
    text("FIVE POINT VERTICAL OUTLINED SQUARE", 20, brushY);
    break;

  case EASEL_BRUSH_SPLATTER_SQUARE:
    text("SPLATTER SQUARE", 20, brushY);
    break;

  case EASEL_BRUSH_SPLATTER_OUTLINE_SQUARE:
    text("SPLATTER OUTLINED SQUARE", 20, brushY);
    break;
  case EASEL_BRUSH_GRAFFITI_SQUARE:
    text("SQUARE GRAFFITI", 20,brushY);
    break;
  case EASEL_BRUSH_FIVE_X_AXIS_MOTION_SQUARE:
    text("FIVE POINT MOVING SQUARE", 20, brushY);
    break;


  default:
    break;
  }
}

void draw() {
  drawInterface();
  
}
void mousePressed() {
  if (moods[currentMood].didMakeSelection(mouseX, mouseY)) {
    drawCurrentBrush();
  }
}

void mouseDragged() {
  if (!moods[currentMood].didMakeSelection(mouseX, mouseY) && mouseY <= 2900) {

    //PAINT NO STORAGE
    p = new Paint(mouseX, mouseY);
    p.c = moods[currentMood].currentColor;    
    p.w = currentWidth;
    p.opacity = currentOpacity;

    switch (currentBrush) {
    case EASEL_BRUSH_OUTLINE:
      p.outline = true;
      p.square = false;
      p.draw();
      break;
    case EASEL_BRUSH_OUTLINE_SQUARE:
      p.outline = true;
      p.square = true;
      p.draw();
      break;

    case EASEL_BRUSH_STANDARD:
      p.outline = false;
      p.square = false;
      p.draw();
      break;
    case EASEL_BRUSH_STANDARD_SQUARE:
      p.outline = false;
      p.square = true;
      p.draw();
      break;

    case EASEL_BRUSH_FIVE_X_AXIS_OUTLINE:
      for (int i = -2; i < 3; i++) {
        p.outline = true;
        p.w = currentWidth/5;
        p.square = false;
        p.point = new PVector(mouseX + (i * p.w * 2), mouseY);
        p.draw();
      }
      break;
    case EASEL_BRUSH_FIVE_X_AXIS_OUTLINE_SQUARE:
      for (int i = -2; i < 3; i++) {
        p.outline = true;
        p.w = currentWidth / 5;
        p.point = new PVector(mouseX + (i * p.w * 2), mouseY);
        p.square = true;
        p.draw();
      }
      break;

    case EASEL_BRUSH_FIVE_X_AXIS:

      for (int i = -2; i < 3; i++) {
        p.outline = false;
        p.w = currentWidth/5;
        p.opacity = currentOpacity;
        p.point = new PVector(mouseX + (i * p.w * 2), mouseY);
        p.square = false;
        p.draw();
      }
      break;
    case EASEL_BRUSH_FIVE_X_AXIS_SQUARE:

      for (int i = -2; i < 3; i++) {
        p.outline = false;
        p.square = true;
        p.w = currentWidth / 5;
        p.point = new PVector(mouseX + (i * p.w * 2), mouseY);
        p.draw();
      }
      break;

    case EASEL_BRUSH_FIVE_X_AXIS_MOTION:

      for (int i = -2; i < 3; i++) {
        p.outline = true;
        p.w = currentWidth / 5;
        p.point = new PVector(mouseX + (sin(millis()) * (i * p.w)), mouseY + (cos(millis()) * (i * p.w)));
        p.square = false;
        p.draw();
      }
      break;

    case EASEL_BRUSH_FIVE_X_AXIS_MOTION_SQUARE:

      for (int i = -2; i < 3; i++) {
        p.outline = true;
        p.w = currentWidth / 5;
        p.point = new PVector(mouseX + (sin(millis()) * (i * p.w)), mouseY + (cos(millis()) * (i * p.w)));
        p.square = true;
        p.draw();
      }
      break;


    case EASEL_BRUSH_FIVE_Y_AXIS:
      for (int i = -2; i < 3; i++) {
        p.outline = false;
        p.w = currentWidth/5;
        p.point = new PVector(mouseX, mouseY + (i * p.w * 2));
        p.square = false;
        p.draw();
      }
      break;
    case EASEL_BRUSH_FIVE_Y_AXIS_SQUARE:
      for (int i = -2; i < 3; i++) {
        p.outline = false;
        p.w = currentWidth / 5;
        p.point = new PVector(mouseX, mouseY + (i * p.w * 2));
        p.square = true;
        p.draw();
      }
      break;

    case EASEL_BRUSH_FIVE_Y_AXIS_OUTLINE:
      for (int i = -2; i < 3; i++) {
        p.outline = true;
        p.w = currentWidth/5;
        p.point = new PVector(mouseX, mouseY + (i * p.w * 2));
        p.square = false;
        p.draw();
      }
      break;
    case EASEL_BRUSH_FIVE_Y_AXIS_OUTLINE_SQUARE:
      for (int i = -2; i < 3; i++) {
        p.outline = true;
        p.w = currentWidth / 5;
        p.point = new PVector(mouseX, mouseY + (i * p.w * 2));
        p.square = true;
        p.draw();
      }
      break;

    case EASEL_BRUSH_SPLATTER:
      for (int i = 0; i < random(10); i++) {
        p.outline = false;
        p.square = false;
        p.w = int(random(currentWidth*.2, currentWidth));
        p.opacity = int(random(currentOpacity + random(50), currentOpacity - random(50)));
        p.point = new PVector(mouseX + random((-MAX_WIDTH / 2) + currentWidth, MAX_WIDTH / 2 - currentWidth), mouseY + random((-MAX_WIDTH / 2) + currentWidth, MAX_WIDTH / 2 - currentWidth));
        p.draw();
      }
      break;
    case EASEL_BRUSH_SPLATTER_SQUARE:
      for (int i = 0; i < random(10); i++) {
        p.outline = false;
        p.square = true;
        p.w = int(random(currentWidth*.2, currentWidth));
        p.opacity = int(random(currentOpacity + random(50), currentOpacity - random(50)));
        p.point = new PVector(mouseX + random((-MAX_WIDTH / 2) + currentWidth, MAX_WIDTH / 2 - currentWidth), mouseY + random((-MAX_WIDTH / 2) + currentWidth, MAX_WIDTH / 2 - currentWidth));
        p.draw();
      }
      break;


    case EASEL_BRUSH_SPLATTER_OUTLINE:
      for (int i = 0; i < random(10); i++) {
        p.outline = true;
        p.square = false;
        p.w = int(random(currentWidth*.2, currentWidth));
        p.opacity = int(random(currentOpacity + random(50), currentOpacity - random(50)));
        p.point = new PVector(mouseX + random((-MAX_WIDTH / 2) + currentWidth, MAX_WIDTH / 2 - currentWidth), mouseY + random((-MAX_WIDTH / 2) + currentWidth, MAX_WIDTH / 2 - currentWidth));
        p.draw();
      }
      break;
    case EASEL_BRUSH_SPLATTER_OUTLINE_SQUARE:
      for (int i = 0; i < random(10); i++) {
        p.outline = true;
        p.square = true;
        p.w = int(random(currentWidth*.2, currentWidth));
        p.opacity = int(random(currentOpacity + random(50), currentOpacity - random(50)));
        p.point = new PVector(mouseX + random((-MAX_WIDTH / 2) + currentWidth, MAX_WIDTH / 2 - currentWidth), mouseY + random((-MAX_WIDTH / 2) + currentWidth, MAX_WIDTH / 2 - currentWidth));
        p.draw();
      }
      break;

    case EASEL_BRUSH_GRAFFITI:
      for (int i = 0; i < random(10); i++) {
        p.w = int(random(currentWidth*.1, currentWidth*.9));
        p.opacity = int(random(10, 200));
        p.outline = false;
        p.square = false;
        p.point = new PVector(mouseX + random(-currentWidth - p.w, random(currentWidth + p.w)), mouseY + random(-currentWidth - p.w, random(currentWidth + p.w)));
        p.draw();
      }
      break;
    case EASEL_BRUSH_GRAFFITI_SQUARE:
      for (int i = 0; i < random(10); i++) {
        p.w = int(random(currentWidth*.1, currentWidth*.9));
        p.opacity = int(random(10, 200));
        p.outline = false;
        p.square = true;
        p.point = new PVector(mouseX + random(-currentWidth - p.w, random(currentWidth + p.w)), mouseY + random(-currentWidth - p.w, random(currentWidth + p.w)));
        p.draw();
      }
      break;

    default:
      break;
    }
  }
}

void drawBackground() {
    fill(255);
    if (showBackgroundImage) {
      rect(0, 0, width, height-MAX_WIDTH);
      image(backgroundImage[currentBackgroundImage], 0, 0);
    }
    if (showContours) {
      rect(0, 0, width, height-MAX_WIDTH);
      image(thresholdImage[currentBackgroundImage], 0, 0);
    }
  
}

void keyPressed() {
  rectMode(CORNER);
  if (key == EASEL_BG_TOGGLE) {
    showBackgroundImage = true;
    showContours = false;
    drawBackground();
}

  if (key == EASEL_CONTOUR_TOGGLE) {
    showContours = true;
    showBackgroundImage = false;
    drawBackground();
}

  if (key == EASEL_BG_IMAGE_UP) {
    if (currentBackgroundImage < backgroundImage.length  - 1) {
      currentBackgroundImage++;
    } else {
      currentBackgroundImage = 0;
    }
    drawBackground();
  }


  if (key == EASEL_BG_IMAGE_DOWN) {
    if (currentBackgroundImage == 0) {
      currentBackgroundImage = backgroundImage.length - 1;
    } else {
      currentBackgroundImage--;
    }
    drawBackground();
}


  if (key == EASEL_WIDTH_UP) {
    if (currentWidth >= MAX_WIDTH/2 - 5) {
      currentWidth = MAX_WIDTH/2 - 5;
    } else {
      currentWidth+=5;
    }
  }

  if (key == EASEL_WIDTH_DOWN) {
    if (currentWidth <= 5) {
      currentWidth = 5;
    } else {
      currentWidth-=5;
    }
    drawCurrentBrush();
  }


  if (key == EASEL_OPACITY_UP) {
    if (currentOpacity >= 255) {
      currentOpacity = 255;
    } else {
      currentOpacity+=2;
    }
    drawCurrentBrush();
  }

  if (key == EASEL_OPACITY_DOWN) {
    if (currentOpacity <= 1) {
      currentOpacity = 1;
    } else {
      currentOpacity-=2;
    }
  }

  if (key == EASEL_MOOD_DOWN) {
    if (currentMood <= 0) {
      currentMood = moods.length - 1;
    } else {
      currentMood--;
    }
  }

  if (key == EASEL_MOOD_UP) {
    if (currentMood >= moods.length - 1) {
      currentMood = 0;
    } else {
      currentMood++;
    }
  }
  
 

  if (key == EASEL_BRUSH_DOWN) {
    if (currentBrush <= 0) {
      currentBrush = EASEL_BRUSH_FIVE_X_AXIS_MOTION_SQUARE;
    } else {
      currentBrush--;
    }
    checkForMovingBrush();
}

  if (key == EASEL_BRUSH_UP) {
    if (currentBrush >= EASEL_BRUSH_FIVE_X_AXIS_MOTION_SQUARE) {
      currentBrush = 0;
    } else {
      currentBrush++;
    }
    checkForMovingBrush();
  }
    if (key == EASEL_SCREENSHOT) {
      saveArt();
    }
    else {
      drawCurrentBrush();
    }
}

void checkForMovingBrush() {
     if(currentBrush == EASEL_BRUSH_SPLATTER || 
      currentBrush == EASEL_BRUSH_SPLATTER_OUTLINE ||
      currentBrush == EASEL_BRUSH_SPLATTER_SQUARE || 
      currentBrush == EASEL_BRUSH_SPLATTER_OUTLINE_SQUARE || 
      currentBrush == EASEL_BRUSH_GRAFFITI || 
      currentBrush == EASEL_BRUSH_GRAFFITI_SQUARE || 
      currentBrush == EASEL_BRUSH_FIVE_X_AXIS_MOTION || 
      currentBrush == EASEL_BRUSH_FIVE_X_AXIS_MOTION_SQUARE) {
      movingBrush = true;
  }
  else {
      movingBrush = false;
   }
 
}
void saveArt() {
  rectMode(CORNER);
  PImage screenshot = get(0, 0, width, 2900);
//  String g_drive = "C:/Drive/Easel/";
  String g_drive = "C:/Users/lowe/Google Drive/Easel/";
  screenshot.save(g_drive + "art-" + currentScreenshot + ".jpg");
  currentScreenshot++;

  fill(127);
  rect(0, height - MAX_WIDTH * 2, width - MAX_WIDTH * 5 + (PALETTE_OFFSET * 4), (MAX_WIDTH*2));
  rect(0, height - MAX_WIDTH * 2, width, MAX_WIDTH * 2);
  fill(255);
  textFont(text, 40);
  text("YOUR ART HAS BEEN SAVED!", 20, height - MAX_WIDTH * 2 + (FONT_SIZE * 10));
  textFont(text);
  text("Please visit " + PHOTO_URL + " to retrieve", 20, height - MAX_WIDTH * 2 + (FONT_SIZE * 12));
  text("it or scan this QR code.", 20, height - MAX_WIDTH * 2 + (FONT_SIZE * 13.1));

  image(qr, MAX_WIDTH/2 - 50, height - MAX_WIDTH);
}

void drawCurrentBrush() {
  fill(255);
  noStroke();
  float belowPaddingY;
  int x;
  if (height > 2900) {
    x = MAX_WIDTH/2;
    belowPaddingY = 2900 + FONT_SIZE * 3 + 250; //size of black padding
//    belowPaddingY = height - MAX_WIDTH * 3 - 70 + (FONT_SIZE * 3 + 500); 

 // top closest swatch
//    new PVector(, ), //TOP
  
// closest swatch color  
  //    new PVector(, height - MAX_WIDTH));
    rect(0, belowPaddingY, width - MAX_WIDTH * 4 + (PALETTE_OFFSET * 3), height - (MAX_WIDTH * 2) - 75);
    rect(0, belowPaddingY + height - (MAX_WIDTH * 2) - 75, width - MAX_WIDTH * 5 + (PALETTE_OFFSET * 4), height - belowPaddingY + height - (MAX_WIDTH * 2) - 75);
//    rect(0, belowPaddingY, MAX_WIDTH*3, height - belowPaddingY); //height
  } else {
    x = MAX_WIDTH;
    belowPaddingY = height - MAX_WIDTH * 3 - 70 + (FONT_SIZE * 3 + 500); 
    rect(0, belowPaddingY, MAX_WIDTH*3 + PALETTE_OFFSET, height - belowPaddingY); //height
  }

  //below padding

  int y = height - MAX_WIDTH;
  p = new Paint(x, y);
  p.c = moods[currentMood].currentColor;
  p.w = currentWidth;
  p.opacity = currentOpacity;

  switch (currentBrush) {
  case EASEL_BRUSH_STANDARD:
    p.outline = false;
    p.square = false;
    p.draw();
    break;
  case EASEL_BRUSH_STANDARD_SQUARE:
    p.outline = false;
    p.square = true;
    p.draw();
    break;
  case EASEL_BRUSH_OUTLINE:
    p.outline = true;
    p.square = false;
    p.draw();
    break;
  case EASEL_BRUSH_FIVE_X_AXIS_OUTLINE:
    for (int i = -2; i < 3; i++) {
      p.outline = true;
      p.square = false;
      p.w = currentWidth / 5;
      p.point = new PVector(x + (i * p.w * 2), y);
      p.draw();
    }
    break;
  case EASEL_BRUSH_FIVE_X_AXIS:
    for (int i = -2; i < 3; i++) {
      p.square = false;
      p.w = currentWidth / 5;      
      p.point = new PVector(x + (i * p.w * 2), y);
      p.draw();
    }
    break;
  case EASEL_BRUSH_FIVE_Y_AXIS:
    for (int i = -2; i < 3; i++) {
      p.outline = false;
      p.square = false;
      p.w = currentWidth / 5;      
      p.point = new PVector(x, y + (i * p.w * 2));
      p.draw();
    }
    break;
  case EASEL_BRUSH_FIVE_Y_AXIS_OUTLINE:
    for (int i = -2; i < 3; i++) {
      p.outline = true;
      p.w = currentWidth / 5;
      p.square = false;
      p.point = new PVector(x, y  + (i * p.w * 2));
      p.draw();
    }
    break;

  case EASEL_BRUSH_SPLATTER:
    for (int i = 0; i < random(10); i++) {
      p.outline = false;
      p.square = false;
      p.w = int(random(currentWidth*.2, currentWidth));
      p.opacity = int(currentOpacity + random(50) - random(50));
      p.point = new PVector(x + random((-MAX_WIDTH / 2) + currentWidth, MAX_WIDTH / 2 - currentWidth), y + random((-MAX_WIDTH / 2) + currentWidth, MAX_WIDTH / 2 - currentWidth));
      p.draw();
    }
    break;

  case EASEL_BRUSH_SPLATTER_OUTLINE:
    for (int i = 0; i < random(10); i++) {
      p.outline = true;
      p.w = int(random(currentWidth*.2, currentWidth));
      p.square = false;
      p.opacity = int(random(currentOpacity + random(50), currentOpacity - random(50)));
      p.point = new PVector(x + random((-MAX_WIDTH / 2) + currentWidth, MAX_WIDTH / 2 - currentWidth), y + random((-MAX_WIDTH / 2) + currentWidth, MAX_WIDTH / 2 - currentWidth));
      p.draw();
    }
    break;
  case EASEL_BRUSH_GRAFFITI:
    for (int i = 0; i < random(10); i++) {
      p.outline = false;
      p.w = int(random(currentWidth*.1, currentWidth*.9));
      p.opacity = int(random(10, 200));
      p.point = new PVector(x + random(-currentWidth - p.w, random(currentWidth + p.w)), y + random(-currentWidth - p.w, random(currentWidth + p.w)));
      p.square = false;
      p.draw();
    }
    break;

  case EASEL_BRUSH_FIVE_X_AXIS_MOTION:
    for (int i = -2; i < 3; i++) {
      p.square = false;
      p.w = currentWidth / 5;
      p.outline = true;
      p.point = new PVector(x + (sin(millis() * (i * p.w))), y + (cos(millis()) * (i * p.w)));
      p.draw();
    }
    break;

  case EASEL_BRUSH_OUTLINE_SQUARE:
    p.outline = true;
    p.square = true;
    p.draw();
    break;

  case EASEL_BRUSH_FIVE_X_AXIS_OUTLINE_SQUARE:

    for (int i = -2; i < 3; i++) {
      p.outline = true;
      p.square = true;
      p.w = currentWidth / 5;
      p.opacity = currentOpacity;
      p.point = new PVector(x + (i * p.w * 2), y);
      p.draw();
    }
    break;
  case EASEL_BRUSH_FIVE_X_AXIS_SQUARE:
    for (int i = -2; i < 3; i++) {
      p.square = true;
      p.outline = false;
      p.w = currentWidth / 5;
      p.point = new PVector(x + (i * p.w * 2), y);
      p.draw();
    }
    break;
  case EASEL_BRUSH_FIVE_Y_AXIS_SQUARE:

    for (int i = -2; i < 3; i++) {
      p.outline = false;
      p.square = true;
      p.w = currentWidth / 5;
      p.point = new PVector(x, y + (i * p.w * 2));
      p.draw();
    }
    break;
  case EASEL_BRUSH_FIVE_Y_AXIS_OUTLINE_SQUARE:

    for (int i = -2; i < 3; i++) {
      p.outline = true;
      p.square = true;
      p.w = currentWidth / 5;
      p.point = new PVector(x, y + (i * p.w * 2));
      p.draw();
    }
    break;

  case EASEL_BRUSH_SPLATTER_SQUARE:

    for (int i = 0; i < random(10); i++) {
      p.outline = false;
      p.square = true;
      p.w = int(random(currentWidth*.2, currentWidth));
      p.opacity = int(random(currentOpacity + random(50), currentOpacity - random(50)));
      p.point = new PVector(x + random((-MAX_WIDTH / 2) + currentWidth, MAX_WIDTH / 2 - currentWidth), y + random((-MAX_WIDTH / 2) + currentWidth, MAX_WIDTH / 2 - currentWidth));
      p.draw();
    }
    break;

  case EASEL_BRUSH_SPLATTER_OUTLINE_SQUARE:

    for (int i = 0; i < random(10); i++) {
      p.outline = true;
      p.square = true;
      p.w = int(random(currentWidth*.2, currentWidth));
      p.opacity = int(random(currentOpacity + random(50), currentOpacity - random(50)));
      p.point = new PVector(x + random((-MAX_WIDTH / 2) + currentWidth, MAX_WIDTH / 2 - currentWidth), y + random((-MAX_WIDTH / 2) + currentWidth, MAX_WIDTH / 2 - currentWidth));
      p.draw();
    }
    break;
  case EASEL_BRUSH_GRAFFITI_SQUARE:
    for (int i = 0; i < random(10); i++) {
      p.outline = false;
      p.square = true;
      p.w = int(random(currentWidth*.1, currentWidth*.9));
      p.opacity = int(random(10, 200));
      p.point = new PVector(x + random(-currentWidth - p.w, random(currentWidth + p.w)), y + random(-currentWidth - p.w, random(currentWidth + p.w)));
      p.draw();
    }
    break;
  case EASEL_BRUSH_FIVE_X_AXIS_MOTION_SQUARE:
    for (int i = -2; i < 3; i++) {
      p.outline = true;
      p.square = true;
      p.w = currentWidth / 5;
      p.point = new PVector(x + (sin(millis()) * (i * p.w)), y + (cos(millis()) * (i * p.w)));
      p.draw();
    }
    break;


  default:
    break;
  }
}
