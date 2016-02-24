import vialab.SMT.*;

public class Timer{

  private int sec;
  private int ss;
  private int mm;
  private String time;
  
  public void StartTimer(){
    this.sec =second();
    this.ss = 0;
    this.mm = 0;
    this.time="";
  }
  
  public String getTime(){
        
    if(second() != this.sec ){
      if(this.ss == 59) {this.ss =0; this.mm++;}
      else this.ss++;
      this.sec = second();
    } 
    if(String.valueOf(this.mm).length() == 1)  this.time = "0"+this.mm; else  this.time = ""+this.mm;
    if(String.valueOf(this.ss).length() == 1)  this.time = this.time+":"+"0"+this.ss; else this.time = this.time+":"+this.ss;
    
    return this.time;
  }

}
