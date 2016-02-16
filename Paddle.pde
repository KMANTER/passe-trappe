import vialab.SMT.*;

public class Paddle extends Zone{
  // Position X Y
  private float x;
  private float y;
  
  // Size of the paddle
  private int size
  
  public Paddle(int x, int y, int size){
    this.x = x;
    this.y = y;
    this.size = size;
  }
  
  void initPaddle(){
    Zone zone = new Zone("Paddle");
    SMT.add(paddle); 
  }
  
  void drawPaddle(Zone zone){
    rect(this.x, this.y, this.size, this.size);
  }
}
