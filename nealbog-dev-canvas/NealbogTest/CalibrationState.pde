public class CalibrationState implements IState {
  private final float WARM_UP = 2000;
  private final String TOO_MANY_TOUCHES = "Too many touches to calibrate!";
   
  private boolean touchLock;
  private boolean isOver;
  
  private float validatedAt;
  private PVector currentTest;
  private Touch currentTouch;
  
  private GameController gameController;
  
  CalibrationState(GameController gameController) {
    this.gameController = gameController;
  }
  
  void init() {
    isOver = false;
    validatedAt = .0f;
  }
  
  void handleInput(InputHandler inputHandler) {
    if (!inputHandler.getCalibration().isCalibrationOver()) {
      currentTest = inputHandler.getCalibration().getCurrentTestPoint();
      if (inputHandler.getTouches().length > 0) {
        currentTouch = inputHandler.getTouches()[0];
      } else {
        touchLock = false;
        validatedAt = .0f;
        currentTouch = null;
      }
    } else {
      touchLock = false;
      isOver = true;
      currentTouch = null;
    }
  }
  
  IState update(float delta) {
    if (isOver) return new MiniGameState(gameController);
    
    if (currentTouch != null) {
      if (validatedAt == .0f) {
        validatedAt = millis() + WARM_UP;
      }
      
      if (validatedAt < millis() && !touchLock) {
        gameController.getInputHandler().getCalibration().
            setMesuredPoint(new PVector(currentTouch.x, currentTouch.y));
        touchLock = true;
        validatedAt = .0f;
      }
    }
    
    return this;
  }
  
  void draw(){
    background(30);
    
    drawPoints();
    drawGrid();
    drawInfos();
  }
  
  void drawPoints() {
    fill(255, 0, 0);
    ellipseMode(CENTER);
    ellipse(currentTest.x, currentTest.y, 50, 50);

    fill(0, 255, 0);
    if (validatedAt != .0f && !touchLock) {
      float ratio = .0f;
      ratio = ((validatedAt - WARM_UP) - millis()) / WARM_UP;
      ellipse(currentTest.x, currentTest.y, 50 * ratio, 50 * ratio);
    }
  }
  
  void drawGrid() {
    stroke(255);
    for(int i = 0; i < windowWidth; i += 50) {
      line(i, 0, i, windowHeight);
    }
    for(int i = 0; i < windowHeight; i += 50) {
      line(0, i, windowWidth, i);
    }
    fill(255, 0, 0);
  }
  
  void drawInfos() {
    for (Touch touch : gameController.getInputHandler().getTouches()) {
      pushStyle();
      noFill();
      stroke(240, 240, 240, 180);
      strokeWeight(8);
      ellipse(touch.x, touch.y, 50, 50);
      popStyle();
    }
  }
}
