//standard library imports
import java.awt.TextArea;
import java.util.Vector;
//SMT library imports
import vialab.SMT.*;

public class PasseTrappe_1 extends PasseTrappe {
  
  // Constructor
  PasseTrappe_1() {
    timer = new Timer(true);
  }
  
  PasseTrappe_1(int l, String pi, boolean fromIndex) {
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
    if(!isPaused){
      for(Button b : buttons){
        b.draw();
      }  
    }
    if(!this.gameover){
      timer.getTime();
      String t = timer.getBackwardsTime();
      textSize(32);
      fill(0, 102, 153);
      if(timer.getRemainingTime() < 10){
        fill(255, 0, 0);
      }
      textAlign( CENTER);
      text(t, window_halfWidth, 64);
      
      println("le temps restant : " + t);
      checkEndGame1P(timer.getRemainingTime());
    }else{
      textSize(52);
      fill(0, 102, 153);
      textAlign(CENTER);
      text(this.winner, window_halfWidth, window_halfHeight);
      this.stop();
    }
  }
  
}
