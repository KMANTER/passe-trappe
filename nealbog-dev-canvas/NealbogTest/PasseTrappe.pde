import java.io.*;
import java.net.*;
import java.net.Socket;

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
  
  public boolean gameover = false;
  public String winner;
  
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
  PImage img = loadImage("assets/backgroundTexture.png");
  Timer timer;
  
  void init(){
    this.window_halfWidth = this.window_width / 2;
    this.window_halfHeight = this.window_height / 2;
    
    //create corners
    topLeftCorner = new PVector(this.marge, this.thickness);
    topMiddleCorner = new PVector(this.window_halfWidth - (this.thickness / 2), this.thickness);
    topRightCorner = new PVector( window_width - this.marge, this.thickness);
    
    middleTopCorner = new PVector(this.window_halfWidth - (this.thickness / 2), this.window_halfHeight - (level));
    middleBottomCorner = new PVector(this.window_halfWidth + (this.thickness / 2), this.window_halfHeight + (level));
    
    bottomLeftCorner = new PVector( this.marge, window_height - this.thickness);
    bottomMiddleCorner = new PVector(this.window_halfWidth + (this.thickness / 2), window_height - this.thickness);
    bottomRightCorner = new PVector( window_width - this.marge, window_height - this.thickness);

    //create walls
    walls = new Vector<Wall>();
    walls.add( new Wall( topLeftCorner, topMiddleCorner, this));
    walls.add( new Wall( topMiddleCorner, middleTopCorner, this));
    walls.add( new Wall( topMiddleCorner, topRightCorner, this));
    walls.add( new Wall( topRightCorner, bottomRightCorner, this));
    
    walls.add( new Wall( bottomRightCorner, bottomMiddleCorner, this));
    walls.add( new Wall( bottomMiddleCorner, middleBottomCorner, this));
    walls.add( new Wall( bottomMiddleCorner, bottomLeftCorner, this));
    walls.add( new Wall(bottomLeftCorner, topLeftCorner, this));
    
  }
  
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
  
  void stop(){
    physics.terminate = true;
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
  
  public void checkEndGame2P(int seconds_left){
    int cpt_left = 0;
    int cpt_right = 0;
    if(seconds_left > 0){
      for(Puck p : this.getPucks()){
        if(p.position.x < this.window_halfWidth - (this.thickness / 2))
          cpt_left++;
        else if( p.position.x > this.window_halfWidth + (this.thickness / 2))
          cpt_right++;
      }
      if(cpt_left == 10){
        this.gameover = true;
        this.winner = "Player Right wins";
        println("RIGHT WINNER");
      }else if(cpt_right == 10){
        this.gameover = true;
        this.winner = "Player Left wins";
        println("LEFT WINNER");
      }
    }else{
      this.gameover = true;
      if(cpt_left > cpt_right){
        this.winner = "TIME OUT ! \nPlayer Right wins";
      }else if(cpt_right > cpt_left){
        this.winner = "TIME OUT ! \nPlayer Left wins";
      }else{
        this.winner = "TIME OUT ! \nIt's a draw";
      }  
    }
  }

  public void checkEndGame1P(int seconds_left){
    int cpt_right = 0;
    if( seconds_left > 0){
      for(Puck p : this.getPucks()){
        if(p.position.x > this.window_halfWidth - (this.thickness / 2))
          cpt_right++;
      }
      if(cpt_right == 10){
        this.gameover = true;
        int remainTime = 30 - seconds_left;
        this.winner = "You win in \n"+remainTime+"secs";
        println("WINNER");
        
        this.sendToServer("JBAY - " + remainTime);
      }     
    }else{
      this.gameover = true;
      this.winner = "You lose";
      this.sendToServer("JBAY - Lose");
      println("FAILURE");
    }
  }
  
  
  public void sendToServer(String message){
    String host = "localhost";
    /* Define a port */
    int port = 19999;

    StringBuffer instr = new StringBuffer();
    String TimeStamp;
    System.out.println("SocketClient initialized");
    try {
      // Obtain an address object of the server
      InetAddress address = InetAddress.getByName(host);
      // Establish a socket connetion
      Socket connection = new Socket(address, port);
      // Instantiate a BufferedOutputStream object
      BufferedOutputStream bos = new BufferedOutputStream(connection.getOutputStream());

      OutputStreamWriter osw = new OutputStreamWriter(bos, "US-ASCII");

      // Write across the socket connection and flush the buffer ------ (char) 13 is the escape character 
      osw.write(message +  (char) 13);
      osw.flush();
      socket.close();
    }catch(IOException ex){}
    
  }
}
