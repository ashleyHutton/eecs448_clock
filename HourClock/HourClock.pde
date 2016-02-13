Menu mainMenu;
ClockFace clock;
int radius;

boolean over12Hr = false;
boolean over24Hr = false;
boolean overChangeTime = false;

void setup() {

  size(640, 430);
  fill(255);
  mainMenu = new Menu();
  clock = new ClockFace();

  mainMenu.toggleView();
  mainMenu.setTime();

  // Calculates the differnce in time between user input and current time (12 & 24 mode)
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
    update(mouseX, mouseY);
    background(255);
    radius = 300;
    
    mainMenu.displayMenu();
    
    // Repeatedly prints the clock and its hands as they tick (12 & 24 mode)
    if (mainMenu.getView()) {
        clock.display12Hour(320,175,300);
        clock.display12Hands(radius);
    }
    else {
        clock.display24Hour(320,175,300);
        clock.display24Hands(radius);
    }
    
      if (rectOver) {
    fill(rectHighlight);
  } else {
    fill(rectColor);
  }
  stroke(255);
  rect(rectX, rectY, rectSize, rectSize);
  
  if (circleOver) {
    fill(circleHighlight);
  } else {
    fill(circleColor);
  }
  stroke(0);
  ellipse(circleX, circleY, circleSize, circleSize);
}

void mousePressed() {
  if (circleOver) {
    currentColor = circleColor;
  }
  if (rectOver) {
    currentColor = rectColor;
  }
}

void update(int x, int y) {
  if ( over12Hr(170, 350, 140, 50) ) {
    over12Hr = true;
    over24Hr = false;
    overChangeTime = false;
  } else if ( over24Hr(170, 350, 140, 50) ) {
    over12Hr = false;
    over24Hr = true;
    overChangeTime = false;
  } 
  else if (overChangeTime(330, 350, 140, 50) ){
     over12Hr = false;
     over24Hr = false;
     overChangeTime = true;
  }
  else {
    over12Hr = false;
    over24Hr = false;
    overChangeTime = false;
  }
}

boolean overRect(int x, int y, int width, int height)  {
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

boolean overCircle(int x, int y, int diameter) {
  float disX = x - mouseX;
  float disY = y - mouseY;
  if (sqrt(sq(disX) + sq(disY)) < diameter/2 ) {
    return true;
  } else {
    return false;
  }
  
  
  
}