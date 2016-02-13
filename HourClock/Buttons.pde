boolean over12Hr = false;
boolean over24Hr = false;
boolean overChangeTime = false;

void mousePressed() {
  if (over12Hr) {
    mainMenu.setTime();
  }
  if (over24Hr) {
    mainMenu.setTime();
  }
  if (overChangeTime){
    mainMenu.setTime();
    
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

boolean over12Hr(int x, int y, int width, int height)  {
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

boolean over24Hr(int x, int y, int width, int height)  {
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

boolean overChangeTime(int x, int y, int width, int height)  {
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}