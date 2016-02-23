interface IState {
  void init();
  void handleInput(InputHandler inputHandler);
  IState update(float delta);
  void draw();
}
