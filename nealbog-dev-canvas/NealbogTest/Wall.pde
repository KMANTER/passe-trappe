public class Wall {
  public PVector a; //one end of the wall
  public PVector b; //the other end of the wall
  public PVector parallel;
  public PVector perpendicular;
  private PasseTrappe game;

  public Wall(PVector a, PVector b){
    this.a = a;
    this.b = b;
    
    this.parallel = new PVector(
      (float) (b.x - a.x),
      (float) (b.y - a.y));
    this.parallel.normalize();
    
    this.perpendicular = new PVector( -parallel.y, parallel.x);
    this.perpendicular.normalize();
  }
  
  public Wall(PVector a, PVector b, PasseTrappe pt){
    this(a, b);
    this.game = pt;
  }

  public PVector distanceVector( PVector point){
    //vector from a to point
    PVector aToPoint = PVector.sub( point, a);
    //dot product of wall's perpendicular to 
    return game.projection( aToPoint, perpendicular);
  }
}
