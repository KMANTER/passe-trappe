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
    int level = 100;
    //strokeWeight(2);
    fill(204, 102, 0);
    
    pucks = new Vector<Puck>();
    this.supplyPuck(false);
     
    this.window_halfWidth = this.window_width / 2;
    this.window_halfHeight = this.window_height / 2;
    
    //create corners
    topLeftCorner = new PVector(this.marge, this.thickness);
    topMiddleCorner = new PVector(this.window_halfWidth - (this.thickness / 2), this.thickness);
    topRightCorner = new PVector( window_width - this.marge, this.thickness);
    
    middleTopCorner = new PVector(this.window_halfWidth - (this.thickness / 2), this.window_halfHeight - (level));
    middleBottomCorner = new PVector(this.window_halfWidth + (this.thickness / 2), this.window_halfHeight + (level));
    
    bottomLeftCorner = new PVector( this.marge, window_height - this.thickness);
    bottomMiddleCorner = new PVector(this.window_halfWidth + (this.thickness / 2), window_height - this.thickness);
    bottomRightCorner = new PVector( window_width - this.marge, window_height - this.thickness);

    //create walls
    walls = new Vector<Wall>();
    walls.add( new Wall( topLeftCorner, topMiddleCorner, this));
    walls.add( new Wall( topMiddleCorner, middleTopCorner, this));
    walls.add( new Wall( topMiddleCorner, topRightCorner, this));
    walls.add( new Wall( topRightCorner, bottomRightCorner, this));
    
    walls.add( new Wall( bottomRightCorner, bottomMiddleCorner, this));
    walls.add( new Wall( bottomMiddleCorner, middleBottomCorner, this));
    walls.add( new Wall( bottomMiddleCorner, bottomLeftCorner, this));
    walls.add( new Wall( bottomLeftCorner, topLeftCorner, this));
    
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
    background(img);
    image(border, 0, 0); // Image position
    elastic();
    //draw timer
    String t = timer.getTime();
    textSize(32);
    fill(0, 102, 153);
    textAlign( CENTER);
    text( t, window_halfWidth, 32);
    println(t);
    checkEndGame1P();
  }
  
}
