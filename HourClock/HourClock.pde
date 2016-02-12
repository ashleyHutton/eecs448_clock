
void setup() {
  
  size(640, 360);
  Menu mainMenu = new Menu();
  ClockFace clock = new ClockFace();
  
  mainMenu.displayMenu();
  
  clock.display12Hour(320,175,300);
  mainMenu.toggleView();
  mainMenu.setTime();
  clock.display12Hands(1,2,3,4);
//  mainMenu.welcomeScreen();

}


 