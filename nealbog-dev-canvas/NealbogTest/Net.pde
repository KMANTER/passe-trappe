public class Net extends Zone {
  //fields
  public int score;
  public int halfWidth;
  public int halfHeight;
  public PVector position;
  //corners and walls
  public Vector<PVector> corners;
  public PVector corner_topLeft;
  public PVector corner_topRight;
  public PVector corner_bottomLeft;
  public PVector corner_bottomRight;
  public Wall wall_left;
  public Wall wall_right;
  public Wall wall_top;
  public Wall wall_bottom;

  //constructor
  public Net( String name, int x, int y, int width, int height){
    super( name, 0, 0, width, height);
    position = new PVector( x, y);
    score = 0;
    this.halfWidth = width / 2;
    this.halfHeight = height / 2;

    corners = new Vector<PVector>();
    corner_topLeft = new PVector( x - halfWidth, y - halfHeight);
    corner_topRight = new PVector( x + halfWidth, y - halfHeight);
    corner_bottomLeft = new PVector( x - halfWidth, y + halfHeight);
    corner_bottomRight = new PVector( x + halfWidth, y + halfHeight);
    corners.add( corner_topLeft);
    corners.add( corner_topRight);
    corners.add( corner_bottomLeft);
    corners.add( corner_bottomRight);
    
    wall_top = new Wall( corner_topLeft, corner_topRight);
    wall_right = new Wall( corner_topRight, corner_bottomRight);
    wall_bottom = new Wall( corner_bottomRight, corner_bottomLeft);
    wall_left = new Wall( corner_bottomLeft, corner_topLeft);
  }

  //smt functions
  public void drawImpl(){
    stroke( 255, 255, 255, 50);
    fill( 50, 150, 200, 255);
    rect( position.x - halfWidth, position.y - halfHeight, width, height);
  }
  public void pickDrawImpl() {
    rect( position.x - halfWidth, position.y - halfHeight, width, height);
  }
  public void touchImpl(){}

  //utility functions
  public boolean touches( Puck puck){
    //check corners
    for( PVector corner : corners){
      if( PVector.sub( corner, puck.position).mag() < puck.radius){
        return true;
      }
    }
    //check walls
    PVector relative = PVector.sub( puck.position, this.position);
    return (
      ( abs( relative.y) < halfHeight) &&
      ( abs( relative.x) < halfWidth + puck.radius));
  }
}
