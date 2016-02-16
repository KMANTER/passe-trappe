class GameController {
  private ArrayList<MiniGame> miniGames;
  
  GameController() {
    this.miniGames = new ArrayList<MiniGame>();
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
      
      miniGame.init();
      
      return miniGame;
    } else {
      println("No mini game has been registered!");
      System.exit(0);
      return null;
    }
  }
  
  void addKeyToCurrentPlayer(){}
}
