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
  
  public void display12Hour(int xpos, int ypos, int radius) {
    // clock shape
    ellipse(xpos, ypos, radius, radius);
    // numbers
  }
  
  public void display24Hour(int xpos, int ypos, int radius) {
    // clock shape
    ellipse(xpos, ypos, radius, radius);
    // numbers
  }
  
  public void displayHands() {
  }
  
}