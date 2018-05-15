class Paint { 
  PVector point;
  color c;
  int w;
  int opacity;
  boolean outline;
  boolean square;
  
  Paint (float x, float y) {  
    point = new PVector(x,y);
  } 
  void draw() {
    strokeWeight(3);
    if(outline) {
      stroke(c, opacity);
      noFill();
  }
    else {
      noStroke();
      fill(c, opacity);  
  }
    if(square) {
      rectMode(CENTER);
      rect(point.x,point.y,w,w);
    }
    else {
     ellipse(point.x,point.y,w,w); 
    }
  }
} 
