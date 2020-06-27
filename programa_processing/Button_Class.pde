//Button classes

class Button {
  String label;
  float x;    // top left corner x position
  float y;    // top left corner y position
  float w;    // width of button
  float h;    // height of button
  int rf;
  int gf;
  int bf;
  int s;
  
  Button(String labelB, float xpos, float ypos, float widthB, float heightB, int green_fill, int red_fill, int blue_fill, int number_stroke) {
    label = labelB;
    x = xpos;
    y = ypos;
    w = widthB;
    h = heightB;
    rf = red_fill;
    gf = green_fill;
    bf = blue_fill;
    s = number_stroke;
  }

  
  void Draw() {
    fill(rf,gf,bf);
    strokeWeight(1);
    stroke(s);
    rect(x, y, w, h, 10);
    textAlign(CENTER, CENTER);
    fill(20);
    textSize(25);
    text(label, x + (w / 2), y + (h / 2));
  }
  
  boolean MouseIsOver() {
    if (mouseX > x && mouseX < (x + w) && mouseY > y && mouseY < (y + h)) {
      return true;
    }
    return false;
  }
}

class Button_2 {
  String label;
  float x;    // top left corner x position
  float y;    // top left corner y position
  float w;    // width of button
  float h;    // height of button
  int rf;
  int gf;
  int bf;
  int s;
  
  Button_2(String labelB, float xpos, float ypos, float widthB, float heightB, int green_fill, int red_fill, int blue_fill, int number_stroke) {
    label = labelB;
    x = xpos;
    y = ypos;
    w = widthB;
    h = heightB;
    rf = red_fill;
    gf = green_fill;
    bf = blue_fill;
    s = number_stroke;
  }

  
  void Draw() {
    fill(rf,gf,bf);
    strokeWeight(2);
    if (s>0){
      stroke(0,0,s);
    }
    else {
      noStroke();
    }
    rect(x, y, w, h, 0);
    textAlign(CENTER, CENTER);
    fill(20);
    text(label, x + (w / 2), y + (h / 2));
  }
  
  boolean MouseIsOver() {
    if (mouseX > x && mouseX < (x + w) && mouseY > y && mouseY < (y + h)) {
      return true;
    }
    return false;
  }
}
