//standard library imports
import java.awt.TextArea;
import java.util.Vector;
//SMT library imports
import vialab.SMT.*;

public class PasseTrappe_1 extends PasseTrappe {
  private int cpt_game = 0;
  
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
    
    if(cpt_game > 0){
      physics = new Physics(this);
    }
    physics.start();
    
    timer.StartTimer();
    cpt_game++;
  }

  void handleInput(InputHandler inputHandler) {
    if(pucks.size() > 0){
      for(Puck p : pucks){
        p.update(inputHandler.getTouches());
      }
    }
    
    if(this.gameover){
      println("its over");
      if(inputHandler.getTouches().length > 0){
        Touch t = inputHandler.getTouches()[0];
        if(t.x > this.again.position.x && t.x < (this.again.position.x + 120) && t.y > this.again.position.y && t.y < (this.again.position.y + 80)){
          println("new Game !");
          startAgain();
        } 
      }
    }
  }
  
  IState update(float delta) {
    return keepOn();
  }
  
  public void startAgain(){
    this.timer = new Timer(false);
    println("nb pucks final" + this.pucks.size());
    for(Puck p : this.pucks){
      SMT.remove(p);
    }
    this.pucks = null;
    this.gameover = false;
    init();
  }
  
  void draw() {
    background(img);
    image(border, 0, 0); // Image position
    elastic();
    //draw timer
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
      fill(255);
      again.draw();
      textSize(52);
      fill(0, 102, 153);
      textAlign(CENTER);
      text(this.winner, window_halfWidth, window_halfHeight);
      this.stop();
    }
  }
  
}
