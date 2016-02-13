    int hourDiff;
    int minDiff;
    int secDiff;


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

  public void display12Hands(int hour, int minute, int second, int radius) {

    // Origin of the clock
    float centerX = width/2;
    float centerY = height/2;

    // coorelates time (seconds, minutes, hours) to radians
    // Subtract 1/2 PI so that 12 pm starts at 90 degrees instead of at 0 degrees
    float sec = map(second(), 0, 60, 0, TWO_PI) - HALF_PI;
    float min = map(minute()+ minDiff + norm(second(), 0, 60), 0, 60, 0, TWO_PI) - HALF_PI;
    float hou = map(hour()  + hourDiff + norm(minute(), 0, 60), 0, 24, 0, TWO_PI*2) - HALF_PI;

    // The corresponding radius of each hand
    float secR = radius * .4;
    float minR = radius * .3;
    float hourR = radius * .2;

  //(x starts, y starts, x end, y end)
    stroke(0);
    strokeWeight(4);
    line(centerX, centerY, centerX + cos(sec) * secR, centerY + sin(sec) * secR);

    strokeWeight(6);
    line(centerX, centerY, centerX + cos(min) * minR, centerY + sin(min) * minR);
    strokeWeight(10);
    line(centerX,centerY, centerX + cos(hou) * hourR, centerY + sin(hou) * hourR);

  }

  public void display24Hands(int hour, int minute, int second, int radius) {
  /*
    // Origin of the clock
    float centerX = width/2;
    float centerY = height/2+ 10;

    float secR = radius * .4;
    float minR = radius * .3;
    float hourR = radius * .2;


    // coorelates time (seconds, minutes, hours) to radians
    // Subtract 1/2 PI so that 12 pm starts at 90 degrees instead of at 0 degrees
    float sec = map(second(), 0, 60, 0, TWO_PI) - HALF_PI;
    float min = map(minute()  + norm(second(), 0, 60), 0, 60, 0, TWO_PI) - HALF_PI;
    float hou = map(hour()  + norm(minute(), 0, 60), 0, 24, 0, TWO_PI) - HALF_PI;

   */

  }

  public void calcDiff() {

    int add12 = 0;

    if (!mainMenu.getTimeOfDay()) {
      add12 = 12;
    }
    
    //postive return
    if (hour() < mainMenu.getHour())
    {
        hourDiff = mainMenu.getHour() + add12 - hour();
  
       
    }
    //Negative return
    else if (hour() >= mainMenu.getHour())
    {  
        hourDiff = mainMenu.getHour() + add12 - hour();
 
       
    }
    
    
    //positive return
    if ( minute() < mainMenu.getMinute())
    {
      minDiff = mainMenu.getMinute() - minute();
      
    }
    //negative return
    else if (minute() >= mainMenu.getMinute())
    {
      minDiff = mainMenu.getMinute()  - minute();
      
    }
    
   
   
   
       secDiff = abs((mainMenu.getSecond() - second()));
    

  }

}