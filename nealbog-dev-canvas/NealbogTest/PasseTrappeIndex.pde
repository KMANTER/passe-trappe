//imports
import java.awt.TextArea;

//SMT library imports
import vialab.SMT.*;

public class PasseTrappeIndex extends MiniGame {
  
  //constants
  boolean window_fullscreen = false;
  final int window_width = 1200;
  final int window_height = 700;
  
  PImage border = null;
  PImage img = null;
  
  ButtonZone one_player;
  ButtonZone two_player;
  
  TextArea title;
  
  Game choice;
  
  // Constructor
  PasseTrappeIndex() {
    
  }
  
  void init() {
    img = loadImage("assets/backgroundTexture.png");
    border = loadImage("assets/borderEasy.png");
        
    //Create buttons
    //ButtonZone( name, x, y, width, height, text )
    int btn_width = 100;
    int btn_height = 80;
    one_player = new ButtonZone("BtnOnePlayer",(window_width / 4) - (btn_width/2), (window_height / 2) - (btn_height / 2), btn_width, btn_height, "One Player");
    two_player = new ButtonZone("BtnTwoPlayer",(window_width - (window_width / 4)) - (btn_width/2), (window_height / 2) - (btn_height / 2), btn_width, btn_height, "Two Player");
    
    SMT.add(one_player);
    SMT.add(two_player);
    
  }

  void handleInput(InputHandler inputHandler) {
    
  }
  
  IState update(float delta) {
    return keepOn();
  }
  
  void draw() {
    background(img);
    image(border, 0, 0); // Image position
    
    //display title
    textSize(32);
    textAlign( CENTER);
    text( "Passe Trappe", window_width/2, 100);
  }
  
  void pressBtnOnePlayer(Zone z, Touch t){
     
  }
  
  void pressBtnTwoPlayer(Zone z, Touch t){
  
  }
}
