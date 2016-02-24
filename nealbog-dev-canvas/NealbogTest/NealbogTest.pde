final int windowWidth = 1200;
final int windowHeight = 700;

Game game;

void registerMiniGames() {
  game.registerMiniGame(new PasseTrappe_1(100, "assets/borderHard.png", false));
}

// Subscribe your mini-game here:
void setup() {
  size(windowWidth, windowHeight, SMT.RENDERER);
  SMT.init(this, TouchSource.AUTOMATIC);
  game = new Game();
  registerMiniGames();
  frameRate(60);
  //game.startCalibration();
  game.start();
}

void draw() {
  this.game.handleInput();
  this.game.update();
  this.game.draw();
}
