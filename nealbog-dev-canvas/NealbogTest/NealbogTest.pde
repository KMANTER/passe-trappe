final int windowWidth = 1280;
final int windowHeight = 700;

Game game;

void registerMiniGames() {
  game.registerMiniGame(new PasseTrappe_2());
}

// Subscribe your mini-game here:
void setup() {
  size(windowWidth, windowHeight, SMT.RENDERER);
  SMT.init(this, TouchSource.AUTOMATIC);
  game = new Game();
  registerMiniGames();
  frameRate(60);
  game.startCalibration();
  //game.start();
}

void draw() {
  this.game.handleInput();
  this.game.update();
  this.game.draw();
<<<<<<< HEAD

}
=======
}
>>>>>>> 23df1ce9c38be84eeefc4c154f5d330c367f4f63
