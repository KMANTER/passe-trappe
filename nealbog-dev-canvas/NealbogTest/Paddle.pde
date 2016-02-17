import vialab.SMT.*;

public class Paddle extends Zone{
  // Position X Y
  private float x;
  private float y;
  
  // Size of the paddle
  private int size;
  
  public Paddle(int x, int y, int size){
    this.x = x;
    this.y = y;
    this.size = size;
    
    Zone paddle = new Zone("paddle");
    SMT.add(paddle);
    
    println("x:"+x+"/y:"+y);
  }
  
  void drawPaddle(Zone zone){
    print("Draw paddle"); 
    ellipse(this.x, this.y, this.size, this.size);
  }
  
  void touchPaddle(Zone zone){
    print("Touch paddle"); 
    fill(250);
  }
}
