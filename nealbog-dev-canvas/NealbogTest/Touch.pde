/*
 * Touch object that contains all the information of a SMT.Touch and of the its calibration.  
 */
public class Touch {
  /*
   * The ID of the touch. Equivalent of smtTouch.cursorID.
   */
  private int ID;
  
  /*
   * The calibrated x.
   */
  private float x;
  
  /*
   * The calibrated y.
   */
  private float y;
  
  /*
   * The vector used in order to fix the position of the smtTouch with the calibration.
   */
  private PVector fixingVector;
  
  /*
   * The SMT.Touch object.
   */
  private vialab.SMT.Touch smtTouch;
  
  /*
   * Ctor for Touch.
   */
  public Touch(vialab.SMT.Touch touch) {
    this(touch, new PVector());
  }
  
  /*
   * Ctor for Touch.
   */
  public Touch(vialab.SMT.Touch touch, PVector fixingVector) {
    smtTouch = touch;
    this.fixingVector = fixingVector;
    ID = touch.cursorID;
    setX(touch.x);
    setY(touch.y);
  }
  
  /*
   * @returns float the calibrated X
   */
  public float getX() {
    return x;
  }
  
  /*
   * @returns float the calibrated Y.
   */
  public float getY() {
    return y; 
  }
  
  /* 
   * This method is used in order to update the x of the touch.
   * The fixing vector is then applied to the parameter.
   */
  public void setX(float x) {
    this.x = x + fixingVector.x;
  }
  
  /* 
   * This method is used in order to update the y of the touch.
   * The fixing vector is then applied to the parameter.
   */
  public void setY(float y) {
    this.y = y + fixingVector.y;
  }
  
  /* 
   * This method is used in order to set the fixing vector.
   * Must not be used!
   */
  public void setFixingVector(PVector v) {
    fixingVector = v;
  }
  
  /*
   * @returns int the ID of the touch.
   */
  public int getID() {
    return ID;
  }
  
  /*
   * @returns PVector the fixing vector.
   */
  public PVector getFixingVector() {
    return fixingVector;
  }
  
  /*
   * @returns long the session ID of the SMT.Touch.
   */
  public long getSessionID() {
    return smtTouch.getSessionID();
  }
}
