class ClockFace { 
  // ---data members---
  
  // related to clock
  int m_xpos;
  int m_ypos;
  int m_radius;
  
  // related to hands/ticking
  float hour;
  float minute;
  float second;
  
  // one constructor 
  ClockFace(){
  }
  
  public void displayClock(int xpos, int ypox, int radius) {
    // clock shape
    noStroke();
    ellipse(xpos, ypox, radius, radius);
  }
  public void display12Hour(int xpos, int ypos, int radius) {
    // display numbers
    
    // load picture with 1-12 clockface
     PImage hands12;
     hands12 = loadImage("hands12.png");
     
     // resize photo to size of clock and move
     // to same location as clock    
     hands12.resize(radius, radius);
    image(hands12, xpos - (.5*radius), ypos - (.5*radius));
     //translate(xpos, ypos);
  }
  
  public void display24Hour(int xpos, int ypos, int radius) {
    // numbers
    // load picture with 1-24 clockface
    PImage hands24;
    hands24 = loadImage("hands24.png");
   
    // resize photo to size of clock and move
    // to same location as clock    
    hands24.resize(radius, radius);
    image(hands24, xpos - (.5*radius), ypos - (.5*radius));
   
  }
  
  public void display12Hands(int hour, int minute, int second, int radius) {
    // define angles for hands
    // display hour hand
    // display minute hand
    // display second hand
  }
  
  public void display24Hands(int hour, int minute, int second, int radius) {
    // define angles for hands
    // display hour hand
    // display minute hand
    // display second hand
  }
  
 
}