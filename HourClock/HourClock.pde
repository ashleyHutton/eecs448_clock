Menu mainMenu;
ClockFace clock;


void setup() {

  size(640, 360);
  mainMenu = new Menu();
  clock = new ClockFace();


  mainMenu.displayMenu();
  mainMenu.toggleView();
  mainMenu.setTime();

  // Calculates the differnce in time between user input and current time (12 & 24 mode)
  if (mainMenu.getView())
  {
    clock.calcDiff12();
  }
  else
  {
    clock.calcDiff24();
  }

}

void draw() {
    int hour = mainMenu.getHour();
    int minute = mainMenu.getMinute();
    int second = mainMenu.getSecond();

    // Repeatedly prints the clock and its hands as they tick (12 & 24 mode)
    if (mainMenu.getView()) {

        clock.display12Hour(320,175,300);
        clock.display12Hands(hour,minute,second,300);

    }
    else {
        clock.display24Hour(320,175,300);
        clock.display24Hands(hour,minute,second,300);
    }
}
