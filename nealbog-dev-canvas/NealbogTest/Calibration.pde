/*
 * Calibration object. Must be used in order to start a calibration.
 */
public class Calibration {
  /*
   * The test points.
   */
  private PVector[] testPoints;
  
  /*
   * A calibration matrix containing deltas of each test points.
   */
  private PVector[] calibrationMatrix;
  
  /*
   * The mesured points. To be updated with .setMesuredPoint() method.
   */
  private PVector[] mesuredPoints;
  
  /*
   * Width of the window.
   */
  private int windowWidth;
  
  /*
   * Height of the window.
   */
  private int windowHeight;
  
  /*
   * Number of calibrated points.
   */
  private int calibratedPoints;
  
  /*
   * Ctor for Calibration.
   */
  public Calibration(int windowWidth, int windowHeight) {
    this.windowWidth = windowWidth;
    this.windowHeight = windowHeight;
    
    // Default test points.
    PVector[] points = {
      new PVector(0.03 * windowWidth, 0.03 * windowHeight),
      new PVector(0.5 * windowWidth, 0.03 * windowHeight),
      new PVector(0.97 * windowWidth, 0.03 * windowHeight),
      new PVector(0.03 * windowWidth, 0.5 * windowHeight),
      new PVector(0.5 * windowWidth, 0.5 * windowHeight),
      new PVector(0.97 * windowWidth, 0.5 * windowHeight),
      new PVector(0.03 * windowWidth, 0.97 * windowHeight),
      new PVector(0.5 * windowWidth, 0.97 * windowHeight),
      new PVector(0.97 * windowWidth, 0.97 * windowHeight),
      new PVector(0.25 * windowWidth, 0.25 * windowHeight),
      new PVector(0.25 * windowWidth, 0.75 * windowHeight),
      new PVector(0.75 * windowWidth, 0.25 * windowHeight),
      new PVector(0.75 * windowWidth, 0.75 * windowHeight)
    };
    
    testPoints = points;
    calibrationMatrix = new PVector[testPoints.length];
    mesuredPoints = new PVector[testPoints.length];
    
    calibratedPoints = 0;
  }
  
  /*
   * Returns a vector that must be apply on a touch to get it calibrated.
   * @returns PVector fixingVector.
   */
  public PVector getFixingVector(float x, float y) {
    if (!isCalibrationOver()) return new PVector(0, 0);
    PVector p = new PVector(x, y);
    int closest = getClosestCalibrationPoint(p);
    PVector toApply = new PVector();
    PVector refPoint = mesuredPoints[closest];
    float tmp = .0f;

    if (p.x < refPoint.x) {
      tmp = (abs((p.x % refPoint.x + refPoint.x) / refPoint.x) % 1);
    } else {
      tmp = (abs((p.x % refPoint.x - refPoint.x) / refPoint.x) % 1);
    }
    toApply.x = calibrationMatrix[closest].x * tmp;
  
    if (p.y < refPoint.y) {
      tmp = (abs((p.y % refPoint.y + refPoint.y) / refPoint.y) % 1);
    } else {
      tmp = (abs((p.y % refPoint.y - refPoint.y) / refPoint.y) % 1);
    }
    toApply.y = calibrationMatrix[closest].y * tmp;

    return toApply;
  }
  
  /*
   * Return the closest test points of the given PVector.
   */
  private int getClosestCalibrationPoint(PVector p) {
    int closest = 0;
    for (int i = 0; i < testPoints.length; i++) {
      if (p.dist(testPoints[closest]) > p.dist(testPoints[i])) {
        closest = i;
      } 
    }
    return closest;
  }
  
  /*
   * Returns true if the calibration is over.
   */
  public boolean isCalibrationOver() {
    return calibratedPoints == testPoints.length;
  }
  
  /*
   * Method used in order to get the current test points that must be draw.
   * @returns PVector currentTestPoint.
   */
  public PVector getCurrentTestPoint() {
    if (isCalibrationOver()) return testPoints[testPoints.length - 1]; 
    return testPoints[calibratedPoints];
  }
  
  /*
   * Method used in order to set the mesured point of the current test.
   */
  public void setMesuredPoint(PVector p) {
    if (isCalibrationOver()) return;
    
    mesuredPoints[calibratedPoints] = p;
    calibrationMatrix[calibratedPoints] = PVector.sub(testPoints[calibratedPoints], p);
    calibratedPoints += 1;
  }
  
  /*
   * Method used in order to override the default test points.
   */
  public void setNewTestPoints(PVector[] tests) {
    testPoints = tests;
    calibrationMatrix = new PVector[tests.length];
    mesuredPoints = new PVector[tests.length];
    calibratedPoints = 0;
  }
}
