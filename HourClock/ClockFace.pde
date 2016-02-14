// The time difference between the current and user requested time (12 & 24 mode)
// I made these global because I didn't have a better solution at the time
int hourDiff;
int minDiff;
int secDiff;

class ClockFace {
  // ---data members---

  // related to clock
  int m_xpos;
  int m_ypos;
  int m_radius;

  // default constructor
  ClockFace(){


  }

  public void display12Hour(int xpos, int ypos, int radius) {
    // display numbers

    // load picture with 1-12 clockface
     PImage hands12;
     hands12 = loadImage("hands12.png");

     // resize photo to size of clock and move
     // to same location as clock
     hands12.resize(radius, radius);
     image(hands12, 250, 60);
    
  }

  public void display24Hour(int xpos, int ypos, int radius) {
    // numbers
    // load picture with 1-24 clockface
    PImage hands24;
    hands24 = loadImage("hands24.png");

    // resize photo to size of clock and move
    // to same location as clock
    hands24.resize(radius, radius);
    image(hands24, 250, 60);

  }

  public void display12Hands(int radius) {

    // Origin of the clock
    float centerX = width/2;
    float centerY = height/2 - 43;

    // coorelates time (seconds, minutes, hours) to radians)
    // Subtract 1/2 PI so that 12 pm starts at 90 degrees instead of at 0 degrees (3 pm)
    // Multiply 2PI in (hourToradians) by 2 because the clock makes two rounds.
    float sTr = map(second() + secDiff, 0, 60, 0, TWO_PI) - HALF_PI;
    float mTr = map(minute()+ minDiff + norm(second(), 0, 60), 0, 60, 0, TWO_PI) - HALF_PI;
    float hTr = map(hour() + hourDiff + norm(minute()+ minDiff , 0, 60), 0, 24, 0, TWO_PI*2) - HALF_PI;

    // The corresponding radius of each hand
    float sRad = radius * .4;
    float mRad = radius * .3;
    float hRad = radius * .2;

    // Draws the hand (and its thickness) for each time component
    stroke(0); // color of hands is black

    strokeWeight(4); //thickness of second hand
    line(centerX, centerY, centerX + cos(sTr) * sRad, centerY + sin(sTr) * sRad);

    strokeWeight(6); //thickness of minute hand
    line(centerX, centerY, centerX + cos(mTr) * mRad, centerY + sin(mTr) * mRad);

    strokeWeight(10); //thickness of hour hand
    line(centerX,centerY, centerX + cos(hTr) * hRad, centerY + sin(hTr) * hRad);

  }

  public void display24Hands(int radius) {

    // Origin of the clock
    float centerX = width/2;
    float centerY = height/2 - 43;

    // The corresponding radius of each hand
    float sRad = radius * .4;
    float mRad = radius * .3;
    float hRad = radius * .2;


    // Relates time (seconds, minutes, hours) to radians)
    // Subtract 1/2 PI so that 12 pm starts at 90 degrees instead of at 0 degrees (3 pm)
    float sTr = map(second() + secDiff, 0, 60, 0, TWO_PI) - HALF_PI;
    float mTr = map(minute() + minDiff  + norm(second(), 0, 60), 0, 60, 0, TWO_PI) - HALF_PI;
    float hTr = map(hour() + hourDiff + norm(minute() + minDiff, 0, 60), 0, 24, 0, TWO_PI) - HALF_PI;

    // Draws the hand (and its thickness) for each time component
    stroke(0);

    strokeWeight(4); //thickness of second hand
    line(centerX, centerY, centerX + cos(sTr) * sRad, centerY + sin(sTr) * sRad);

    strokeWeight(6); //thickness of minute hand
    line(centerX, centerY, centerX + cos(mTr) * mRad, centerY + sin(mTr) * mRad);

    strokeWeight(10); //thickness of hour hand
    line(centerX,centerY, centerX + cos(hTr) * hRad, centerY + sin(hTr) * hRad);

  }


// To change the time on the clock, we are using the current time as the starting point.
// Then, we calculate the difference (from user requested time) and add/subtract.
  public void calcDiff() {
    // If after 12 pm, clock is treated as in 24 hour mode
    int add12 = 0;

    if (!mainMenu.getTimeOfDay() && mainMenu.getView()){
      add12 = 12;
    }

    hourDiff = mainMenu.getHour() - hour() + add12;
    minDiff = mainMenu.getMinute() - minute();
    secDiff = mainMenu.getSecond() - second();
  }
  
  public void displayAMPM(int radius) {
    // load am and pm photos
    PImage am;
    am = loadImage("AM.png");
    PImage pm;
    pm = loadImage("PM.png");
    
    if(mainMenu.getTimeOfDay()) {
      am.resize(48, 34);
      image(am, radius + 70, radius - 135);
    }
    else {
      pm.resize(48, 34);
      image(pm, radius + 70, radius - 135);
    }
  }     
}