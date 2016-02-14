Menu mainMenu;
ClockFace clock;
int radius;

void setup() {

  size(1000, 700);
  fill(255);
  mainMenu = new Menu();
  clock = new ClockFace();

  mainMenu.toggleView();

  // Calculates the differnce in time between user input and current time (12 & 24 mode)
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

    mainMenu.displayMenu();

    // Repeatedly prints the clock and its hands as they tick (12 & 24 mode)
    if (mainMenu.getView()) {
        clock.display12Hour(width,height,radius);
        clock.displayAMPM(radius);
        clock.display12Hands(radius);

    }
    else {
        clock.display24Hour(width,height,radius);
        clock.display24Hands(radius);
    }

}