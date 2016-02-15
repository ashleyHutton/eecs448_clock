import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import static javax.swing.JOptionPane.*; 
import java.util.regex.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class HourClock extends PApplet {

/** HourClock functions as our programs main method. In processing, main is split into a setup method and a draw method.
*
*
* @author Ashley Hutton, Hannah Johnson, Rabel Marte
*/

Menu mainMenu;
ClockFace clock;
int radius;

int seconds = 0;
int minutes = 0;
int hours = 0;
int k = 1;
int j = 1;


public void setup() {

  
  fill(255);
  mainMenu = new Menu();
  clock = new ClockFace();

    
  mainMenu.toggleView();

  /** Calculates the differnce in time between user input and current time (12 & 24 mode) */
  if (mainMenu.getView())
  {
    mainMenu.set12HrTime();
    clock.calcDiff();
  }
  else
  {
    mainMenu.set24HrTime();
    clock.calcDiff();
  }

}

public void draw() {
    update(mouseX, mouseY);
    background(255);
    radius = 500;
    
    /** Check if clock rolls over from AM/PM */
    seconds = second() + secDiff;
       
    if (seconds == (60 * k)){
      minutes++;
      k++;
    }
    if (minutes == (60 * j)){
      hours++;
      j++;
    }
    if (hours == 24){
      hours = 0;
    }

    mainMenu.displayMenu();
    
    if (hours >= 12){           
      mainMenu.setTimeOfDay(false);
    }
    else if (hours < 12){
      mainMenu.setTimeOfDay(true);
    }

    /** Repeatedly prints the clock and its hands as they tick (12 & 24 mode) */
    if (mainMenu.getView()) {
        clock.display12Hour(width,height,radius, currentDesign);
        clock.displayAMPM(radius, currentDesign);
        clock.display12Hands(radius, currentDesign);
    }
    else {
        clock.display24Hour(width,height,radius, currentDesign);
        clock.display24Hands(radius, currentDesign);
    }

}
/** Buttons class handles functionality of menu buttons that change clock settings
*
*
* @author Ashley Hutton, Hannah Johnson, Rabel Marte
*/

boolean overChangeMode = false;
boolean overChangeTime = false;
boolean overChangeFace = false;

int index = 1;
clockDesigns currentDesign;

/**
*  @pre none
*  @post executes the action of the button that is pressed
*  @return none
*/
public void mousePressed() {
  if (overChangeMode) {
    /**set mode to opposite the current mode */
    mainMenu.setView(!mainMenu.getView());
  }
  if (overChangeTime){

    /** call menu's set time function to update the time */
    /** Calculates the differnce in time between user input and current time (12 & 24 mode) */
    if (mainMenu.getView())
    {
      mainMenu.set12HrTime();
      clock.calcDiff();
    }
    else
    {
      mainMenu.set24HrTime();
      clock.calcDiff();
    }
  }
  if (overChangeFace){
    /** change the clock face design */
    currentDesign = clockDesigns.values()[index];
    
    index++;

    if (index == 5){
      index = 0;
    }
  }
}

/**
*  @pre valid integers called x and y
*  @post updates boolean member variables that involve a button being clicked
*  @return none
*/
public void update(int x, int y) {
  if ( overChangeMode((width/2 - 75), 600, 150, 60) ) {
     /** set overChangeMode true if button was pressed */
    overChangeMode = true;
    overChangeTime = false;
    overChangeFace = false;
  }

  else if (overChangeTime((radius / 2), 600, 150, 60) ){
     /** set changeTime true if button was pressed */
     overChangeMode = false;
     overChangeTime = true;
     overChangeFace = false;
  }
  else if (overChangeFace((width/2 + radius/2 - 150), 600, 150, 60) ){
     /** set changeFace true if button was pressed */
     overChangeMode = false;
     overChangeTime = false;
     overChangeFace = true;
  }
  else {
    /** set everything to false if not on button */
    overChangeMode = false;
    overChangeTime = false;
    overChangeFace = false;
  }
}

/**
*  @pre valid integers called x, y, width, and height
*  @post check if change mode is clicked
*  @return true if the button is clicked
*/
public boolean overChangeMode(int x, int y, int width, int height)  {

  /** checks if mouse clicks 12hr button */
  if (mouseX >= x && mouseX <= x+width &&
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

/**
*  @pre valid integers called x, y, width, and height
*  @post check if change time is clicked
*  @return true if the button is clicked
*/
public boolean overChangeTime(int x, int y, int width, int height)  {

  /** checks if mouse clicks changeTime button */
  if (mouseX >= x && mouseX <= x+width &&
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

/**
*  @pre valid integers called x, y, width, and height
*  @post check if change face is clicked
*  @return true if the button is clicked
*/
public boolean overChangeFace(int x, int y, int width, int height)  {

  /** checks if mouse clicks changeFace button */
  if (mouseX >= x && mouseX <= x+width &&
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

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
    float sRad = radius * .4f;
    float mRad = radius * .3f;
    float hRad = radius * .2f;

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
    float sRad = radius * .4f;
    float mRad = radius * .3f;
    float hRad = radius * .2f;


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



/** Menu displays the buttons and popup windows that allow the user to 
 *  set the time and 12hr vs 24hr mode
 *
 * @author Ashley Hutton, Hannah Johnson, Rabel Marte
 */
public class Menu {

  Boolean m_12Hour;
  Boolean m_isAM;
  int m_hour;
  int m_minute;
  int m_second;

  private Pattern pattern12;
  private Pattern pattern24;

  private Matcher match12;
  private Matcher match24;


  Menu(){

    m_12Hour = true;
    m_isAM = true;

    m_hour = 0;
    m_minute = 0;
    m_second = 0;

  }

  /**
	*  @pre none
	*  @post set boolean member variables to true, numerical member variables to 0
	*  @return none
	*/
  public void displayMenu(){

    PImage switchTo12;
    PImage switchTo24;
    PImage changeTime;
    PImage changeFace;

    switchTo12 = loadImage("switchTo12.png");
    switchTo24 = loadImage("switchTo24.png");
    changeTime = loadImage("changeTime.png");
    changeFace = loadImage("switchFace.png");


    if (getView()){
      switchTo24.resize(150, 60);
      image(switchTo24, (width/2 - 75), 600);

    }
    else{
      switchTo12.resize(150, 60);
      image(switchTo12, (width/2 - 75), 600);
    }

    changeTime.resize(150, 60);
    image(changeTime, (radius/2), 600);

    changeFace.resize(150, 60);
    image(changeFace, (width/2 + radius/2 - 150), 600);

  }

  /**
	*  @pre none
	*  @post allows user to switch between 12 and 24 hour mode
	*  @return none
	*/
  public void toggleView(){

    Object[] toggleOptions = { "12 Hour", "24 Hour"};
    int viewMode = showOptionDialog(null, "Select Clock Mode:", "",
    DEFAULT_OPTION, INFORMATION_MESSAGE,
    null, toggleOptions, toggleOptions[0]);

    /** set m_12Hour to true if user selects 12 hour*/
    if (viewMode == 0){
      m_12Hour = true;
    }
    /** set m_12Hour to false if user selects 24 hour*/
    else if (viewMode == 1){
      m_12Hour = false;
    }
    /** do nothing if user clicks cancel*/
  }

  /**
	*  @pre none
	*  @post none
	*  @return m_12Hour
	*/
  public Boolean getView(){
    return(m_12Hour);
  }

  /**
	*  @pre valid boolean variable called is12Hour
	*  @post sets m_12Hour to is12Hour
	*  @return None
	*/
  public void setView(Boolean is12Hour){
    /** set m_12Hour to true if clock is displayed in 12 hour*/
    /** set m_12Hour to false if clock is displayed in 24 hour*/
    m_12Hour = is12Hour;
  }

  /**
	*  @pre none
	*  @post none
	*  @return m_hour
	*/
  public int getHour(){
    return(m_hour);
  }

  /**
  *  @pre none
  *  @post none
  *  @return m_minute
  */
  public int getMinute(){
    return(m_minute);
  }

  /**
  *  @pre none
  *  @post none
  *  @return m_second
  */
  public int getSecond(){
    return(m_second);
  }

  /**
  *  @pre none
  *  @post none
  *  @return m_isAM
  */
  public Boolean getTimeOfDay(){
    /** return true if AM */
    /** return false if PM */
    return(m_isAM);
  }

  /**
	*  @pre none
	*  @post sets m_minute, m_hour, and m_second to user desired 12 hour time
	*  @return none
	*/
  public void setTimeOfDay(Boolean isAM){
    /** set true if AM */
    /** set false if PM */
    m_isAM = isAM;
  }


  /**
	*  @pre none
	*  @post sets m_minute, m_hour, and m_second to user desired 24 hour time
	*  @return none
	*/
  public void set12HrTime(){

    /** checks if time is entered correctly */
    Boolean timeIsValid = false;
    /** the string that the user inputs with the time */
    String currentTime;

    /** regular expression looking for the format "##:##:## AM/PM in 12hr */
    String timePattern_12hr = "(^[1-9]|1[0-2]):([0-5][0-9]):([0-5][0-9])[ ]?(?i)(am|pm)$";

    /** loop until the time entered matches the given regex */
    while (!timeIsValid){

      currentTime = showInputDialog("Enter Time\nExample of format: 1:15:45 AM");

      if (currentTime == null){
        /** if user presses cancel:
         1) set time to set time to computer clock time if user first opens program
         2) do not change time if user has already been running clock */
        timeIsValid = true;

        m_hour = hour() + hourDiff;
        m_minute = minute() + minDiff;
        m_second = second() + secDiff;
      }
      else{

        /** compile and match regex to the given input */
        pattern12 = Pattern.compile(timePattern_12hr);
        match12 = pattern12.matcher(currentTime);

        /** matches found -- valid input */
        if (match12.find()){

          timeIsValid = true;

          /** set hours to first group of regex */
          m_hour = Integer.parseInt(match12.group(1));
          /** set minutes to second group of regex */
          m_minute = Integer.parseInt(match12.group(2));
          /** set seconds to third group of regext */
          m_second = Integer.parseInt(match12.group(3));

          /** set m_isAM to true if user inputs 'am' */
          if (match12.group(4).equalsIgnoreCase("am")){

            m_isAM = true;
            hours = m_hour;
          }
          else {

            m_isAM = false;
            hours = m_hour + 12;

          }

          minutes = m_minute;
        }
      }
    }
  }

  /**
  *  @pre none
  *  @post sets m_minute, m_hour, and m_second to user desired 24 hour time
  *  @return none
  */
  public void set24HrTime(){

    /** checks if time is entered correctly */
    Boolean timeIsValid = false;
    /** the string that the user inputs with the time */
    String currentTime;

    /** regular expression looking for the format "##:##:## in 24hr */
    String timePattern_24hr = "(^[01]?[0-9]|2[0-3]):([0-5][0-9]):([0-5][0-9])$";

    while(!timeIsValid){

      currentTime = showInputDialog("Enter Time\nExample of format: 1:15:45");

      if (currentTime == null){
        /** if user presses cancel:
         1) set time to computer clock time if user first opens program
         2) do not change time if user has already been running clock */
        timeIsValid = true;

        m_hour = hour() + hourDiff;
        m_minute = minute() + minDiff;
        m_second = second() + secDiff;
      }

      else{

        /** compile and match regex to the given input */
        pattern24 = Pattern.compile(timePattern_24hr);
        match24 = pattern24.matcher(currentTime);

        if (match24.find()){

          timeIsValid = true;

          /** set hours to first group of regex */
          m_hour = Integer.parseInt(match24.group(1));
          /** set minutes to second group of regex */
          m_minute = Integer.parseInt(match24.group(2));
          /** set seconds to third group of regext */
          m_second = Integer.parseInt(match24.group(3));

          if (m_hour > 12){
            m_isAM = false;
          }
          if (m_hour <= 12){
            m_isAM = true;
          }

          minutes = m_minute;
          hours = m_hour;
        }
      }
    }
  }
}
  public void settings() {  size(1000, 700); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "HourClock" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
