//standard library imports
import java.awt.TextArea;
import java.util.Vector;
//SMT library imports
import vialab.SMT.*;

public class PasseTrappe_1 extends PasseTrappe {
  
  
  // Constructor
  PasseTrappe_1() {
  }
  
  PasseTrappe_1(int l, String pi) {
    this.level = l;
    this.img = loadImage(pi);
  }
  
  void init() {
    int level = 100;
    //strokeWeight(2);
    fill(204, 102, 0);
    
    pucks = new Vector<Puck>();
    this.supplyPuck();
     
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
    

    /*create nets
    player = new Net( "Player", 0, -window_halfHeight, 50, 400);
    enemy = new Net( "Enemy", -window_width, -window_halfHeight, 50, 400);
    SMT.add( player);
    SMT.add( enemy);
    */
    
    
    
    //start up the physics engine
    try{
      Thread.sleep( 0);
    } catch( InterruptedException e){}
    
    physics.start();
  }
  
  void supplyPuck(){
    //Positionning
    for(int i=0; i < 10; i++){
      print(i+"->");
      Puck p;
      int mod = i % 2;
      if( mod == 0){// Left Zone
        p = new Puck( this.marge + this.puckRadius + this.thickness, this.marge + ((i-mod) * this.puckRadius), this.puckRadius);
      }else{// Right Zone
        p = new Puck( this.window_width - (this.marge + this.puckRadius + this.thickness), this.window_height - (this.marge + ((i-mod) * this.puckRadius)), this.puckRadius);
      }
      println(i + " : "+p.x+"/"+p.y);
      pucks.add(p);
    }
    
    for(Puck p : pucks){
      SMT.add(p);
    }
    
    println("nb pucks" + pucks.size());
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
  }
  
}
