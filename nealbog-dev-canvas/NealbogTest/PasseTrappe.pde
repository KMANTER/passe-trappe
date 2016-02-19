//standard library imports
import java.awt.TextArea;
import java.util.Vector;
//SMT library imports
import vialab.SMT.*;

public class PasseTrappe extends MiniGame {
  
  //constants
  boolean window_fullscreen = false;
  final int window_width = 1200;
  final int window_height = 700;
  public int window_halfWidth;
  public int window_halfHeight;
  final int fps_limit = 60;
  final int puck_count = 10;
  final int thickness = 20;
  final int marge = 150;
  final int puckRadius = 30;
  public static final int EASY = 140;
  public static final int MEDIUM = 120;
  public static final int HARD = 100;
  
  //main variables
  public Vector<Puck> pucks;
  public Vector<Wall> walls;
  Physics physics = new Physics(this);
  
  //corners
  public PVector topLeftCorner;
  public PVector topRightCorner;
  public PVector bottomLeftCorner;
  public PVector bottomRightCorner;
  
  public PVector topMiddleLeftCorner;
  public PVector topMiddleRightCorner;
  public PVector bottomMiddleLeftCorner;
  public PVector bottomMiddleRightCorner;
  
  public PVector middleTopLeftCorner;
  public PVector middleTopRightCorner;
  public PVector middleBottomLeftCorner;
  public PVector middleBottomRightCorner;
  
  PImage border = null;
  PImage img = null;
  
  // Constructor
  PasseTrappe() {
  }
  
  void init() {
    img = loadImage("assets/backgroundTexture.png");
    int level = this.HARD;
    frameRate( fps_limit);
    //strokeWeight(2);
    fill(204, 102, 0);
    
    pucks = new Vector<Puck>();
    this.supplyPuck();
     
    this.window_halfWidth = this.window_width / 2;
    this.window_halfHeight = this.window_height / 2;
    
    //create corners
    topLeftCorner = new PVector(this.marge, this.thickness);
    topMiddleLeftCorner = new PVector(this.window_halfWidth - (this.thickness / 2), this.thickness);
    topMiddleRightCorner = new PVector(this.window_halfWidth + (this.thickness / 2), this.thickness);
    topRightCorner = new PVector( window_width - this.marge, this.thickness);
    
    middleTopLeftCorner = new PVector(this.window_halfWidth - (this.thickness / 2), this.window_halfHeight - (level/2));
    middleTopRightCorner = new PVector(this.window_halfWidth + (this.thickness / 2), this.window_halfHeight - (level/2));
    middleBottomLeftCorner = new PVector(this.window_halfWidth - (this.thickness / 2), this.window_halfHeight + (level/2));
    middleBottomRightCorner = new PVector(this.window_halfWidth + (this.thickness / 2), this.window_halfHeight + (level/2));
    
    bottomLeftCorner = new PVector( this.marge, window_height - this.thickness);
    bottomMiddleLeftCorner = new PVector(this.window_halfWidth - (this.thickness / 2), window_height - this.thickness);
    bottomMiddleRightCorner = new PVector(this.window_halfWidth + (this.thickness / 2), window_height - this.thickness);
    bottomRightCorner = new PVector( window_width - this.marge, window_height - this.thickness);

    //create walls
    walls = new Vector<Wall>();
    walls.add( new Wall( topLeftCorner, topMiddleLeftCorner, this));
    walls.add( new Wall( topMiddleLeftCorner, middleTopLeftCorner, this));
    walls.add( new Wall( middleTopLeftCorner, middleTopRightCorner, this));
    walls.add( new Wall( middleTopRightCorner, topMiddleRightCorner, this));
    walls.add( new Wall( topMiddleRightCorner, topRightCorner, this));
    /*walls.add( new Wall( topMiddleLeftCorner, topRightCorner, this));*/
    
    walls.add( new Wall( topRightCorner, bottomRightCorner, this));
    walls.add( new Wall( bottomRightCorner, bottomMiddleRightCorner, this));
    walls.add( new Wall( bottomMiddleRightCorner, middleBottomRightCorner, this));
    walls.add( new Wall( middleBottomRightCorner, middleBottomLeftCorner, this));
    walls.add( new Wall( middleBottomLeftCorner, bottomMiddleLeftCorner, this));
    walls.add( new Wall( bottomMiddleLeftCorner, bottomLeftCorner, this));

    /*walls.add( new Wall( bottomMiddleRightCorner, bottomLeftCorner, this));*/
    
    walls.add( new Wall( bottomLeftCorner, topLeftCorner, this));
    
    
    /*create nets
    player = new Net( "Player", 0, -window_halfHeight, 50, 400);
    enemy = new Net( "Enemy", -window_width, -window_halfHeight, 50, 400);
    SMT.add( player);
    SMT.add( enemy);
    */
    
    switch(level){
      case EASY:
        border = loadImage("assets/borderEasy.png");
        break;
      case MEDIUM:
        border = loadImage("assets/borderMedium.png");
        break;
      case HARD:
        border = loadImage("assets/borderHard.png");
        break;
      default:
        break;
    }
    
    
    
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
  
  void draw() {
    background(img);
    image(border, 0, 0); // Image position
    elastic();
  }
  
  void elastic(){
    fill(0);
    // test elastic
    rect(marge, 0, 1, window_height); // Left
    rect(window_width - 1 - marge, 0, 1, window_height); // Right
  }
  
  public Vector<Puck> getPucks(){
    return this.pucks;
  }
  
  public Vector<Wall> getWalls(){
    return this.walls;
  }
  
  //functions
  //projection of one onto other
  public PVector projection( PVector one, PVector other){
    PVector result = new PVector( other.x, other.y);
    result.normalize();
    result.mult( one.dot( result));
    return result;
  }
  
  public PVector scale( PVector vector, double scalar){
    PVector result = new PVector( vector.x, vector.y);
    result.x *= scalar;
    result.y *= scalar;
    return result;
  }

}









