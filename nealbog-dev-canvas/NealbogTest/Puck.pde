import vialab.SMT.*;

public class Puck extends Zone{
  // Position X Y
  private float x;
  private float y;
  //static fields
  final static String name = "Puck";
  final static float animStepsPerDraw = 0.15;
  final static float maxSpeed = 10;
  final static int defaultRadius = 90;
  final static float initialSpeedBound = 1;
  //fields
  public float radius;
  public float mass;
  public PVector velocity;
  public PVector position;
  //private fields
  private boolean scored;
  private float animation_step;
  private Puck current = null;
  
  //constructor
  public Puck(){
    super(name, 0, 0, defaultRadius * 2, defaultRadius * 2);
    this.radius = defaultRadius;
    this.mass = 1;
    //reset();
  }
  
  public Puck(int x, int y, int radius) {
    super(name, 0, 0, radius * 2, radius * 2);
    this.radius = radius;
    this.mass = 1;
    this.scored = false;
    velocity = new PVector(
      random( -initialSpeedBound, initialSpeedBound),
      random( -initialSpeedBound, initialSpeedBound));
    position = new PVector( x, y);
  }

  public void draw(){
    
    if(!scored){
      //stroke( 255, 255, 255, 50);
      fill( 150, 50, 50, 255);
      ellipse(
        position.x, position.y,
        this.width, this.height);
    } else {
      //stroke( 255, 255, 255, 50 * (1.0 - animation_step));
      fill( 150, 50, 50, 255 * (1.0 - animation_step));
      ellipse(
        position.x, position.y,
        this.width * (1.0 + animation_step),
        this.height * (1.0 + animation_step));
      animation_step += animStepsPerDraw;
      if( animation_step > 1.0){
        //this.reset();
      }
    }
    
  }
  
  public void pickDraw() {
    //if( !scored)
      ellipse(
        position.x, position.y,
        this.width, this.height);
  }
  
  public void touch(){
    this.current = this;
  }
  
  public void update(Touch[] touches){
    if(touches.length == 0) return ;

    Touch touch = touches[0];
    assert( touch != null);

    float dx = touch.x - position.x;
    float dy = touch.y - position.y;

    velocity.x = dx * 2;
    velocity.y = dy * 2;
    
  }

  /*utility functions
  public void reset(){
    scored = false;
    velocity = new PVector(
      random( -initialSpeedBound, initialSpeedBound),
      random( -initialSpeedBound, initialSpeedBound));
    position = new PVector(
      (1200/2) + (int) random(-5, 5),
      (700/2) + (int) random(-5, 5));
    for(vialab.SMT.Touch touch : this.getTouches()){
      touch.unassignZone( this);
    }
  }*/
}
