
void setup() {
  
  size(640, 360);
  Menu mainMenu = new Menu();
  
  mainMenu.displayMenu();
  
  mainMenu.toggleView();
  mainMenu.setTime();

}

void draw() {
  
    ClockFace clock = new ClockFace();
    clock.display12Hour(320,175,300);
    clock.display12Hands(1,2,3,300);
  
}

 