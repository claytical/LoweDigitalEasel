class Palette { 
  PVector[] positions;
  color[] colors;
  color currentColor;
  String title;
  int selected;
  int y;
  int w;
  int h;

  Palette(PVector p1, PVector p2, PVector p3, PVector p4, PVector p5) {
    positions = new PVector[5];
    positions[0] = p1;
    positions[1] = p2;
    positions[2] = p3;
    positions[3] = p4;
    positions[4] = p5;
  }
  
  void draw() {
    for (int i = 0; i < colors.length - 1; i++) {
      noStroke();
      fill(255);      
      rect(positions[i].x, positions[i].y, w, h);
      fill(colors[i]);
      rect(positions[i].x, positions[i].y, w, h);
    }
  }

  void setResolution(int _w, int _h) {
    w = _w;
    h = _h;
  }
  
  void setColors(color c1, color c2, color c3, color c4, color c5) {
    colors = new color[5];
    colors[0] = c1;
    colors[1] = c2;
    colors[2] = c3;
    colors[3] = c4;
    colors[4] = c5;
  }
  
  boolean didMakeSelection(int touchX, int touchY) {
    for (int i = 0; i < positions.length; i++) {
      if(touchX >= positions[i].x && touchX <= positions[i].x + w && touchY >= positions[i].y && touchY <= positions[i].y + h) {
        currentColor = colors[i];
        return true;
      }
     }
    
      return false;  
  }
    
  

} 
