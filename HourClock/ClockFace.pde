// The time difference between the current and user requested time (12 & 24 mode)
// I made these global because I didn't have a better solution at the time
int hourDiff12;
int minDiff12;
int secDiff12;

int hourDiff24;
int minDiff24;
int secDiff24;

class ClockFace {
  // ---data members---

  // related to clock
  int m_xpos;
  int m_ypos;
  int m_radius;

  // default constructor
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

  public void display12Hands(int radius) {

    // Origin of the clock
    float centerX = width/2;
    float centerY = height/2;

    // coorelates time (seconds, minutes, hours) to radians)
    // Subtract 1/2 PI so that 12 pm starts at 90 degrees instead of at 0 degrees (3 pm)
    // Multiply 2PI in (hourToradians) by 2 because the clock makes two rounds.
    float sTr = map(second() + secDiff12, 0, 60, 0, TWO_PI) - HALF_PI;
    float mTr = map(minute()+ minDiff12 + norm(second(), 0, 60), 0, 60, 0, TWO_PI) - HALF_PI;
    float hTr = map(hour() + hourDiff12 + norm(minute()+ minDiff12 , 0, 60), 0, 24, 0, TWO_PI*2) - HALF_PI;

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
    float centerY = height/2;

    // The corresponding radius of each hand
    float sRad = radius * .4;
    float mRad = radius * .3;
    float hRad = radius * .2;


    // coorelates time (seconds, minutes, hours) to radians)
    // Subtract 1/2 PI so that 12 pm starts at 90 degrees instead of at 0 degrees (3 pm)
    float sTr = map(second() + secDiff24, 0, 60, 0, TWO_PI) - HALF_PI;
    float mTr = map(minute() + minDiff24  + norm(second(), 0, 60), 0, 60, 0, TWO_PI) - HALF_PI;
    float hTr = map(hour() + hourDiff24 + norm(minute() + minDiff24, 0, 60), 0, 24, 0, TWO_PI) - HALF_PI;

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
// Then, we calcualte the difference (from user requested time) and add/subtract.

  public void calcDiff12() {
    // If after 12 pm, clock is treated as in 24 hour mode
    int add12 = 0;
    if (!mainMenu.getTimeOfDay()){
      add12 = 12;
    }

    // Positive difference to correct the clock (hour)
    if (hour() < mainMenu.getHour()){
        hourDiff12 = mainMenu.getHour() - hour() + add12;
    }

    //Negative difference to correct the clock (hour)
    else if (hour() >= mainMenu.getHour()){
        hourDiff12 = mainMenu.getHour() - hour() + add12;
    }

    //Positive difference to correct the clock (minute)
    if (minute() < mainMenu.getMinute()){
      minDiff12 = mainMenu.getMinute() - minute();
    }

    //Negative difference to correct the clock (minute)
    else if (minute() >= mainMenu.getMinute()){
      minDiff12 = mainMenu.getMinute()  - minute();
    }

    //Positive difference to correct the clock (second)
    if (second() < mainMenu.getSecond()){
       secDiff12 = mainMenu.getSecond() - second();
    }

    //Negative difference to correct the clock (second)
    else if (second() >= mainMenu.getSecond()) {
       secDiff12 = mainMenu.getSecond() - second();
    }

  }

  public void calcDiff24()
  {
    // Positive difference to correct the clock (hour)
    if (hour() < mainMenu.getHour()){
        hourDiff24 = mainMenu.getHour() - hour();
    }

    //Negative difference to correct the clock (hour)
    else if (hour() >= mainMenu.getHour()){
        hourDiff24 = mainMenu.getHour()  - hour();
    }

    // Positive difference to correct the clock (minute)
    if ( minute() < mainMenu.getMinute()){
      minDiff24 = mainMenu.getMinute() - minute();
    }

    //Negative difference to correct the clock (minute)
    else if (minute() >= mainMenu.getMinute()){
      minDiff24 = mainMenu.getMinute()  - minute();
    }

    // Positive difference to correct the clock (second)
    if (second() < mainMenu.getSecond()){
       secDiff24 = mainMenu.getSecond() - second();
    }

    //Negative difference to correct the clock (second)
    else if (second() >= mainMenu.getSecond()){
       secDiff24 = mainMenu.getSecond() - second();
    }

  }



}
