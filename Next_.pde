// import gifAnimation library
import gifAnimation.*;

// Import the OpenCV library
import gab.opencv.*;

// Import the Processing Video library
import processing.video.*;

// Import the Java drawing library (OpenCV uses the Rectangle data type to store detected faces)
import java.awt.*;

// import Processing sound library
import processing.sound.*;

// Create a variable to store the webcam capture
Capture cam;

// Create a variable to store an instance of the OpenCV class
OpenCV opencv;

SoundFile introSong;
SoundFile Calibration;
SoundFile Bedroom;
SoundFile romanticBanger;
SoundFile Jump;
SoundFile Dialogue1;
SoundFile Dialogue2;
SoundFile Dialogue3;
SoundFile Dialogue4;
SoundFile heartShatter;
SoundFile boxOpen;
SoundFile oof1;
SoundFile oof2;
SoundFile oof3;
SoundFile [] oofs;
SoundFile kya1;
SoundFile kya2;
SoundFile kya3;
SoundFile kya4;
SoundFile kya5;
SoundFile kya6;
SoundFile [] kyas;
int prevY = -1000;
int prevX;
float camX;
float camY;
int storedW;
int jumpDelay;
int atkDelay;
int minSize = 50;
int curPage = 0;
int energyCharge = 0;
int chargingMax;
int playerHealth = 10;
int brokenHearts = 0;
Gif Opening;
Gif Talking;
Gif Grandma;
Gif jumpIcon;
Gif bigJump;
Gif gameoverScene;
PImage Train;
PImage Location;
PImage Box;
PImage openBox;
PImage calibrateIns;

PImage happyFace;
PImage angyFace;
PImage excitedFace;
PImage sadFace;
PImage Suitor1;
PImage Suitor2;
PImage Suitor3;
PImage momFrame;
PImage momHealthBar;
PImage suitorHealthBar;
PImage health;
PImage momHealth;
PImage chargeBar;
PImage Bolt;
PImage fist;
PImage gameBG;
PImage suitor1Defeat;
PImage suitor2Defeat;
PImage gameOverTitle;

PImage heart;
PImage broken;
boolean Calibrate = true;
boolean Start = false;
boolean Lore = false;
boolean Instruction = false;
boolean Game = false;

// Everything related to talking
boolean Scene1 = true;
boolean scene1Time = true;
boolean Scene2 = false;
boolean scene2Time = true;
boolean Scene3 = false;
boolean scene3Time = true;
boolean Scene4 = false;
int charTalking = 0;
boolean scene4Time = true;
boolean MusicianDialogue = false;
boolean RichDialogue = false;
boolean RomanticDialogue;
boolean scene5Time = true;
boolean isDead = false;
boolean scene6Time = true;
boolean goodEnding = false;
boolean Death = false;
boolean firstDeath = true;

boolean firstAtk = true;
int atkSpeed1 = 3500;
boolean suitor1 = true;
suitor Musician;
boolean defeatText1 = true;
int atkSpeed2 = 2500;
boolean suitor2 = false;
suitor Rich;
boolean defeatText2 = true;
int atkSpeed3 = 1500;
boolean suitor3 = false;
suitor Romantic;
boolean defeatText3 = true;
Timer attack;


PFont Deltarune; // font from deltarune

  // Timer Initialization
Timer autoScroll;

// Text appearing related
int speed = 2;
int index = 0;

void setup() {
  size(1920,1080);
  background(100, 50 , 50);
  // Populate an array with a list of available capture devices
  String[] cameras = Capture.list();
  // Initialize the camera object using the first element of the list denoted by cameras[0]
  cam = new Capture(this, cameras[0]);
  
  introSong = new SoundFile(this, "a3_intromusic_FINAL-V1.mp3");
  Calibration = new SoundFile(this, "302-CALIBRATION DONE.wav");
  Bedroom = new SoundFile(this, "bedroom-music-v2.mp3");
  Jump = new SoundFile(this, "302-JUMP E.mp3");
  Dialogue1 = new SoundFile(this, "mom-dialogue1.mp3");
  Dialogue2 = new SoundFile(this, "mom-dialogue2.mp3");
  Dialogue3 = new SoundFile(this, "mom-dialogue3.mp3");
  Dialogue4 = new SoundFile(this, "grandma-dialogue1.mp3");
  heartShatter = new SoundFile(this, "302-HEART SHATTER.mp3");
  boxOpen = new SoundFile(this, "box_open.wav");
  oof1 = new SoundFile(this, "302-oof-001.mp3");
  oof2 = new SoundFile(this, "302-oof-002.mp3");
  oof3 = new SoundFile(this, "302-oof-003.mp3");
  oofs = new SoundFile [] {oof1, oof2, oof3};
  kya1 = new SoundFile(this, "302-iza-kyaa-001.mp3");
  kya2 = new SoundFile(this, "302-iza-kyaa-002.mp3");
  kya3 = new SoundFile(this, "302-iza-kyaa-003.mp3");
  kya4 = new SoundFile(this, "302-iza-kyaa-004.mp3");
  kya5 = new SoundFile(this, "302-iza-kyaa-005.mp3");
  kya6 = new SoundFile(this, "302-iza-kyaa-006.mp3");
  kyas = new SoundFile [] {kya1, kya2, kya3, kya4, kya5, kya6};
  romanticBanger = new SoundFile(this, "suitor3-v1.5.mp3");
  
  // ALL Image Initialization
  Opening = new Gif(this, "Title.gif");
  Talking = new Gif(this, "FinalHead.gif");
  Grandma = new Gif(this, "Grandma.gif");
  jumpIcon = new Gif(this, "jumpIcon.gif");
  bigJump = new Gif(this, "Big Jump.gif");
  gameoverScene = new Gif(this, "TempGameOver.gif");
  Train = loadImage("train.png");
  Location = loadImage("LocationSet.png");
  Box = loadImage("Box.png");
  openBox = loadImage("openBox.png");
  calibrateIns = loadImage("calibrate.png");
  angyFace = loadImage("momangry.png");
  happyFace = loadImage("momhappy.png");
  excitedFace = loadImage("momexcited.png");
  sadFace = loadImage("momsad.png");
  heart = loadImage("Heart.png");
  broken = loadImage("broken.png");
  Suitor1 = loadImage("Musician.png");
  Suitor2 = loadImage("Rich.png");
  Suitor3 = loadImage("Romantic.png");
  momFrame = loadImage("momframe.png");
  momHealthBar = loadImage("momhealthbar.png");
  suitorHealthBar = loadImage("suitorhealthbar.png");
  health = loadImage("reddot.png");
  momHealth = loadImage("bluedot.png");
  chargeBar = loadImage("chargebar.png");
  Bolt = loadImage("bolt.png");
  fist = loadImage("fist.png");
  gameBG = loadImage("expbg.png");
  suitor1Defeat = loadImage("suitor1Defeat.png");
  suitor2Defeat = loadImage("suitor2Defeat.png");
  gameOverTitle = loadImage("gameOver.png");
  
  //Timer Initalization
  autoScroll = new Timer(3000);
  
  Deltarune = createFont("undertale-deltarune-text-font-extended.ttf", 64);
  textFont(Deltarune);
  frameRate(30);
   // Start capturing the images from the camera
  cam.start();

  // Initialize the OpenCV object with the same dimensions as the webcam image
  opencv = new OpenCV(this, cam.width, cam.height);
  
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);
  
  
  Musician = new suitor(Suitor1, atkSpeed1, 1, 4);
  Rich = new suitor(Suitor2, atkSpeed2, 1, 8);
  Romantic = new suitor(Suitor3, atkSpeed3, 1, 50);
  
  Opening.loop();
  Talking.loop();
  jumpIcon.loop();
  introSong.loop();
  Grandma.loop();
  bigJump.loop();
  gameoverScene.play();
  Bedroom.amp(0.5);
}
void draw() {
  // Read the new frame from the webcam if available
  if (Calibrate) {
    calibrate();
  }
  
  if (Start) {
    startScreen();
  }
  if (Lore) {
    loreScreens();
  }
  
  if (Instruction) {
    instructionScreen();
  }
  
  if (Game) {
    gameScreen();
  }
  
  if (Death){
    deathScreen();
  }
}

void calibrate(){
  image(calibrateIns, 0, 0);
  if (cam.available() == true) {
  cam.read();
  }
  imageMode(CENTER);
  image(cam, width / 2, height / 2, cam.width, cam.height);
  imageMode(CORNER);
  
  if (calibrated()){
    Calibration.play();
    Calibrate = false;
    Start = true;
  }
}

void startScreen(){
  image(Opening,0,0, 1920, 1080);
  if (Jump()) {
    introSong.pause();
    Bedroom.loop();
    Start = false;
    Lore = true;
  }
}

void loreScreens(){
  if (Scene1) {
    image(Location, 0,0, 1920,1080);
    fill(0);
    rect(0, 800, 1920, 300);
    fill(255, 244, 85);
    stroke(0);
    rect(50,700,245,270);
    image(Talking, 50, 700, 245,270);
    stroke(255);
    fill(255);
    textSize(64);
    text("MOM", 95, 1045);
    textSize(32);
    
    displayText("Phew finally back in my dorm room.", 600, 900);
    image(jumpIcon, 1800, 1000);
    if (scene1Time) {
      Dialogue1.play();
      autoScroll.start();
      scene1Time = false;
    }
    if (autoScroll.isFinished()) {
      index = 0;
      scene1Time = true;
      Scene1 = false;
      Scene2 = true;
    }
  }
  
  if (Scene2) {
    image(Box, 0,0, 1920,1080);
    fill(0);
    rect(0, 800, 1920, 300);
    fill(255, 244, 85);
    stroke(0);
    rect(50,700,245,270);
    image(Talking, 50, 700, 245,270);
    stroke(255);
    fill(255);
    textSize(64);
    text("MOM", 95, 1045);
    textSize(32);
    displayText("Huh a box from back home just arrived!", 600, 900);
    image(jumpIcon, 1800, 1000);
    if (scene2Time) {
      Dialogue2.play();
      autoScroll.start();
      scene2Time = false;
    }
    if (autoScroll.isFinished()) {
      index = 0;
      scene2Time = true;
      Scene2 = false;
      Scene3 = true;
    }
  }
  
  if (Scene3) {
    image(openBox, 0,0, 1920,1080);
    fill(0);
    rect(0, 800, 1920, 300);
    fill(255, 244, 85);
    stroke(0);
    rect(50,700,245,270);
    image(Talking, 50, 700, 245,270);
    stroke(255);
    fill(255);
    textSize(64);
    text("MOM", 95, 1045);
    textSize(32);
    
    displayText("'dont fall in love' huh", 600, 900);
    image(jumpIcon, 1800, 1000);
    if (scene3Time) {
      boxOpen.play();
      Dialogue3.play();
      autoScroll.start();
      scene3Time = false;
    }
    if (autoScroll.isFinished()) { //Temporary to get to game screen
      index = 0;
      scene3Time = true;
      Scene3 = false;
      Scene4 = true;
    }
  } 
  
  if (Scene4) {
    image(Train, 0,0, 1920,1080);
    fill(0);
    rect(0, 800, 1920, 300);
    fill(255);
    stroke(0);      
    rect(50,700,245,270);
    image(Grandma, 50, 700, 245,270);
    stroke(255);
    fill(255);
    textSize(64);
    text("GRANDMA", 95, 1045);
    textSize(32);
    speed = 3;
    displayText("I'm coming to see you after your classes!", 600, 900);
    if (scene4Time) {
      Bedroom.pause();
      Dialogue4.play();
      autoScroll.start();
      scene4Time = false;
    }

    image(jumpIcon, 1800, 1000);
    if (scene4Time) {
      autoScroll.start();
      scene4Time = false;
    }
    if (autoScroll.isFinished()){
      index = 0;
      scene4Time = true;
      Scene4 = false;
      Scene1= true;
      Lore = false;
      Instruction = true;
    }
  }
  if (MusicianDialogue) {
    image(suitor1Defeat,0,0);
    fill(0);
    rect(0, 800, 1920, 300);
    fill(229, 204, 85);
    stroke(0);      
    rect(50,700,245,270);
    image(Suitor1, 50, 700, 245,270);
    stroke(255);
    fill(255);
    textSize(64);
    text("Musician", 95, 1045);
    textSize(32);
    speed = 2;
    displayText("But will you at least buy my latest single!", 600, 900);
    if (scene5Time) {
      autoScroll.start();
      scene5Time = false;
    }

    image(jumpIcon, 1800, 1000);
    if (scene4Time) {
      autoScroll.start();
      scene4Time = false;
    }
    if (autoScroll.isFinished()){
      index = 0;
      MusicianDialogue = false;
      Lore = false;
      Game = true;
      brokenHearts++;
      suitor1 = false;
      suitor2 = true;
    }
  }
  if (RichDialogue) {
    image(suitor2Defeat,0,0);
    fill(0);
    rect(0, 800, 1920, 300);
    fill(144,203,208);
    stroke(0);      
    rect(50,700,245,270);
    image(Suitor2, 50, 700, 245,270);
    stroke(255);
    fill(255);
    textSize(64);
    text("Rich Boy", 95, 1045);
    textSize(32);
    displayText("I guess money can't buy everything ...", 600, 900);
    if (scene6Time) {
      autoScroll.start();
      scene6Time = false;
    }

    image(jumpIcon, 1800, 1000);
    if (scene4Time) {
      autoScroll.start();
      scene4Time = false;
    }
    if (autoScroll.isFinished()){
      index = 0;
      RichDialogue = false;
      romanticBanger.loop();
      Lore = false;
      Game = true;
      brokenHearts++;
      suitor2 = false;
      suitor3 = true;
    }
  }
}

void instructionScreen(){
  fill(0);
  rect(0,0, width, height);
  if (Scene1) {
    fill(255);
    displayText("In this game you fill up the charge bar by jumping", 400, 900);
    imageMode(CENTER);
    
    imageMode(CORNER);
    if (scene1Time) {
      autoScroll.start();
      scene1Time = false;
    }
    image(Bolt, 5, 730, 30, 30);
    image(chargeBar, 0, 760, 1920, 40);
    if (autoScroll.isFinished()){
      jumpDelay = millis();
      index = 0;
      scene1Time = true;
      Scene1 = false;
      Scene2 = true;
    }
  } 
  if (Scene2) {
    fill(255);
    displayText("Try jumping now", 780, 350);
    imageMode(CENTER);
    image(bigJump, width / 2, height / 2, 400, 400);
    imageMode(CORNER);
    image(Bolt, 5, 730, 30, 30);
    image(chargeBar, 0, 760, 1920, 40);
    if (Jump()){
      index = 0;
      Scene2 = false;
      Scene3 = true;
    }
  }
  if (Scene3) {
    if (scene3Time){
      autoScroll.start();
      scene3Time = false;
    }
    fill(255);
    speed = 4;
    displayText("Good Job! Now when the bar gets full you will release an attack", 250, 900);
    Musician.display(width/2, height/2 - 30, 521, 521);
    image(fist, width/2, height/2, random(70, 85), random(70, 85));
    if (autoScroll.isFinished()) {
      index = 0;
      scene3Time = true;
      Scene3 = false;
      Scene4 = true;
    }
  }
  if (Scene4) {
    if (scene4Time) {
      autoScroll.start();
      scene4Time = false;
    }
    fill(255);
    speed = 3;
    displayText("The Objective of the game is to reject suitors by reducing their hp to 0", 200, 900);
    image(suitorHealthBar, width / 2 - 125, 110, 277, 108);
    imageMode(CENTER);
    image(broken, width / 2, height / 2, 400, 400);
    imageMode(CORNER);
    if (autoScroll.isFinished()) {
          speed = 2;  
          index = 0;
          Scene1 = true;
          scene4Time = true;
          Scene4 = false;
          Instruction = false;
          Game = true;
        }
  }
}

void gameScreen(){
  if (isDead) {
    Game = false;
    Death = true;
  }
  image(gameBG,0,0);
  if (suitor1) {
    Suit1();
  }
  if (suitor2) {
    Suit2();
  }
  if (suitor3) {
    Suit3();
  }
  image(suitorHealthBar, width / 2 - 125, 110, 277, 108);
  fill(0);
  rect(0, 800, 1920, 280);
  noStroke();
  fill(131, 222, 241);
  rect(0, height- 269, 269, 269);
  if (Jump()){
    energyCharge = energyCharge + 20;
  }
  chargingMax = constrain(energyCharge, 0, 100);
  fill(chargingMax, 0, 255 - chargingMax);
  rect(0, 872 - 105, chargingMax * 20, 25);
  image(Bolt, 5, 730, 30, 30);
  image(chargeBar, 0, 760, 1920, 40);
    if (brokenHearts == 0){
    image(angyFace, 0, height - 259, 259,259);
  }
  if (brokenHearts == 1){  
    image(happyFace, 0, height - 259, 259,259);
  }
  if (brokenHearts == 2){
    image(excitedFace,0, height - 259, 259,259);
  }
  image(momFrame,0, height - 269, 269, 269);
  // Display the webcam image
  cameraTrack();
  momHealthbar();
  
  //image(jumpIcon, width - 330, 1000);
}

void Suit1(){
  Musician.display(width/2, height/2 - 30, 521, 521);
  float curSize = 65.125;
  if (attacked()){
    oofSound();
    image(fist, width/2, height/2, random(70, 85), random(70, 85));
    Musician.damaged(energyCharge / 20);
    energyCharge = 0;
  }
  for (int i = 0; i < Musician.Health(); i++){
    image(health, width / 2 + (65 * i) - 120, 140, 60, 69);
  }
  if (firstAtk){
    attack = new Timer(Musician.atk()[0]);
    attack.start();
    firstAtk = false;
  }
  if (Musician.isDead()){
      heartShatter.play();
      MusicianDialogue = true;
      Game = false;
      Lore = true;
  }
  curSize = lerp(curSize, curSize + ((millis()- attack.giveTime()) / 2), 0.2);
  if (attack.isFinished()){
    kyaSound();
    if (playerHealth > 0) {
      playerHealth--;
    } else {
      playerHealth = 0;
      isDead = true;
    }
    attack.start();
  }
  if (!Musician.isDead()){
    imageMode(CENTER);
    image(heart, width /2, height /2 , curSize, curSize);
    imageMode(CORNER);
  }
}

void Suit2(){
  Rich.display(width/2, height/2 -30, 521, 521);
  float curSize = 65.125;
  if (attacked()){
    oofSound();
    image(fist, width/2, height/2, random(125, 150), random(125, 150));
    Rich.damaged(energyCharge / 20);
    energyCharge = 0;
  }
  for (int i = 0; i < Rich.Health(); i++){
    image(health, width / 2 + (35 * i) - 120, 140, 30, 69);
  }
  if (firstAtk){
    attack = new Timer(Rich.atk()[0]);
    attack.start();
    firstAtk = false;
  }
  if (Rich.isDead()){
      heartShatter.play();
      RichDialogue = true;
      Game = false;
      Lore = true;
  }
  curSize = lerp(curSize, curSize + ((millis()- attack.giveTime())), 0.2);
  if (attack.isFinished()){
    kyaSound();
    if (playerHealth > 0) {
      playerHealth--;
    } else {
      playerHealth = 0;
      isDead = true;
    }
    attack.start();
  }
  if (!Rich.isDead()){
    imageMode(CENTER);
    image(heart, width /2, height /2 , curSize, curSize);
    imageMode(CORNER);
  }
}

void Suit3(){
  Romantic.display(width/2, height/2 -30, 521, 521);
  float curSize = 25.125;
  if (attacked()){
    oofSound();
    image(fist, width/2, height/2, random(125, 150), random(125, 150));
    Romantic.damaged(energyCharge / 20);
    energyCharge = 0;
  }
  for (int i = 0; i < Romantic.Health(); i++){
    image(health, width / 2 + (5.2 * i) - 120, 140, 4.8, 69);
  }
  if (firstAtk){
    attack = new Timer(Romantic.atk()[0]);
    attack.start();
    firstAtk = false;
  }
  if (Romantic.isDead()){
      heartShatter.play();
      RomanticDialogue = true;
      Game = false;
      Lore = true;
  }
  curSize = lerp(curSize, curSize + ((millis()- attack.giveTime())), 0.2);
  if (attack.isFinished()){
    kyaSound();
    if (playerHealth > 0) {
      playerHealth--;
    } else {
      playerHealth = 0;
      isDead = true;
    }
    attack.start();
  }
  if (!Romantic.isDead()){
    imageMode(CENTER);
    image(heart, width /2, height /2 , curSize, curSize);
    imageMode(CORNER);
  }
}

void deathScreen(){
  if (goodEnding){
  } else {
      if (Scene1) {
      if (firstDeath){
        autoScroll.start();
        firstDeath = false;
      }
      image(gameoverScene,0,0);
      
      if(autoScroll.isFinished()){
        Scene1 = false;
        Scene2 = true;
      }
    }
    if (Scene2) {
      fill(0);
      rect(0,0, width, height);
      imageMode(CENTER);
      image(gameOverTitle, width/2, height /2);
      imageMode(CORNER);
    }
  }
  
}
boolean Jump(){
    if (cam.available() == true) {
    cam.read();
  }
    // Update the OpenCV object with the latest webcam image
  opencv.loadImage(cam);
  

  // Detect faces in the webcam image using the face classifier
  // The detect function returns an array of java.awt.Rectangle objects with the location,
  // width, and height of each detected object.
  Rectangle[] faces = opencv.detect();
  // Loop through all the detected faces
  
  if (faces.length > 0){
    for (int i = 0; i < 1; i++) {
      if (faces[i].width > minSize && faces[i].height > minSize){ // only faces at a minimum size are tracked to make sure false faces don't get picked up
        // Get the coordinates and dimensions of the currently tracked face
        int y = faces[i].y;
        int x = faces[i].x;
        int w = faces[i].width;
        if (prevY == -1000) {
          prevY = y;
          prevX = x;
        }
        camY = lerp(prevY, y, 0.1);
        camX = lerp(prevX, x, 0.1);
        
        if(y < prevY - 35 && faces[i] != null && millis() - jumpDelay >= 550 && w <= storedW + 16 && w >= storedW - 16) { // tracks if you lift your head 40 pixels up
          println("jump");
          Jump.play();
          jumpDelay = millis();
          return true;
        } else if (prevY - 35 < y && y < prevY - 32 && faces[i] != null && millis() - jumpDelay >= 550 && w <= storedW + 16 && w >= storedW - 16){
          
        }
        if (y != 0) {
          prevY = y;
          prevX = x;
        }
      }
    }
  } 
  return false;
}

boolean attacked(){
  if (millis() - atkDelay > 2000 && chargingMax == 100) {
    println("attacked");
    atkDelay = millis();
    return true;
  }
  return false;
}

boolean calibrated(){
  if (cam.available() == true) {
    cam.read();
  }
    // Update the OpenCV object with the latest webcam image
  opencv.loadImage(cam);
  

  // Detect faces in the webcam image using the face classifier
  // The detect function returns an array of java.awt.Rectangle objects with the location,
  // width, and height of each detected object.
  Rectangle[] faces = opencv.detect();
  // Loop through all the detected faces
  if (faces.length > 0){
    for (int i = 0; i < 1; i++) {
      if (faces[i].width > minSize && faces[i].height > minSize){ // only faces at a minimum size are tracked to make sure false faces don't get picked up
        // Get the coordinates and dimensions of the currently tracked face
        int x = faces[i].x;
        int w = faces[i].width;
        int y = faces[i].y;
        rectMode(CENTER);
        rect(x + 680, y + 325, 65, 65);
        rectMode(CORNER);
        if (w > minSize && w < 65 && faces[i] != null) {
          println(faces[i]);
          storedW = w;
          return true;
        }
      }
    }
  } 
  return false;
}


void displayText(String dialogue, int x, int y){ //ChatGPT inspired
    if (index < dialogue.length()) {
    String partialMessage = dialogue.substring(0, index+1); // Incrementally increase the number of characters displayed
    text(partialMessage, x, y);
    index += speed;
  } else if (index == dialogue.length() || index == dialogue.length() + 1) {
    text(dialogue, x, y);
  }
}

void kyaSound(){
    switch(randomSound(kyas.length)){
      case 0:
      kya1.play();
      break;
      case 1:
      kya2.play();
      break;
      case 2:
      kya3.play();
      break;
      case 3:
      kya4.play();
      break;
      case 4:
      kya5.play();
      break;
      case 5:
      kya6.play();
      break;
    }
}

void oofSound(){
    switch(randomSound(oofs.length)){
      case 0:
      oof1.play();
      break;
      case 1:
      oof2.play();
      break;
      case 2:
      oof3.play();
      break;
    }
}

void momHealthbar(){
  fill(72, 64, 88);
  noStroke();
  rect((width / 2 - 250), 851, 42 + (47 *9), 79);
  for (int x = 0; x < playerHealth; x++){
    image(momHealth, (width / 2 - 250) + (47 * x), 856, 42, 74);     
  }
    image(momHealthBar, width / 2 - 270, 810, 497, 136);
  for (int z = 0; z < brokenHearts; z++){
    image(broken, (width / 2 - 250) + (z * 75.125), 950, 65.125, 65.125);
  }
}

int randomSound(int lengthArray){
  int random = int(random(0,lengthArray + 1));
  return random;
}

void cameraTrack(){
  noFill();
  stroke(255);
  rect(width - 269, height - 269, 269, 269);
 
    image(jumpIcon, camX + (width - 269), camY + (height - 269));
}
