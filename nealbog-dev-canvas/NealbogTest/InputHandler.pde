import vialab.SMT.event.*;
import vialab.SMT.util.*;
import vialab.SMT.*;
import vialab.SMT.swipekeyboard.*;
import vialab.SMT.renderer.*;

/*
 * The InputHandler object that will manage the calibration and the calibrated touches.
 */
public class InputHandler {
  /*
   * The calibration object.
   */
  private Calibration calibration;
  
  /*
   * The touches calibrated.
   */
  private ArrayList<Touch> touches;
  
  /*
   * Ctor for HamajoTouch.
   */
  public InputHandler(int windowWidth, int windowHeight) { 
    touches = new ArrayList<Touch>();
    calibration = new Calibration(1280, 700);
  }
  
  /*
   * Touches calibrated. An array is returned so that it can be used the same way has SMT.getTouches().
   * @returns Touch[] the calibrated touches.
   */
  public Touch[] getTouches() {
    Touch[] aTouches = new Touch[touches.size()];
    for (int i = 0; i < touches.size(); i++) {
      aTouches[i] = touches.get(i);
    }
    
    return aTouches;
  }

  /*
   * This method must be called in the main draw method, before everything.
   * This will update current SMT.Touch with the calibrated data.
   * Nothing will be done if the calibration is not over.
   */
  public void update() {
    vialab.SMT.Touch[] smtTouches = SMT.getTouches();
    if (smtTouches.length == 0 && !touches.isEmpty()) {
      // 0 SMT.Touch on the screen, so emptying touches. 
      touches = new ArrayList<Touch>();
    }

    // If there is at least one touch.
    if (smtTouches.length > 0) {
      removeUnuseTouches();
      
      // Will update already existing touches, and instanciate new ones.
      for (vialab.SMT.Touch smtTouch : smtTouches) {
        boolean updated = false;
        for (int i = 0; i < touches.size(); i++) {
          Touch touch = touches.get(i); 
          if (touch.getID() == smtTouch.cursorID && 
                    touch.getSessionID() == smtTouch.getSessionID()) {
            // This SMT.Touch is already existing in touches, so updating its position.
            touch.setX(smtTouch.x);
            touch.setY(smtTouch.y);
            updated = true;
          } else if (touch.getID() == smtTouch.cursorID &&
                    touch.getSessionID() != smtTouch.getSessionID()) {
            // Same ID found, but not the same sessionID. Removing this touch to instanciate a new one after.
            touches.remove(i);
          }
        }
        
        if (!updated) {
          // The touch has not been updated so instancing a new one.
          PVector v = calibration.getFixingVector(smtTouch.x, smtTouch.y);
          touches.add(new Touch(smtTouch, v));
        }
      }
    }
  }
  
  /*
   * This method will removed all touches that does not exist anymore.
   */
  private void removeUnuseTouches() {
    for (int i = 0; i < touches.size(); i++) {
      boolean stillExisting = false;
      for (vialab.SMT.Touch smtTouch : SMT.getTouches()) {
        if (smtTouch.getSessionID() == touches.get(i).getSessionID()) {
          stillExisting = true;
          break;
        }
      }
      
      if (!stillExisting) {
          touches.remove(i);
        }
    }
  }
  
  /*
   * @returns Calibration the calibration object.
   */
  public Calibration getCalibration() {
    return calibration;
  }
}
