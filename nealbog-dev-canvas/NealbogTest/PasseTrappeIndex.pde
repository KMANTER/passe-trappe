//imports
import java.awt.TextArea;
import java.awt.Button;

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
  
  ArrayList<Button> buttons;
  
  Button one_player;
  Button two_player;
  
  Button level_easy;
  Button level_medium;
  Button level_hard;
  
  int btn_width = 120;
  int btn_height = 80;
    
  TextArea title;
  
  int level;
  String path_img;
  boolean choose = false;
  Game game = null;
  
  // Constructor
  PasseTrappeIndex() {
    buttons = new ArrayList<Button>();
  }
  
  void init() {
    img = loadImage("assets/backgroundTexture.png");
    border = loadImage("assets/borderEasy.png");
        
    //Create buttons
    //ButtonZone( name, x, y, width, height, text )
    
    level_easy = new Button("BtnLevelEasy",(window_width / 4) - (btn_width/2), (window_height / 2) - (btn_height), btn_width, btn_height, "Easy");
    level_medium = new Button("BtnLevelMedium", (window_width / 2) - (btn_width/2), (window_height / 2) - (btn_height), btn_width, btn_height, "Medium");
    level_hard = new Button("BtnLevelHard", (window_width - (window_width / 4)- (btn_width/2)), (window_height / 2) - (btn_height), btn_width, btn_height, "Hard");
    
    one_player = new Button("BtnOnePlayer",(window_width / 4) - (btn_width/2), (window_height / 2) + (btn_height), btn_width, btn_height, "One Player");
    two_player = new Button("BtnTwoPlayer",(window_width - (window_width / 4)) - (btn_width/2), (window_height / 2) + (btn_height), btn_width, btn_height, "Two Player");
    
    SMT.add(one_player);
    SMT.add(two_player);
    SMT.add(level_easy);
    SMT.add(level_medium);
    SMT.add(level_hard);
    
    buttons.add(one_player);
    buttons.add(two_player);
    buttons.add(level_easy);
    buttons.add(level_medium);
    buttons.add(level_hard);
    
    println("Buttons : " + buttons.size());
    
    this.clearLevelSelection();
    
  }

  void handleInput(InputHandler inputHandler) {
    if (inputHandler.getTouches().length == 0) return;
    Touch t = inputHandler.getTouches()[0];
    Button click = null;
    for(Button bz : buttons){
      click = this.isOver(t, bz);
      if(click != null) break;
    }
    if(click != null){
      if(click == level_easy){
        this.level = this.EASY;
        this.path_img = "assets/borderEasy.png";
        fill(0);
      }else if(click == level_medium){
        this.level = this.MEDIUM;
        this.path_img = "assets/borderMedium.png";
        fill(50);
      }else if(click == level_hard){
        this.level = this.HARD;
        this.path_img = "assets/borderHard.png";
        fill(100);
      }else if(click == one_player){
        game.registerMiniGame(new PasseTrappe_1());
        choose = true;  
      }else if(click == two_player){
        //game = new PasseTrappe(this.level, this.path_img);
        game.registerMiniGame(new PasseTrappe_2());
        choose = true;
      }
    }
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
    if(choose){
      game.handleInput();
      game.update();
      game.draw(); 
    }
  }
  
  Button isOver(Touch t, ButtonZone btn){
    println("t.x:" + t.getX() + "/ t.y:"+t.getY());
    println("btn.x:" + btn.getX() + "/ btn.y:"+btn.getY());
    if(t.getX() > btn.getX() && t.getX() < btn.getX() + btn_width && t.getY() > btn.getY() && t.getY() < btn.getY() + btn_height){
      return btn;
    }
    return null;
  }
  
  void clearLevelSelection(){
     
  }
}
