import vialab.SMT.*;

public class Timer{
  
  private int sec;
  private int ss;
  private int mm;
  private String time;
  private boolean multijoueur;
  private final static int timeMultiJoeur = 120;
  private final static int timeSoloJoeur = 30;
  private int remainingTime;
  
  public Timer( boolean multiJ){
    this.multijoueur = multiJ;
  }
  
  public void StartTimer(){
    this.sec =second();
    this.ss = 0;
    this.mm = 0;
    this.time="";
    if(this.multijoueur) remainingTime = 120; else remainingTime=30;
  }
  
  public String getTime(){
        
    if(second() != this.sec ){
      if(this.ss == 59) {this.ss =0; this.mm++;}
      else this.ss++;
      this.sec = second();
      this.remainingTime--;
    } 

    if(String.valueOf(this.mm).length() == 1)  this.time = "0"+this.mm; else  this.time = ""+this.mm;
    if(String.valueOf(this.ss).length() == 1)  this.time = this.time+":"+"0"+this.ss; else this.time = this.time+":"+this.ss;
    
    return this.time;
  }
  
     public String getBackwardsTime(){
     
      int minutes = (this.remainingTime % 3600) / 60;
      int seconds = this.remainingTime % 60;
      
      String timeString = String.format("%02d:%02d",  minutes, seconds);
      
      return timeString;
   } 
  
  public int getRemainingTime(){
    return this.remainingTime;
  }

}
