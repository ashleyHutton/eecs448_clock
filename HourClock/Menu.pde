import static javax.swing.JOptionPane.*;
import java.util.regex.*;

class Menu{

  Boolean m_12Hour;
  Boolean m_isAM;
  int m_hour;
  int m_minute;
  int m_second;
  
  private Pattern pattern12;
  private Pattern pattern24;

  private Matcher match12;
  private Matcher match24;

  
  Menu(){
    
    m_12Hour = true;
    m_isAM = true;
    
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
  
  public Boolean getTimeOfDay(){
    return(m_isAM);
  }
  
  // set the current time
  // will be called at the start of the application
  public void setTime(){
    
    // checks if time is entered correctly
    Boolean timeIsValid = false;
    // the string that the user inputs with the time
    String currentTime;

    // regular expression looking for the format "##:##:## AM/PM in 12hr
    String timePattern_12hr = "([1-9]|1[0-2]):([0-5][0-9]):([0-5][0-9])[ ]?(?i)(am|pm)$";
    // regular expression looking for the format "##:##:## in 24hr
    String timePattern_24hr = "([01]?[0-9]|2[0-3]):([0-5][0-9]):([0-5][0-9])$";

    // loop until the time entered matches the given regex
    while (!timeIsValid){

      // in 12 hour mode
      if (m_12Hour){
        
        currentTime = showInputDialog("Enter Time\nExample of format: 1:15:45 AM");

        // compile and match regex to the given input
        pattern12 = Pattern.compile(timePattern_12hr);
        match12 = pattern12.matcher(currentTime);
        
        // matches found -- valid input
        if (match12.find()){
          
          timeIsValid = true;
        
          for (int i=0; i<match12.groupCount(); i++){
            
            System.out.println(i + ": " + match12.group(i));
      
          }
          
          // set hours to first group of regex
          m_hour = Integer.parseInt(match12.group(1));
          // set minutes to second group of regex
          m_minute = Integer.parseInt(match12.group(2));
          // set seconds to third group of regext
          m_second = Integer.parseInt(match12.group(3));
          
          // set m_isAM to true if user inputs 'am'
          if (match12.group(4).equalsIgnoreCase("am")){
            
            m_isAM = true;
          }
          else {
            
            m_isAM = false;
          }
          
          System.out.println(m_isAM);

        }

      }
      
      // if in 24 hour mode
      if (!m_12Hour){
        
        currentTime = showInputDialog("Enter Time\nExample of format: 1:15:45 AM");

        // compile and match regex to the given input        
        pattern24 = Pattern.compile(timePattern_24hr);
        match24 = pattern24.matcher(currentTime);      
        
        if (match24.find()){
          
          timeIsValid = true;
        
          for (int i=0; i<match24.groupCount(); i++){
            System.out.println(i + ": " + match24.group(i));
      
          }
          
          // set hours to first group of regex
          m_hour = Integer.parseInt(match24.group(1));
          // set minutes to second group of regex
          m_minute = Integer.parseInt(match24.group(2));
          // set seconds to third group of regext
          m_second = Integer.parseInt(match24.group(3));
  
        }
        
      }
    
    }
    
  }
  
}