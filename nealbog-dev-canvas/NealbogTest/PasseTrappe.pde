abstract class PasseTrappe extends MiniGame {
  //constants
  boolean window_fullscreen = false;
  final int window_width = 1200;
  final int window_height = 700;
  public int window_halfWidth = window_width / 2;
  public int window_halfHeight = window_height / 2;
  final int puck_count = 10;
  final int thickness = 20;
  final int marge = 150;
  final int puckRadius = 30;
  int level; 
  
  //main variables
  public Vector<Puck> pucks = new Vector<Puck>();
  public Vector<Wall> walls= new Vector<Wall>();
  Physics physics = new Physics(this);
  
  //corners
  public PVector topLeftCorner;
  public PVector topRightCorner;
  public PVector bottomLeftCorner;
  public PVector bottomRightCorner;
  
  public PVector topMiddleCorner;
  public PVector bottomMiddleCorner;
  
  public PVector middleTopCorner;
  public PVector middleBottomCorner;
  
  PImage border = null;
  PImage img = null;
  Timer timer;
  
  void supplyPuck(boolean multi){
    //Positionning
    for(int i=0; i < 10; i++){
      print(i+"->");
      Puck p;
      int mod = 0;
      
      if(multi)
        mod = i % 2;
      
      if( mod == 0){// Left Zone
        p = new Puck( this.marge + this.puckRadius + this.thickness, this.marge + ((i-mod) * this.puckRadius), this.puckRadius);
      }else{// Right Zone
        p = new Puck( this.window_width - (this.marge + this.puckRadius + this.thickness), this.window_height - (this.marge + ((i-mod) * this.puckRadius)), this.puckRadius);
      }
      println(i + " : "+p.position.x+"/"+p.position.y);
      pucks.add(p);
    }
    
    for(Puck p : pucks){
      SMT.add(p);
    }
    
    println("nb pucks" + pucks.size());
  }
  
  void elastic(){
    fill(0);
    // test elastic
    rect(marge, 0, 1, window_height); // Left
    rect(window_width - 1 - marge, 0, 1, window_height); // Right
  }
  
  public Vector<Puck> getPucks(){
    return this.pucks;
  }
  
  public Vector<Wall> getWalls(){
    return this.walls;
  }
  
  //functions
  //projection of one onto other
  public PVector projection( PVector one, PVector other){
    PVector result = new PVector( other.x, other.y);
    result.normalize();
    result.mult( one.dot( result));
    return result;
  }
  
  public PVector scale( PVector vector, double scalar){
    PVector result = new PVector( vector.x, vector.y);
    result.x *= scalar;
    result.y *= scalar;
    return result;
  }
  
  public PVector getmiddleTopCorner(){
     return new PVector(this.window_halfWidth - (this.thickness / 2), this.window_halfHeight - (this.level/2));
  }
  
  public PVector getmiddleBottomCorner(){
     return new PVector(this.window_halfWidth + (this.thickness / 2), this.window_halfHeight + (this.level/2));
  }
  
    public PVector getmiddleTopCornerR(){
     return new PVector(this.window_halfWidth + (this.thickness / 2), this.window_halfHeight - (this.level/2));
  }
  
  public PVector getmiddleBottomCornerR(){
     return new PVector(this.window_halfWidth - (this.thickness / 2), this.window_halfHeight + (this.level/2));
  }
  
  public void checkEndGame2P(){
    int cptleft = 0;
    int cptright = 0;
    for(Puck p : this.getPucks()){
      if(p.position.x < this.window_halfWidth - (this.thickness / 2))
        cptleft++;
      else if( p.position.x > this.window_halfWidth + (this.thickness / 2))
        cptright++;
    }
    if(cptleft == 10){
      println("RIGHT WINNER");
    }else if(cptright == 10){
      println("LEFT WINNER");
    }
  }

  public void checkEndGame1P(int seconds_left){
    int cptleft = 0;
    if( seconds_left > 0){
      for(Puck p : this.getPucks()){
        if(p.position.x < this.window_halfWidth - (this.thickness / 2))
          cptleft++;
      }
      if(cptleft == 10){
        println("WINNER");
      }     
    }else
      println("FAILURE");
    
  }
}
