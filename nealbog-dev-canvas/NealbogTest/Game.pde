class Game {
  private IState currentState;
  private IState nextState;
  private GameController gameController;
  private boolean started;
  
  private int currTime, prevTime;
  private float delta; 

  Game() {
    this.started = false;
    this.gameController = new GameController();
  }
  
  void start() {
    this.currentState = new MiniGameState(this.gameController);
    this.nextState = this.currentState;
    this.currentState.init();
    
    this.currTime = this.prevTime = millis();
    
    this.started = true;
  }

  void handleInput() {
    if (this.started) {
      this.currentState.handleInput(this.gameController.getInputHandler());
    }
  }

  void update() {
    this.gameController.getInputHandler().update();
    if (this.started) {
      this.currTime = millis();
      this.delta = (this.currTime - this.prevTime) / 1000.0;
      this.prevTime = this.currTime;
      
      this.nextState = this.currentState.update(this.delta);
    }
  }

  void draw() {
    if (this.started) {
      this.currentState.draw();
      this.endLoop();
    }
  }
  
  public void registerMiniGame(MiniGame miniGame) {
    this.gameController.registerMiniGame(miniGame);
  }

  private void endLoop() {
    if (!this.currentState.equals(this.nextState)) {
      this.nextState.init();
      this.currentState = this.nextState;
    }
  }
  
  public void startCalibration() {
    this.currentState = new CalibrationState(gameController);
    this.nextState = this.currentState;
    this.currentState.init();
    
    this.currTime = this.prevTime = millis();
    
    this.started = true;
  }
}
