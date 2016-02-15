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


void setup() {

  size(1000, 700);
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

void draw() {
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