class MiniGameState implements IState {
  private GameController gameController;
  private MiniGame miniGame;
  
  public MiniGameState(GameController gameController) {
    this.gameController = gameController;
    this.miniGame = gameController.getRandomMiniGame();
  }
  
  public void init() {
    this.miniGame.init();
  }
  
  public void handleInput(InputHandler inputHandler) {
    this.miniGame.handleInput(inputHandler);
  }
  
  public IState update(float delta) {
    IState newState = this.miniGame.update(delta);
    if (newState.equals(this.miniGame)) {
      return this;
    } else {
      return newState;
    }
  }
  
  public void draw() {
    this.miniGame.draw();
  }
}
