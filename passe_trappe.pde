//SMT library imports
import vialab.SMT.*;


//constants
final int window_width = 1200;
final int window_height = 700;
final int thickness = 20;
final int marge = 150;
public static final int EASY = 140;
public static final int MEDIUM = 120;
public static final int HARD = 100;

final int paddleRadius = 50; // Diam: 50

void setup() {
  size(1200,700);
  strokeWeight(2);
  fill(204, 102, 0);
}

void draw() {
  base(this.HARD);
}

void base(int level){
  PImage img;
  img = loadImage("backgroundTexture.png");
  background(img);
  
  // Rectangle(x, y, widht, height) 
  fill(204, 102, 0);
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
  
  ellipse(window_width / 2, window_height/2, paddleRadius, paddleRadius);
  
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
  
  image(border, 0, 0); // Image position
}

