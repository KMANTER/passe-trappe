//standard library imports
import java.awt.TextArea;
import java.util.Vector;
//SMT library imports
import vialab.SMT.*;

public class PasseTrappe_1 extends PasseTrappe {
  
  // Constructor
  PasseTrappe_1() {
    timer = new Timer();
  }
  
  PasseTrappe_1(int l, String pi, boolean fromIndex) {
    this.level = l;
    this.border = loadImage(pi);
    this.timer = new Timer();
    if(fromIndex)
      init();
  }
  
  void init() {
    super.init();
    fill(204, 102, 0);
    
    pucks = new Vector<Puck>();
    this.supplyPuck(false);
    
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
  
  void draw() {
    background(img);
    image(border, 0, 0); // Image position
    elastic();
    //draw timer
    
    if(!this.gameover){
      String t = timer.getTime();
      textSize(32);
      fill(0, 102, 153);
      textAlign( CENTER);
      text( t, window_halfWidth, 64);
      println(t);
      checkEndGame1P(20);
    }else{
      textSize(52);
      fill(0, 102, 153);
      textAlign(CENTER);
      text(this.winner, window_halfWidth, window_halfHeight);
      this.stop();
    }
  }
  
}
