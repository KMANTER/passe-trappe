//SMT library imports
import vialab.SMT.*;

Game game = new Game();

void registerMiniGames() {
  game.registerMiniGame(new PasseTrappe());
}

// Subscribe your mini-game here:
void setup() {
  size(1200, 700, SMT.RENDERER);
  registerMiniGames();
  SMT.init(this, TouchSource.AUTOMATIC);
  game.start();
}

void draw() {
  this.game.handleInput();
  this.game.update();
  this.game.draw();
}
