//SMT library imports
import vialab.SMT.*;

//constant
final int window_width = 1200;
final int window_height = 700;
final int thickness = 20;
final int marge = 150;
public static final int EASY = 140;
public static final int MEDIUM = 120;
public static final int HARD = 100;

final int paddleRadius = 25; // Diam: 50

void setup() {
  size(1200,700);
  strokeWeight(4);
  fill(0);
}

void draw() {
  PImage img;
  img = loadImage("backgroundTexture.png");
  background(img);
  base(HARD);
}

void base(int level){
  fill(204, 80, 0);
  // Rectangle(x, y, widht, height) 
  rect(0, 0, window_width, thickness); // Top
  rect(window_width - thickness, 0, thickness, window_height); // Right
  rect(0, window_height - thickness, window_width, thickness); // Bottom
  rect(0, 0, thickness, window_height); // Left
  
  // Middle block
  rect(((window_width / 2)- (thickness /2)), 0, thickness, (window_height/2 - level/2));
  rect(((window_width / 2)- (thickness /2)), (window_height/2 + (level/2)), thickness, (window_height/2) - (EASY / 2));
  
  fill(0);
  // test elastic
  rect(marge, 0, 1, window_height); // Left
  rect(window_width - 1 - marge, 0, 1, window_height); // Right
  
  PImage border = null;
  switch(level){
    case EASY:
      border = loadImage("borderEasy.png");
      break;
    case MEDIUM:
      border = loadImage("borderMedium.png");
      break;
    case HARD:
      border = loadImage("borderHard.png");
      break;
    default:
      break;
  }
  image(border,0,0);
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
