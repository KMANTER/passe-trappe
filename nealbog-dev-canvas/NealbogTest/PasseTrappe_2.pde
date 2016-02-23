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
  
  PImage border = loadImage("assets/borderEasy.png");
  PImage img = loadImage("assets/backgroundTexture.png");
  
  // Constructor
  PasseTrappe_2() {
    this.level = 130;
  }
  
  PasseTrappe_2(int l, String pi) {
    this.level = 140;
    this.img = loadImage(pi);
  }
  
  void init() {
    //strokeWeight(2);
    fill(204, 102, 0);
    
    this.supplyPuck();
     
    this.window_halfWidth = this.window_width / 2;
    this.window_halfHeight = this.window_height / 2;
    
    //create corners
    println("level:"+this.level);
    topLeftCorner = new PVector(this.marge, this.thickness);
    println("topLeftCorner = x:"+this.marge+" , y:"+this.thickness);
    topMiddleCorner = new PVector(this.window_halfWidth - (this.thickness / 2), this.thickness);
    println("topMiddleCorner = x:"+(this.window_halfWidth + (this.thickness / 2))+" , y:"+this.thickness);

    topRightCorner = new PVector( window_width - this.marge, this.thickness);
    println("topRightCorner = x:"+(window_width - this.marge)+" , y:"+this.thickness);

    middleTopCornerL = getmiddleTopCorner();
    println("middleTopCorner = x:"+middleTopCornerL.x+" , y:"+middleTopCornerL.y);
    middleBottomCornerL = getmiddleBottomCorner(); 
    println("middleBottomCorner = x:"+middleBottomCornerL.x+" , y:"+middleBottomCornerL.y);
    
    middleTopCornerR = getmiddleTopCornerR();
    println("middleTopCorner = x:"+middleTopCornerR.x+" , y:"+middleTopCornerR.y);
    middleBottomCornerR = getmiddleBottomCornerR(); 
    println("middleBottomCorner = x:"+middleBottomCornerR.x+" , y:"+middleBottomCornerR.y);
    
    bottomLeftCorner = new PVector( this.marge, window_height - this.thickness);
    println("bottomLeftCorner = x:"+this.marge+" , y:"+(window_height - this.thickness));
    bottomMiddleCorner = new PVector(this.window_halfWidth + (this.thickness / 2), window_height - this.thickness);
    println("bottomMiddleCorner = x:"+(this.window_halfWidth + (this.thickness / 2))+" , y:"+(window_height - this.thickness));
    bottomRightCorner = new PVector( window_width - this.marge, window_height - this.thickness);
    println("bottomRightCorner = x:"+(window_width - this.marge)+" , y:"+(window_height - this.thickness));

    //create walls
    walls.add( new Wall( topLeftCorner, topMiddleCorner, this));
    walls.add( new Wall( topMiddleCorner, middleTopCornerL, this));
    walls.add( new Wall( topMiddleCorner, topRightCorner, this));
    walls.add( new Wall( topRightCorner, bottomRightCorner, this));
    
    walls.add( new Wall( bottomRightCorner, bottomMiddleCorner, this));
    walls.add( new Wall( bottomMiddleCorner, middleBottomCornerL, this));
    walls.add( new Wall( bottomMiddleCorner, bottomLeftCorner, this));
    walls.add( new Wall( bottomLeftCorner, topLeftCorner, this));
    
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
