//standard library imports
import java.awt.TextArea;
import java.util.Vector;

//SMT library imports
import vialab.SMT.*;

public class PasseTrappe_2 extends PasseTrappe {
  //main variables
  private int cpt_game;
  
  // Constructor
  PasseTrappe_2() {
    timer = new Timer(true);  
  }
  
  PasseTrappe_2(int l, String pi, boolean fromIndex) {
    println("PT2 > " + l + " - " + pi);
    this.level = l;
    this.border = loadImage(pi);
    this.timer = new Timer(true);
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
  }
  
  IState update(float delta) {
    return keepOn();
  }
  
  void stop(){
    physics.terminate = true;
  }
  
  public void startAgain(){
    this.timer = new Timer(true);
    println("nb pucks final" + this.pucks.size());
    for(Puck p : this.pucks){
      SMT.remove(p);
    }
    this.pucks = null;
    this.gameover = false;
    init();
  }
  
  void draw() {
    image(img, 0, 0, width, height);
    image(border, 0, 0, width, height); // Image position
    elastic();
    
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
      
      checkEndGame2P(timer.getRemainingTime());
    }else{
      this.stop();
      textSize(52);
      fill(0, 102, 153);
      textAlign(CENTER);
      text(this.winner, window_halfWidth, window_halfHeight);
    }
  }
}
