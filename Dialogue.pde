class Dialogue{
  boolean sceneTime; // Initial Timer Boolean
  int curScene; //Current Scene
  Dialogue(){
    sceneTime = true;
    curScene = 1; 
  }
  void displayScene(Gif face, String text, String name, PImage bg){ // Sets the stage for the scene
    image(bg, 0,0, 1920,1080); // sets background
    fill(0);
    rect(0, 800, 1920, 300); // sets textbox
    fill(255, 244, 85);
    stroke(0);
    rect(50,700,245,270); //sets talking head bg
    image(face, 50, 700, 245,270); // sets talking head
    stroke(255);
    fill(255);
    textSize(64);
    text(name, 95, 1045); //sets person's name
    textSize(32);
    
    displayText(text, 600, 900); // displays text
    image(jumpIcon, 1800, 1000);
  }
  void sound(SoundFile targetSound){ // remember to position this before displayScene
    if (sceneTime){ // plays sound if the scene autoscroll hasn't begun
      targetSound.play();
    }
  }
  void playMovie(Movie file){
    if (sceneTime) { // plays movie if the scene autoscroll hasn't begun
      file.play();
    }
    image(file,0,0,1920,1080); // displays the movie
  }
  void moveScene(int Scene){
    if (sceneTime) { // initial timer
      autoScroll.start();
      sceneTime = false;
    }
    if (autoScroll.isFinished()){ // change scene when timer done
      sceneTime = true;
      index = 0;
      curScene = Scene;
    } 
  }
  void exitLore(){ // change from lore to game
    if (sceneTime) { // initialize timer
      autoScroll.start();
      sceneTime = false;
    }
    if (autoScroll.isFinished()){ // change scene
      sceneTime = true;
      index = 0;
      Lore = false;
      Instruction = true;
      Bedroom.stop();
    }
  }
}
