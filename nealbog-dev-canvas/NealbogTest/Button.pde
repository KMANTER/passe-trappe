public class Button{
  public PVector position;
  public boolean isClicked;
  
  private String text;
  private int btn_width = 120;
  private int btn_height = 80;
  
  public Button(){
    this.isClicked = false;
  }
  
  public Button(String text, PVector position){
    this.text = text;
    this.position = position;
    this.isClicked = false;
  } 
  
    public Button(String text, PVector position, int w, int h){
    this.text = text;
    this.position = position;
    this.btn_width = w;
    this.btn_height = h;
    this.isClicked = false;
  } 
 
 
  public PVector getPosition(){
    return this.position;
  }
 
  public boolean isClicked(){
    return this.isClicked;
  }
  
  public void draw(){
    if(this.isClicked()){
      fill(255,255,0);
    }
    rect(this.position.x, this.position.y, this.btn_width, this.btn_height);
    fill(0);
    textSize(18);
    textAlign(CENTER);
    text(this.text, (this.position.x + this.btn_width / 2), (this.position.y + btn_height / 2));
    fill(255);
  }
}
