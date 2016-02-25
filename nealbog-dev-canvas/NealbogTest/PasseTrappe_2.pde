//standard library imports
import java.awt.TextArea;
import java.util.Vector;

//SMT library imports
import vialab.SMT.*;

public class PasseTrappe_2 extends PasseTrappe {
  //main variables
  Physics physics = new Physics(this);
  
  //corners
  public PVector topLeftCorner;
  public PVector topRightCorner;
  public PVector bottomLeftCorner;
  public PVector bottomRightCorner;
  
  public PVector topMiddleCorner;
  public PVector bottomMiddleCorner;

  public PVector middleTopCornerL;
  public PVector middleBottomCornerL;
  public PVector middleTopCornerR;
  public PVector middleBottomCornerR;
  
  
  // Constructor
  PasseTrappe_2() {
    timer = new Timer(true);  
  }
  
  PasseTrappe_2(int l, String pi, boolean fromIndex) {
    println("PT2 > " + l + " - " + pi);
    this.level = l;
    this.border = loadImage(pi);
    this.timer = new Timer(false);
    if(fromIndex)
      init();
  }
  
  void init() {
    super.init();
    fill(204, 102, 0);
    
    pucks = new Vector<Puck>();
    this.supplyPuck(true);
    
    //start up the physics engine
    try{
      Thread.sleep(0);
    } catch( InterruptedException e){}
    
    physics.start();
    timer.StartTimer();
  }
  

  void handleInput(InputHandler inputHandler) {
    if(pucks.size() > 0){
      for(Puck p : pucks){
        p.update(inputHandler.getTouches());
      }
    }
  }
  
  IState update(float delta) {
    return keepOn();
  }
  
  void stop(){
    physics.terminate = true;
  }
  
  void draw() {
    image(img, 0, 0, width, height);
    image(border, 0, 0, width, height); // Image position
    elastic();
    
    if(!this.gameover){
      String t = timer.getTime();
      textSize(32);
      fill(0, 102, 153);
      textAlign( CENTER);
      text( t, window_halfWidth, 64);
      println(t);
      int remainingTime =timer.getRemainingTime();
      println("le temps restant : "+remainingTime);
      println("time backwards : "+timer.getBackwardsTime());
      checkEndGame2P();
    }else{
      this.stop();
      textSize(52);
      fill(0, 102, 153);
      textAlign(CENTER);
      text(this.winner, window_halfWidth, window_halfHeight);
    }
  }
}
