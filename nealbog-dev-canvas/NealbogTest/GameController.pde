class GameController {
  private ArrayList<MiniGame> miniGames;
  private InputHandler inputHandler;
  
  GameController() {
    this.miniGames = new ArrayList<MiniGame>();
    this.inputHandler = new InputHandler(width, height);
  }
  
  void registerMiniGame(MiniGame miniGame) {
    this.miniGames.add(miniGame);
    println("Registered new mini game: " + miniGame.getClass().getName());
  }
  
  MiniGame getRandomMiniGame() {
    if (this.miniGames.size() != 0) {
      int index = int(random(this.miniGames.size()));
      MiniGame miniGame = this.miniGames.get(index);
      miniGame.registerGameController(this);
      
      return miniGame;
    } else {
      println("No mini game has been registered!");
      System.exit(0);
      return null;
    }
  }
  
  void addKeyToCurrentPlayer(){}
  
  InputHandler getInputHandler() {
    return inputHandler;
  }
}
