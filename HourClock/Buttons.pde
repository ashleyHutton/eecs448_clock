// Source: https://processing.org/examples/button.html

boolean overChangeMode = false;
boolean overChangeTime = false;
boolean overChangeFace = false;

void mousePressed() {
  if (overChangeMode) {
    //set mode to opposite the current mode
    mainMenu.setView(!mainMenu.getView());
  }
  if (overChangeTime){
    
    // call menu's set time function to update the time
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
  if (overChangeFace){
    System.out.println("pressed");
  }
}

void update(int x, int y) {
  if ( overChangeMode((width/2 - 75), 600, 150, 60) ) {
     // set overChangeMode true if button was pressed
    overChangeMode = true;
    overChangeTime = false;
    overChangeFace = false;
  } 

  else if (overChangeTime((radius / 2), 600, 150, 60) ){
     // set changeTime true if button was pressed
     overChangeMode = false;
     overChangeTime = true;
     overChangeFace = false;
  }
  else if (overChangeFace((width/2 + radius/2 - 150), 600, 150, 60) ){
     // set changeFace true if button was pressed
     overChangeMode = false;
     overChangeTime = false;
     overChangeFace = true;
  }
  else {
    // set everything to false if not on button
    overChangeMode = false;
    overChangeTime = false;
    overChangeFace = false;
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

boolean overChangeFace(int x, int y, int width, int height)  {
  
  // checks if mouse clicks changeFace button
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}