//SMT library imports
import vialab.SMT.*;

//constant
int window_width = 1200;
int window_height = 800;
int thickness = 15;
public static final int EASY = 110;
public static final int MEDIUM = 100;
public static final int HARD = 90;

void setup() {
  size(1200,700);
  strokeWeight(4);
  fill(0);
}

void draw() {
  background(50, , 127, 61);
  base();
}

void base(){
  // draw a rectangle( x, y, w, h )
  rect(0, 0, thickness, window_height);
  rect(0, 0, window_width, thickness);
  rect(window_width - thickness, 0, thickness, window_height);
  rect(0, window_height - thickness, window_width, thickness);
  
  rect(window_width / 2, 0, thickness, (window_height/2) - (EASY / 2));
  rect(window_width / 2, (window_height/2 + EASY/2), thickness, (window_height/2) - (EASY / 2));
}

public class Wall extends Zone{
  public PVector a; //one end of the wall
  public PVector b; //the other end of the wall
  public PVector parallel;
  public PVector perpendicular;
  public int halfWidth;
  public int halfHeight;

  public Wall( PVector a, PVector b ){
    this.a = a;
    this.b = b;
    this.parallel = new PVector(
      (float) (b.x - a.x),
      (float) (b.y - a.y));
    this.parallel.normalize();
    this.perpendicular = new PVector(
      -parallel.y, parallel.x);
    this.perpendicular.normalize();
  }
  
  public void drawImpl(){
    stroke( 255, 255, 255, 50);
    fill( 50, 150, 200, 255);
    rect( a.x - halfWidth, a.y - halfHeight, width, height);
  }
}
