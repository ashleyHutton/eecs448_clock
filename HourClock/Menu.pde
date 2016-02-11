import static javax.swing.JOptionPane.*;

class Menu{

  Menu(){
    
  }
  
  public void displayMenu(){
    rect(500, 250, 100, 75);
  }
  
  // allow user to select 12 or 24 hour mode
  public void toggleView(){
    
    Object[] toggleOptions = { "12 Hour", "24 Hour"};
    showOptionDialog(null, "Select Clock Mode:", "",
    DEFAULT_OPTION, INFORMATION_MESSAGE,
    null, toggleOptions, toggleOptions[0]);
    
  }
  
  // set the current time
  // will be called at the start of the application
  public void setTime(){

    String currentTime = showInputDialog("Enter Time\nExample of format: 1:15");
    
  }
  

}