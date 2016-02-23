interface IMiniGame {
  void init();
  void handleInput(InputHandler inputHandler);
  IState update(float delta);
  void draw();
  IState keepOn();
  IState win();
  IState lose();
}
