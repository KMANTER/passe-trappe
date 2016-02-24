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
  private float animation_step;
  private Puck current = null;
  
  //constructor
  public Puck(){
    super(name, 0, 0, defaultRadius * 2, defaultRadius * 2);
    this.radius = defaultRadius;
    this.mass = 1;
  }
  
  public Puck(int x, int y, int radius) {
    super(name, 0, 0, radius * 2, radius * 2);
    this.radius = radius;
    this.mass = 1;
    velocity = new PVector(
      random( -initialSpeedBound, initialSpeedBound),
      random( -initialSpeedBound, initialSpeedBound));
    position = new PVector( x, y);
  }

  public void draw(){
    fill( 150, 50, 50, 255 * (1.0 - animation_step));
    ellipse(
      position.x, position.y,
      this.width * (1.0 + animation_step),
      this.height * (1.0 + animation_step));
    animation_step += animStepsPerDraw;  
  }
  
  public void pickDraw() {
      ellipse(position.x, position.y, this.width, this.height);
  }
  
  public void touch(){
    this.current = this;
    println("palet touché : "+this);
    vialab.SMT.Touch touch = getActiveTouch(0);
    assert( touch != null);
    float dx = touch.x - position.x;
    float dy = touch.y - position.y;
    velocity.x = dx * 20;
    velocity.y = dy * 20;
  }
  
  public void update(Touch[] touches){
  }

}
