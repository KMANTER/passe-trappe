
//SMT library imports
import vialab.SMT.*;

//constant
int window_width = 1200;
int window_height = 800;



  
void setup() {
  size(1200,700);
  strokeWeight(4);
  fill(0);
}

void draw() {
  background(250);
 if (keyPressed == true) { // If the key is pressed,
    line(20, 20, 80, 80); // draw a line
  } else { // Otherwise,
    rect(40, 40, 20, 20); // draw a rectangle
  }

}





public class Wall extends Zone{
  public PVector a; //one end of the wall
  public PVector b; //the other end of the wall
  public PVector parallel;
  public PVector perpendicular;
  public int halfWidth;
  public int halfHeight;

  public Wall( PVector a, PVector b, ){
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
    rect( a.x - halfWidth, position.y - halfHeight, width, height);
  }
}

