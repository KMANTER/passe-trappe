final int windowWidth = 1200;
final int windowHeight = 700;

Game game = new Game();

void registerMiniGames() {
  game.registerMiniGame(new PasseTrappe_2());
}

// Subscribe your mini-game here:
void setup() {
  registerMiniGames();
  size(windowWidth, windowHeight, SMT.RENDERER);
  SMT.init(this, TouchSource.AUTOMATIC);
  frameRate(60);
  //game.startCalibration();
  game.start();
}

void draw() {
  this.game.handleInput();
  this.game.update();
  this.game.draw();
}
