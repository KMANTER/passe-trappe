public class Elastic extends Wall{
  
  public PVector curve;

  public Elastic(PVector a, PVector b){
    super(a,b);
  }
  
  public Elastic(PVector a, PVector b, PasseTrappe pt){
    super(a, b, pt);
  }
  
  public void editCurve(PVector point){
    this.curve = point;
  }
}
