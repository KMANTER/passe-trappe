abstract class MiniGame implements IState {
  private GameController gameController;
  
  MiniGame() {}

  public final IState keepOn() {
    return this;
  }
  
  public final IState win() {
    this.addKeyToCurrentPlayer();
    return new MiniGameState(this.gameController);
  }
  
  public final IState lose() {
    return new MiniGameState(this.gameController);
  }
  
  void registerGameController(GameController gameController) {
    this.gameController = gameController;
  }
  
  private void addKeyToCurrentPlayer() {
    if (this.gameController != null) {
      this.gameController.addKeyToCurrentPlayer();
    }
  }
}
