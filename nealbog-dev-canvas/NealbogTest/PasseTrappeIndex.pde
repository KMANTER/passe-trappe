//imports
import java.awt.TextArea;
import java.util.ArrayList;

public class PasseTrappeIndex extends MiniGame {
  
  //constants
  boolean window_fullscreen = false;
  final int window_width = 1200;
  final int window_height = 700;
  public static final int EASY = 120;
  public static final int MEDIUM = 110;
  public static final int HARD = 90;
  
  PImage border = null;
  PImage img = null;
  
  Button level_easy;
  Button level_medium;
  Button level_hard;
  Button one_player;
  Button two_player;
    
  int btn_width = 120;
  int btn_height = 80;
  ArrayList<Button> buttons = new ArrayList<Button>();
  
  TextArea title;
  
  int level;
  String path_img;
  boolean choose = false;
  PasseTrappe game = null;
  
  // Constructor
  PasseTrappeIndex() {
  }
  
  void init() {
    img = loadImage("assets/backgroundTexture.png");
    border = loadImage("assets/borderEasy.png");
    
    // Create buttons
    this.level_easy = new Button("Easy", new PVector((window_width / 4) - (btn_width/2), (window_height / 2) - (btn_height)));
    this.level_medium = new Button("Medium", new PVector((window_width / 2) - (btn_width/2), (window_height / 2) - (btn_height)));
    this.level_hard = new Button("Hard", new PVector((window_width - (window_width / 4)- (btn_width/2)), (window_height / 2) - (btn_height)));
    this.one_player = new Button("One Player", new PVector((window_width / 4) - (btn_width/2), (window_height / 2) + (btn_height)));
    this.two_player = new Button("Two Player", new PVector((window_width - (window_width / 4)) - (btn_width/2), (window_height / 2) + (btn_height)));
    
    buttons.add(level_easy);
    buttons.add(level_medium);
    buttons.add(level_hard);
    buttons.add(one_player);
    buttons.add(two_player);
    
    this.clearLevelSelection();
  }

  void handleInput(InputHandler inputHandler) {
    if (inputHandler.getTouches().length == 0) return;
    Touch t = inputHandler.getTouches()[0];
    Button click = null;
    for(Button b : buttons){ // Number of button
      
      click = this.isOver(t, b);
      if(click != null){
        this.clearLevelSelection();
        click.isClicked = true;
        if(click == level_easy){
          this.level = this.EASY;
          this.path_img = "assets/borderEasy.png";
        }else if(click == level_medium){
          this.level = this.MEDIUM;
          this.path_img = "assets/borderMedium.png";
        }else if(click == level_hard){
          this.level = this.HARD;
          this.path_img = "assets/borderHard.png";
        }else if(click == one_player){
          game = new PasseTrappe_1(this.level, this.path_img, true);
          this.game.handleInput(inputHandler);
          this.game.draw();
        }else if(click == two_player){
          game = new PasseTrappe_2(this.level, this.path_img, true);
          this.game.handleInput(inputHandler);
          this.game.draw();
        }
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
    text("Passe Trappe", window_width/2, 100);
    
    for(Button b : buttons){
      b.draw();
    }
  }
  
  Button isOver(Touch t, Button btn){
    if(t.getX() > btn.getPosition().x && t.getX() < btn.getPosition().x + btn_width && t.getY() > btn.getPosition().y && t.getY() < btn.getPosition().y + btn_height){
      return btn;
    }
    return null;
  }
  
  void clearLevelSelection(){
     for(Button b : buttons){
       b.isClicked = false;
     }
  }
}
