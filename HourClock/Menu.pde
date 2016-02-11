import static javax.swing.JOptionPane.*;
import java.util.regex.*;

class Menu{

  Boolean m_12Hour;
  int m_hour;
  int m_minute;
  int m_second;
  
  private Pattern pattern12;
  private Pattern pattern24;

  private Matcher match12;
  private Matcher match24;

  
  Menu(){
    
    m_12Hour = true;
    
    m_hour = 0;
    m_minute = 0;
    m_second = 0;
    
  }
  
  public void displayMenu(){
    rect(500, 250, 100, 75);
  }
  
  // allow user to select 12 or 24 hour mode
  public void toggleView(){
    
    Object[] toggleOptions = { "12 Hour", "24 Hour"};
    int viewMode = showOptionDialog(null, "Select Clock Mode:", "",
    DEFAULT_OPTION, INFORMATION_MESSAGE,
    null, toggleOptions, toggleOptions[0]);
    
    // set m_12Hour to true if user selects 12 hour
    if (viewMode == 0){
      m_12Hour = true;
    }
    // set m_12Hour to false if user selects 24 hour
    else if (viewMode == 1){
      m_12Hour = false;
    }
    // do nothing if user clicks cancel
        
  }
  
  public Boolean getView(){
    
    return(m_12Hour);
  }
  
  public int getHour(){
    return(m_hour);
  }
  
  public int getMinute(){
    return(m_minute);
  }
  
  public int getSecond(){
    return(m_second);
  }
  
  // set the current time
  // will be called at the start of the application
  public void setTime(){
    
    Boolean timeIsValid = false;

    String timePattern_12hr = "([1-9]|1[0-2]):([0-5][0-9])(:([0-5][0-9]))?";
    String timePattern_24hr = "([01]?[0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9]";

    while (!timeIsValid){

      String currentTime = showInputDialog("Enter Time\nExample of format: 1:15");
      
      if (m_12Hour){
        
        pattern12 = Pattern.compile(timePattern_12hr);
        match12 = pattern12.matcher(currentTime);
        
        if (match12.find()){
          
          timeIsValid = true;
        
          System.out.println(match12.group(0));
          System.out.println(match12.group(1));
          System.out.println(match12.group(2));
          System.out.println(match12.group(3));
          System.out.println(match12.group(4));
          
          m_hour = Integer.parseInt(match12.group(1));
          m_minute = Integer.parseInt(match12.group(2));
          
          if (match12.group(4) != ""){
             m_second = Integer.parseInt(match12.group(4));
          }
          else{
            m_second = 0;
          }
        }
        
        else{
          
        }
      }
      
      if (!m_12Hour){
        
        pattern24 = Pattern.compile(timePattern_24hr);
        match24 = pattern24.matcher(currentTime);      
        
        if (match24.find()){
  
           System.out.println(match24.group(0));
  
        }
        
      }
    
    }
    
  }
}