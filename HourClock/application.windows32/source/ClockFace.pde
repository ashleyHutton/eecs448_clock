
int hourDiff;
int minDiff;
int secDiff;

/** ClockFace controls the display of clock faces and hands, as well as the clock geometry/ticking
*
*
* @author Ashley Hutton, Hannah Johnson, Rabel Marte
*/
public class ClockFace {
  /** ---data members--- */

  /** related to clock */
  int m_xpos;
  int m_ypos;
  int m_radius;

  /** 
    @pre: none
    @post: none
    @return: none
  */
  ClockFace(){


  }

  /** 
    @pre: valid integers called xpos, ypox, radius, and valid enumerated type called cDesigns
    @post: displays valid 12 hour clock face
    @return: none
  */
  public void display12Hour(int xpos, int ypos, int radius, clockDesigns cDesigns) {

    /** load picture with 1-12 clockface */
     PImage hands12;
     hands12 = loadImage("hands12.png");
     
     /** check which face the user desires, load image accordingly */
     if(cDesigns == clockDesigns.BLACK) { hands12 = loadImage("hands12.png"); }
     else if(cDesigns == clockDesigns.GREEN) { hands12 = loadImage("hands12-green.png"); }
     else if(cDesigns == clockDesigns.BLUE) { hands12 = loadImage("hands12-blue.png"); }
     else if(cDesigns == clockDesigns.PINK) { hands12 = loadImage("hands12-pink.png"); }
     else if(cDesigns == clockDesigns.PIZZA) { hands12 = loadImage("hands12-pizza.png"); }
     

     /** resize photo to size of clock and move
     to same location as clock */
     hands12.resize(radius, radius);
     image(hands12, 250, 60);
    
  }

  /** 
    @pre: valid integers called xpos, ypox, radius, and valid enumerated type called cDesigns
    @post: displays valid 24 hour clock face
    @return: none
  */
  public void display24Hour(int xpos, int ypos, int radius, clockDesigns cDesigns) {
    /** load picture with 1-24 clockface */
    PImage hands24;
    hands24 = loadImage("hands24.png");
    
     /** check which face the user desires, load image accordingly */
     if(cDesigns == clockDesigns.BLACK) { hands24 = loadImage("hands24.png"); }
     else if(cDesigns == clockDesigns.GREEN) { hands24 = loadImage("hands24-green.png"); }
     else if(cDesigns == clockDesigns.BLUE) { hands24 = loadImage("hands24-blue.png"); }
     else if(cDesigns == clockDesigns.PINK) { hands24 = loadImage("hands24-pink.png"); }
     else if(cDesigns == clockDesigns.PIZZA) { hands24 = loadImage("hands24-pizza.png"); }

    /** resize photo to size of clock and move
    to same location as clock */
    hands24.resize(radius, radius);
    image(hands24, 250, 60);

  }

  /** 
    @pre: valid int called radius and valid enumerated type called cDesigns
    @post: displays the correct hands for the 12 hour clock
    @return: none
  */
  public void display12Hands(int radius, clockDesigns cDesigns) {

    /** Origin of the clock */
    float centerX = width/2;
    float centerY = height/2 - 43;

    /** coorelates time (seconds, minutes, hours) to radians)
    Subtract 1/2 PI so that 12 pm starts at 90 degrees instead of at 0 degrees (3 pm)
    Multiply 2PI in (hourToradians) by 2 because the clock makes two rounds. */
    float sTr = map(second() + secDiff, 0, 60, 0, TWO_PI) - HALF_PI;
    float mTr = map(minute()+ minDiff + norm(second(), 0, 60), 0, 60, 0, TWO_PI) - HALF_PI;
    float hTr = map(hour() + hourDiff + norm(minute()+ minDiff , 0, 60), 0, 24, 0, TWO_PI*2) - HALF_PI;

    /** Set corresponding radius of each hand */
    float sRad = radius * .4;
    float mRad = radius * .3;
    float hRad = radius * .2;

    /** Draws the hand (and its thickness) for each time component */
    stroke(0); /** color of hands is black */
    
     //** check which face the user desires, load image accordingly */
     if(cDesigns == clockDesigns.BLACK) { stroke(0); }
     else if(cDesigns == clockDesigns.GREEN) { stroke(27, 140, 41); }
     else if(cDesigns == clockDesigns.BLUE) { stroke(67, 96, 221); }
     else if(cDesigns == clockDesigns.PINK) { stroke(221, 67, 154); }
     else if(cDesigns == clockDesigns.PIZZA) { stroke (0); }

    strokeWeight(4); /**thickness of second hand */
    line(centerX, centerY, centerX + cos(sTr) * sRad, centerY + sin(sTr) * sRad);

    strokeWeight(6); /**thickness of minute hand */
    line(centerX, centerY, centerX + cos(mTr) * mRad, centerY + sin(mTr) * mRad);

    strokeWeight(10); /**thickness of hour hand */
    line(centerX,centerY, centerX + cos(hTr) * hRad, centerY + sin(hTr) * hRad);

  }

  /** 
    @pre: valid int called radius and valid enumerated type called cDesigns
    @post: displays the correct hands for the 24 hour clock
    @return: none
  */
  public void display24Hands(int radius, clockDesigns cDesigns) {

    /** Origin of the clock */
    float centerX = width/2;
    float centerY = height/2 - 43;

    /** The corresponding radius of each hand */
    float sRad = radius * .4;
    float mRad = radius * .3;
    float hRad = radius * .2;


    /**Relates time (seconds, minutes, hours) to radians)
    Subtract 1/2 PI so that 12 pm starts at 90 degrees instead of at 0 degrees (3 pm) */
    float sTr = map(second() + secDiff, 0, 60, 0, TWO_PI) - HALF_PI;
    float mTr = map(minute() + minDiff  + norm(second(), 0, 60), 0, 60, 0, TWO_PI) - HALF_PI;
    float hTr = map(hour() + hourDiff + norm(minute() + minDiff, 0, 60), 0, 24, 0, TWO_PI) - HALF_PI;

    /**Draws the hand (and its thickness) for each time component */
    stroke(0);
    
     /** check which face the user desires, load image accordingly */
     if(cDesigns == clockDesigns.BLACK) { stroke(0); }
     else if(cDesigns == clockDesigns.GREEN) { stroke(27, 140, 41); }
     else if(cDesigns == clockDesigns.BLUE) { stroke(67, 96, 221); }
     else if(cDesigns == clockDesigns.PINK) { stroke(221, 67, 154); }
     else if(cDesigns == clockDesigns.PIZZA) { stroke (0); }

    strokeWeight(4); /**thickness of second hand */
    line(centerX, centerY, centerX + cos(sTr) * sRad, centerY + sin(sTr) * sRad);

    strokeWeight(6); /**thickness of minute hand */
    line(centerX, centerY, centerX + cos(mTr) * mRad, centerY + sin(mTr) * mRad);

    strokeWeight(10); /**thickness of hour hand */
    line(centerX,centerY, centerX + cos(hTr) * hRad, centerY + sin(hTr) * hRad);

  }


  /** 
    @pre: none
    @post: calculates the difference between the user requested and current time
    @return: none
  */
  public void calcDiff() {
    /** If after 12 pm, clock is treated as in 24 hour mode */
    int add12 = 0;

    if (!mainMenu.getTimeOfDay() && mainMenu.getView()){
      add12 = 12;
    }

    hourDiff = mainMenu.getHour() - hour() + add12;
    minDiff = mainMenu.getMinute() - minute();
    secDiff = mainMenu.getSecond() - second();
  }
  
   /** 
    @pre: valid int called radius and valid enumerated type called cDesigns
    @post: displays "AM" or "PM" on 12 hour clock depending on time
    @return: none
  */
  public void displayAMPM(int radius, clockDesigns cDesigns) {
    /**load am and pm photos */
    PImage am;
    am = loadImage("AM.png");
    PImage pm;
    pm = loadImage("PM.png");
    
    if(mainMenu.getTimeOfDay()) {
      
      /** check which face the user desires, load image accordingly */
      if(cDesigns == clockDesigns.BLACK) { am = loadImage("AM.png"); }
      else if(cDesigns == clockDesigns.GREEN) { am = loadImage("AM-green.png"); }
      else if(cDesigns == clockDesigns.BLUE) { am = loadImage("AM-blue.png"); }
      else if(cDesigns == clockDesigns.PINK) { am = loadImage("AM-pink.png"); }
      else if(cDesigns == clockDesigns.PIZZA) { am = loadImage("AM.png"); }
     
      am.resize(48, 34);
      image(am, radius + 70, radius - 135);
    }
    else {

      /** check which face the user desires, load image accordingly */
      if(cDesigns == clockDesigns.BLACK) { pm = loadImage("PM.png"); }
      else if(cDesigns == clockDesigns.GREEN) { pm = loadImage("PM-green.png"); }
      else if(cDesigns == clockDesigns.BLUE) { pm = loadImage("PM-blue.png"); }
      else if(cDesigns == clockDesigns.PINK) { pm = loadImage("PM-pink.png"); }
      else if(cDesigns == clockDesigns.PIZZA) { pm = loadImage("PM.png"); }
      
      
      pm.resize(48, 34);
      image(pm, radius + 70, radius - 135);
    }
  }     
}