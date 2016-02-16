Game game = new Game();

void registerMiniGames() {
  game.registerMiniGame(new PasseTrappe());
}

// Subscribe your mini-game here:
void setup() {
  registerMiniGames();
  
  game.start();
}

void draw() {
  this.game.handleInput();
  this.game.update();
  this.game.draw();
}
