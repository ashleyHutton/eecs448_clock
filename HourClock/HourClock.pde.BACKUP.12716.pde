<<<<<<< HEAD
Menu mainMenu;
ClockFace clock;
int radius;

void setup() {

  size(640, 360);
  fill(255);
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
    background(255);
    radius = 300;
    // Repeatedly prints the clock and its hands as they tick (12 & 24 mode)
    if (mainMenu.getView()) {
        clock.display12Hour(320,175,300);
        clock.display12Hands(radius);
    }
    else {
        clock.display24Hour(320,175,300);
        clock.display24Hands(radius);
    }
}
=======
Menu mainMenu;
ClockFace clock;
int radius;

void setup() {

  size(640, 360);
  mainMenu = new Menu();
  clock = new ClockFace();


  mainMenu.displayMenu();
  mainMenu.toggleView();
  mainMenu.setTime();

  // Calculates the difference in time between user input and current time (12 & 24 mode)
  if (mainMenu.getView())
  {
    clock.calcDiff();
  }
  else
  {
    clock.calcDiff();
  }

}

void draw() {

    radius = 300;
    // Repeatedly prints the clock and its hands as they tick (12 & 24 mode)
    if (mainMenu.getView()) {
        clock.display12Hour(320,175,300);
        clock.display12Hands(radius);
    }
    else {
        clock.display24Hour(320,175,300);
        clock.display24Hands(radius);
    }
}
>>>>>>> 30b214a1f6eb18f0ff495f1aa1378c09aa2b8962
