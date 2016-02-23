public class Button{
  PVector position;
  boolean isClicked;
 
  public Button(){
    this.isClicked = false;
  }
  
  public Button(PVector position){
    this.position = position;
    this.isClicked = false;
  } 
 
  public PVector getPosition(){
    return this.position;
  }
 
  public boolean isClicked(){
    return this.isClicked;
  } 
}
