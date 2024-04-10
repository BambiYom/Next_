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

//All sounds
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
SoundFile musicianBanger;

//Camera Tracking Related
int prevY = -1000;
int prevX;
float camX;
float camY;
int storedW;

//Gameplay Related
int jumpDelay;
int atkDelay;
int minSize = 50;
int curPage = 0;
int energyCharge = 0;
int chargingMax;
int playerHealth = 10;
int brokenHearts = 0;

//Gifs and Animations
Gif Opening;
Gif Talking;
Gif Grandma;
Gif jumpIcon;
Gif bigJump;
Movie gameoverScene;
Movie sadScene;

//Images
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

//Game States
boolean Calibrate = true;
boolean Start = false;
boolean Lore = false;
boolean Instruction = false;
boolean Game = false;

// Everything related to talking
Dialogue lore;
Dialogue defeat;

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
boolean scene6Time = true;
boolean goodEnding = false;
boolean Death = false;
boolean firstDeath = true;
boolean Defeat = false;
boolean sadness = false;
boolean sad1 = true;
boolean sad2 = false;
boolean sadnessTime = true;
boolean train = false;

// Pause and Calibration Variables
boolean pauseCounter = true;
boolean firstCalibration = true;
Timer pause;

// Anything related to the Suitors Stats
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

// Boss Fight Initialization
bossFight Granny;
Timer zoneDelay;
boolean initialTimer = true;
int zone = 0;
Timer iFrames;
PImage chargeLeft;
PImage chargeRight;
PImage chargeUp;
PImage chargeDown;
PImage rageLeft;
PImage rageRight;
PImage rageUp;
PImage rageDown;
PImage laserLeft;
PImage laserRight;
PImage laserUp;
PImage laserDown;
PImage Grandma1;
PImage Grandma2;
PImage Grandma3;
PImage Grandma4;
PImage Grandma5;

PFont Deltarune; // font from deltarune

  // Timer Initialization
Timer autoScroll;
Timer holdCalibration;

// Text appearing related
int speed = 2;
int index = 0;



void setup() {
  size(1920,1080); //Setup Size
  background(100, 50 , 50); //Loading Screen default Colour
  // Populate an array with a list of available capture devices
  String[] cameras = Capture.list();
  // Initialize the camera object using the first element of the list denoted by cameras[0]
  cam = new Capture(this, cameras[0]);
  
  //Initializing all the sounds here
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
  musicianBanger = new SoundFile(this, "Suitor_1_Draft.mp3");
  
  // ALL Image Initialization
  Opening = new Gif(this, "Title.gif");
  Talking = new Gif(this, "FinalHead.gif");
  Grandma = new Gif(this, "Grandma.gif");
  jumpIcon = new Gif(this, "jumpIcon.gif");
  bigJump = new Gif(this, "Big Jump.gif");
  gameoverScene = new Movie(this, "TempGameOver.mp4");
  sadScene = new Movie(this, "Sad.mp4");
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
  
  // Dialogue Initialization
  lore = new Dialogue();
  defeat = new Dialogue();
  
  //Timer Initalization
  autoScroll = new Timer(5000);
  pause = new Timer(3125);
  holdCalibration = new Timer(3000);
  attack = new Timer(5000);
  
  //Boss initalization
  Granny = new bossFight();
  zoneDelay = new Timer(6100);
  iFrames = new Timer(4500);
  chargeLeft = loadImage("demonheart_left.png");
  chargeRight = loadImage("demonheart_right.png");
  chargeUp = loadImage("demonheart_up.png");
  chargeDown = loadImage("demonheart_down.png");
  rageLeft = loadImage("demonheart_rage_left.png");
  rageRight = loadImage("demonheart_rage_right.png");
  rageUp = loadImage("demonheart_rage_up.png");
  rageDown = loadImage("demonheart_rage_down.png");
  laserLeft = loadImage("laser_left.png");
  laserRight = loadImage("laser_right.png");
  laserUp = loadImage("laser_up.png");
  laserDown = loadImage("laser_down.png");
  Grandma1 = loadImage("grandma1.png");
  Grandma2 = loadImage("grandma2.png");
  Grandma3 = loadImage("grandma3.png");
  Grandma4 = loadImage("grandma4.png");
  Grandma5 = loadImage("grandma5.png");
  
  //Setting the game Font
  Deltarune = createFont("undertale-deltarune-text-font-extended.ttf", 64);
  textFont(Deltarune);
  // Setting the frameRate for playbacks
  frameRate(30);
   // Start capturing the images from the camera
  cam.start();

  // Initialize the OpenCV object with the same dimensions as the webcam image
  opencv = new OpenCV(this, cam.width, cam.height);
  
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);
  
  // Create new suitor classes
  Musician = new suitor(Suitor1, atkSpeed1, 1, 4);
  Rich = new suitor(Suitor2, atkSpeed2, 1, 8);
  Romantic = new suitor(Suitor3, atkSpeed3, 1, 50);
  
  //Set the playing behaviour of all playbacks
  Opening.loop();
  Talking.loop();
  jumpIcon.loop();
  introSong.loop();
  Grandma.loop();
  bigJump.loop();
  //Set volumes
  Bedroom.amp(0.5);
  musicianBanger.amp(0.5);
}
void draw() {
  //Handle all the gameStates here
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
  
  if (Defeat) {
    defeatScreen();
  }
  
  if (Death){
    deathScreen();
  }
}

void calibrate(){ // State where we check if you are standing in the proper location
  image(calibrateIns, 0, 0); // Set the background to the Calibration Instruction Screen
  if (cam.available() == true) { // Check if Camera is available
  cam.read();
  }
  imageMode(CENTER);
  image(cam, width / 2, height / 2, cam.width, cam.height); //Display Camera
  imageMode(CORNER);
  
  if (calibrated()){ //Function to check if calibrated than it changes states
    Calibration.play();
    Calibrate = false;
    Start = true;
  }
}

void startScreen(){ // State where we introduce the game title
  image(Opening,0,0, 1920, 1080); // Sets background
  if (Jump()) { //Checks for jumps if jumped than it changes states
    introSong.pause();
    Bedroom.loop();
    Start = false;
    Lore = true;
  }
}

void loreScreens(){ // State where all of the initial Dialogue happens
  switch (lore.curScene){
  /* Key Functions for the Dialogue Class:
        .sound(soundFile) is used before display scene to start all the sounds that should be played in the scene
        .displayScene(Picture of Person, Dialogue, Name of Person, Background Image) is used to setup the scene what they should say who is saying and where
        .moveScene(newScene) changes and resets dialogue states and changes the current scene
        .endLore() changes the state from Lore to Game
        For more information check the Dialogue Class File*/
    case 1:
    lore.sound(Dialogue1);
    lore.displayScene(Talking,"Phew finally back in my dorm room.", "MOM", Location);
    lore.moveScene(2);
    break;
    case 2:
    lore.sound(Dialogue2);
    lore.displayScene(Talking,"Huh a box from back home just arrived!", "MOM", Box);
    lore.moveScene(3);
    break;
    case 3:
    lore.sound(boxOpen);
    lore.sound(Dialogue3);
    lore.displayScene(Talking, "'dont fall in love' huh", "MOM", openBox);
    lore.moveScene(4);
    break;
    case 4:
    lore.playMovie(sadScene);
    lore.moveScene(5);
    break;
    case 5:
    lore.displayScene(Talking, "I always had to maintain my family honour.", "MOM", sadScene);
    lore.moveScene(6);
    break;
    case 6:
    lore.displayScene(Talking, "Eventually I got admitted to university far away", "MOM", sadScene);
    lore.moveScene(7);
    break;
    case 7:
    lore.displayScene(Grandma, "I just wanted to say one thing to you before you leave…", "GRANDMA", Train);
    lore.moveScene(8);
    break;
    case 8:
    lore.displayScene(Grandma, "Just because I'm not there...", "GRANDMA", Train);
    lore.moveScene(9);
    break;
    case 9:
    lore.displayScene(Grandma, "Does not mean you can fall in love.", "GRANDMA", Train);
    lore.moveScene(10);
    break;
    case 10:
    lore.displayScene(Grandma, "Also, don't forget...", "GRANDMA", Train);
    lore.moveScene(11);
    break;
    case 11:
    lore.displayScene(Grandma, "I'm going to visit you after your classes end.", "GRANDMA", Train);
    lore.moveScene(12);
    break;
    case 12:
    lore.displayScene(Talking, "Yes, Mother...", "MOM", Train);
    lore.exitLore();
    break;
  }
}

void instructionScreen(){
  fill(0);
  rect(0,0, width, height); // Fill the screen with a black wall
  /* General Structure:
        Scene State set by if (Scene#)
        displayText(Dialogue, xPos, yPos) Function types out the text at the speed of 2 words
        if(scene#Time) is the first time autoscroll starter so its not reset continuously
        display any other elements in between here
        if(autoScroll.isFinised()) changes the scene state
        For more information about displayText() look around lines 900-1000*/
  if (Scene1) { 
    fill(255);
    displayText("In this game you fill up the charge bar by jumping", 400, 900); 
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
          musicianBanger.loop();
          Scene1 = true;
          scene4Time = true;
          Scene4 = false;
          Instruction = false;
          Game = true;
        }
  }
}

void defeatScreen(){
  /* Whenever a suitor is defeated this dialogue is played
      Structure is similar to Lore Dialogue Class*/
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
    if (scene5Time) {
      Bedroom.loop();
      autoScroll.start();
      scene5Time = false;
    }
    displayText("But will you at least buy my latest single!", 600, 900);
    image(jumpIcon, 1800, 1000);
    if (autoScroll.isFinished()){ // Key Difference from Lore is that you will return to the game and your brokenHeart count increments
      MusicianDialogue = false;
      suitor1 = false;
      suitor2 = true;
      index = 0;
      musicianBanger.pause();
      Defeat = false;
      Game = true;
      brokenHearts++;
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
    if (autoScroll.isFinished()){ // Key Difference from Lore is that you will return to the game and your brokenHeart count increments
      index = 0;
      RichDialogue = false;
      romanticBanger.loop();
      Defeat = false;
      Game = true;
      brokenHearts++;
      suitor2 = false;
      suitor3 = true;
    }
  }
}

void gameScreen(){
  image(gameBG,0,0); //Sets Background
  image(suitorHealthBar, width / 2 - 125, 110, 277, 108); // Adds the Healthbar for the suitors
  fill(0);
  rect(0, 800, 1920, 280); //Creates the bottom black bar as a background for graphical elements
  noStroke();
  fill(131, 222, 241);
  rect(0, height- 269, 269, 269); //Fills the back of the Player Healthbar
  if (Jump() && !pauseCounter){ // Whenever there's a jump and the came is not paused energy is incremented 20
    energyCharge = energyCharge + 20;
  }
  chargingMax = constrain(energyCharge, 0, 100); // Constrains the bar to 100 max
  fill(chargingMax, 0, 255 - chargingMax); // Changes the colour of the bar according to the amount of charge
  rect(0, 872 - 105, chargingMax * 20, 25); // draws the bar
  image(Bolt, 5, 730, 30, 30); // Draws the bolt symbol beside the charge bar
  image(chargeBar, 0, 760, 1920, 40); // Draws the charge bar on top of the charge
    if (brokenHearts == 0){ // if no broken hearts than its an angry face
    image(angyFace, 0, height - 259, 259,259);
  }
  if (brokenHearts == 1){  // if one broken heart than its a happy face
    image(happyFace, 0, height - 259, 259,259);
  }
  if (brokenHearts == 2){ // if two broken hearts than its an excited face
    image(excitedFace,0, height - 259, 259,259);
  }
  image(momFrame,0, height - 269, 269, 269); // Healthbar Frame for mom
  // Display the webcam image
  cameraTrack(); // Display your face's position in the bottom right corner
  momHealthbar(); //display your current health
  
    if (suitor1) { //states about which suitor you are facing right now
    Suit1();
  }
  if (suitor2) {
    Suit2();
  }
  if (suitor3) {
    Suit3();
  }
  
  //image(jumpIcon, width - 330, 1000);
}

void Suit1(){
  /* General Structure of Suitors:
        Suitor.display(x, y, */
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
  
  pauseCountdown();
  
  if (firstAtk && pause.isFinished()){
    attack = new Timer(Musician.atk()[0]);
    attack.start();
    firstAtk = false;
  }
  if (Musician.isDead()){
      pauseCounter = true;
      musicianBanger.pause();
      heartShatter.play();
      MusicianDialogue = true;
      Game = false;
      Defeat = true;
  }
  curSize = lerp(curSize, curSize + ((millis()- attack.giveTime()) / 2), 0.2);
  if (attack.isFinished() && pause.isFinished()){
    kyaSound();
    if (playerHealth > 0) {
      playerHealth--;
      if (playerHealth == 0){
        deathCheck();
      }
    } 
    attack.start();
  }
  if (!Musician.isDead() && pause.isFinished()){
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
  
  pauseCountdown();
  
  if (firstAtk && pause.isFinished()){
    attack = new Timer(Rich.atk()[0]);
    attack.start();
    firstAtk = false;
  }
  if (Rich.isDead()){
      pauseCounter = true;
      Bedroom.pause();
      heartShatter.play();
      RichDialogue = true;
      Game = false;
      Defeat = true;
  }
  curSize = lerp(curSize, curSize + ((millis()- attack.giveTime())), 0.2);
  if (attack.isFinished() && pause.isFinished()){
    kyaSound();
    if (playerHealth > 0) {
      playerHealth--;
      if (playerHealth == 0){
        deathCheck();
      }
    } 
    attack.start();
  }
  if (!Rich.isDead() && pause.isFinished()){
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
  
  pauseCountdown();
  
  if (firstAtk && pause.isFinished()){
    attack = new Timer(Romantic.atk()[0]);
    attack.start();
    firstAtk = false;
  }
  if (Romantic.isDead()){
      heartShatter.play();
      RomanticDialogue = true;
      Game = false;
      Defeat = true;
  }
  curSize = lerp(curSize, curSize + ((millis()- attack.giveTime())), 0.2);
  if (attack.isFinished() && pause.isFinished()){
    kyaSound();
    if (playerHealth > 0) {
      playerHealth--;
      if (playerHealth == 0){
        brokenHearts = 3;
        goodEnding = true;
        deathCheck();
      }
    } 
    attack.start();
  }
  if (!Romantic.isDead() && pause.isFinished()){
    imageMode(CENTER);
    image(heart, width /2, height /2 , curSize, curSize);
    imageMode(CORNER);
  }
}

void deathScreen(){
  if (goodEnding){ //Currently Nullpointers when you move a little
    if (initialTimer){
      zoneDelay.start();
      zone = Granny.chooseZone();
      initialTimer = false;
    }
    fill(0);
    rect(0,0,width,height);
    if (brokenHearts >= 0){
      for (int z = 0; z < brokenHearts; z++){
        image(broken, (width / 2 - 250) + (z * 75.125), 900, 65.125, 65.125);
      }
    }
    Granny.displayAttack(zone);
    
    if (zoneDelay.isFinished()){
      Granny.damaged();
      zoneDelay.start();
      zone = Granny.chooseZone();
    }
    Granny.displayCharacter();
    Granny.displayGrandma();
    
    if(Granny.detectCollision() && iFrames.isFinished()){
      heartShatter.play();
      if (brokenHearts != 0) {
        brokenHearts--;
      }
      iFrames.start();
      
    } else if (!Granny.detectCollision()){
      //good ending
    }
    fill(0,0,255);
    rect(0, height - 100, 192 * Granny.giveHealth(), 100);
  } else {
      if (Scene1) {
      
        if (firstDeath){
          gameoverScene.play();
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
  if (firstCalibration) {
    holdCalibration.start();
    firstCalibration = false;
  }

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
        stroke(255,0,0);
        strokeWeight(5);
        noFill();
        rect(x + 680, y + 325, 65, 65);
        rectMode(CORNER);
        strokeWeight(1);
        if (w > minSize && w < 65 && faces[i] != null) {
          pauseCountdown();
          if (holdCalibration.isFinished()){
            storedW = w;
            pauseCounter = true;
            return true;
          }
        } else {
          holdCalibration.start();
          pauseCounter = true;
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

void deathCheck(){
    Lore = false;
    Game = false;
    Death = true;
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

void pauseCountdown(){
  if (pauseCounter) {
    pause.start();
    pauseCounter = false;
  }
  if (!pause.isFinished()) {
      fill(0, 120);
      rect(0,0, width, height);
      fill(255, 255);
    if (millis() - pause.giveTime() < 1000) {
      textSize(256);
      text("1", width / 2, height /2);
    } else if (millis() - pause.giveTime() < 2000) {
      text("2", width / 2, height /2);
    } else if (millis() - pause.giveTime() < 3000) {
      text("3", width / 2, height /2);
      attack.start();
    }
  }
  
}

void movieEvent(Movie m) {
  m.read();
}


void keyPressed(){
  if (key == 'm'){
    brokenHearts = 3;
    introSong.stop();
    romanticBanger.play();
    Calibrate = false;
    Death = true;
    goodEnding = true;
  }
}
