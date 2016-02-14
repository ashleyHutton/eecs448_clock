// Source: https://processing.org/examples/button.html

boolean overChangeMode = false;
boolean overChangeTime = false;

void mousePressed() {
  if (overChangeMode) {
    //set mode to opposite the current mode
    mainMenu.setView(!mainMenu.getView());
    System.out.println("12 hour pressed");
  }
  if (overChangeTime){
    // call menu's set time function to update the time
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
}

void update(int x, int y) {
  if ( overChangeMode(170, 350, 140, 50) ) {
     // set over12hr true if button was pressed
    overChangeMode = true;
    overChangeTime = false;
  } 

  else if (overChangeTime(330, 350, 140, 50) ){
     // set changeTime true if button was pressed
     overChangeMode = false;
     overChangeTime = true;
  }
  else {
    // set everything to false if not on button
    overChangeMode = false;
    overChangeTime = false;
  }
}

boolean overChangeMode(int x, int y, int width, int height)  {
  
  // checks if mouse clicks 12hr button
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

boolean overChangeTime(int x, int y, int width, int height)  {
  
  // checks if mouse clicks changeTime button
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}