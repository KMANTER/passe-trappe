//imports
import java.awt.TextArea;

//SMT library imports
import vialab.SMT.*;

public class PasseTrappeIndex extends MiniGame {
  
  //constants
  boolean window_fullscreen = false;
  final int window_width = 1200;
  final int window_height = 700;
  public static final int EASY = 140;
  public static final int MEDIUM = 120;
  public static final int HARD = 100;
  
  PImage border = null;
  PImage img = null;
  
  ButtonZone one_player;
  ButtonZone two_player;
  
  ButtonZone level_easy;
  ButtonZone level_medium;
  ButtonZone level_hard;
  
  TextArea title;
  
  int level;
  Game choice;
  
  // Constructor
  PasseTrappeIndex() {
    
  }
  
  void init() {
    img = loadImage("assets/backgroundTexture.png");
    border = loadImage("assets/borderEasy.png");
        
    //Create buttons
    //ButtonZone( name, x, y, width, height, text )
    int btn_width = 120;
    int btn_height = 80;
    
    level_easy = new ButtonZone("BtnLevelEasy",(window_width / 4) - (btn_width/2), (window_height / 2) - (btn_height), btn_width, btn_height, "Easy");
    level_medium = new ButtonZone("BtnLevelMedium", (window_width / 2) - (btn_width/2), (window_height / 2) - (btn_height), btn_width, btn_height, "Medium");
    level_hard = new ButtonZone("BtnLevelHard", (window_width - (window_width / 4)- (btn_width/2)), (window_height / 2) - (btn_height), btn_width, btn_height, "Hard");
    
    one_player = new ButtonZone("BtnOnePlayer",(window_width / 4) - (btn_width/2), (window_height / 2) + (btn_height), btn_width, btn_height, "One Player");
    two_player = new ButtonZone("BtnTwoPlayer",(window_width - (window_width / 4)) - (btn_width/2), (window_height / 2) + (btn_height), btn_width, btn_height, "Two Player");
    
    SMT.add(one_player);
    SMT.add(two_player);
    SMT.add(level_easy);
    SMT.add(level_medium);
    SMT.add(level_hard);
    
    this.clearLevelSelection();
    
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
    textAlign(CENTER);
    text( "Passe Trappe", window_width/2, 100);
  }
  
  void pressBtnOnePlayer(Zone z, Touch t){
     
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
    
  }
  
  void pressBtnTwoPlayer(vialab.SMT.ButtonZone zone, vialab.SMT.Touch touch){
  
  }
  
  void pressBtnLevelEasy(){
    fill(0);
  }
  
  void pressBtnLevelMedium(){
    fill(0);
  }
  
  void pressBtnLevelHard(){
    fill(0);
  }
  
  void clearLevelSelection(){
     
  }
}
