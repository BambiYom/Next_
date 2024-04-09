class Dialogue{
  boolean sceneTime;
  int curScene;
  Dialogue(){
    sceneTime = true;
    curScene = 1;
  }
  void displayScene(Gif face, String text, String name, PImage bg){ 
    image(bg, 0,0, 1920,1080);
    fill(0);
    rect(0, 800, 1920, 300);
    fill(255, 244, 85);
    stroke(0);
    rect(50,700,245,270);
    image(face, 50, 700, 245,270);
    stroke(255);
    fill(255);
    textSize(64);
    text(name, 95, 1045);
    textSize(32);
    
    displayText(text, 600, 900);
    image(jumpIcon, 1800, 1000);
  }
  void sound(SoundFile targetSound){ // remember to position this before displayScene
    if (sceneTime){
      targetSound.play();
    }
  }
  void playMovie(Movie file){
    if (sceneTime) {
      file.play();
    }
    image(file,0,0,1920,1080);
  }
  void moveScene(int Scene){
    if (sceneTime) {
      autoScroll.start();
      sceneTime = false;
    }
    if (autoScroll.isFinished()){
      sceneTime = true;
      index = 0;
      curScene = Scene;
    } 
  }
  void exitLore(){
    if (sceneTime) {
      autoScroll.start();
      sceneTime = false;
    }
    if (autoScroll.isFinished()){
      sceneTime = true;
      index = 0;
      Lore = false;
      Instruction = true;
      Bedroom.stop();
    }
  }
}
