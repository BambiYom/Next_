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
SoundFile RichSong;
SoundFile finalBattle;

// Dialogue Sounds
SoundFile Dialogue1;
SoundFile Dialogue2;
SoundFile Dialogue3;
SoundFile Dialogue4;
SoundFile Dialogue5;
SoundFile Dialogue6;
SoundFile Dialogue7;
SoundFile Dialogue8;
SoundFile Dialogue9;
SoundFile Dialogue10;
SoundFile Dialogue11;
SoundFile Dialogue12;
SoundFile Dialogue13;
SoundFile Dialogue14;
SoundFile Dialogue15;
SoundFile Dialogue16;
SoundFile Dialogue17;
SoundFile Dialogue18;
SoundFile Dialogue19;
SoundFile Dialogue20;
SoundFile Dialogue21;
SoundFile Dialogue22;
SoundFile Dialogue23;
SoundFile Dialogue24;
SoundFile Dialogue25;
SoundFile Dialogue26;
SoundFile Dialogue27;
SoundFile Dialogue28;
SoundFile Dialogue29;
SoundFile Dialogue30;
SoundFile Dialogue31;
SoundFile Dialogue32;
SoundFile Dialogue33;
SoundFile Dialogue34;
SoundFile Dialogue35;
SoundFile Dialogue36;
SoundFile Dialogue37;
SoundFile Dialogue38;
SoundFile Dialogue39;
SoundFile Dialogue40;
SoundFile Dialogue41;
SoundFile Dialogue42;
SoundFile Dialogue43;
SoundFile Dialogue44;
SoundFile Dialogue45;
SoundFile Dialogue46;
SoundFile Dialogue47;
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
Gif musTalk;
Gif richTalk;
Gif romTalk;
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
PImage angyBG;
PImage stareBG;
PImage hugBG;
PImage suitor1Defeat;
PImage suitor2Defeat;
PImage gameOverTitle;
PImage gameOverTitle2;

PImage heart;
PImage broken;

//Game States
boolean Calibrate = true;
boolean Start = false;
boolean Lore = false;
boolean Instruction = false;
boolean Game = false;

//Boss Instructions
PImage Instr1;
PImage Instr2;
PImage Instr3;
PImage Instr4;
PImage Instr5;
PImage Instr6;
boolean bossIns = false;

// Everything related to talking
Dialogue lore;
Dialogue defeat;
Dialogue bossTUT;
Dialogue grandma;

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
boolean RomanticDialogue = false;
boolean grandmaDialogue = false;
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
PImage bg;
PImage redCard;
PImage blueCard;
PImage Grandma1;
PImage Grandma2;
PImage Grandma3;
PImage Grandma4;
PImage Grandma5;
PImage rope;
PImage bossHealthBar;
PImage chatBubble;
PImage winScreen;
PImage loseScreen;
SoundFile grandmaHurt;
SoundFile timeTicking;
SoundFile wrongAction;
SoundFile winSound;
SoundFile loseSound;
SoundFile bossBattleBGM;
Gif ropeBurn;
int curCase = 0;
int curRope = 38;
int maxRope = 38;
int hp = 10;
int timer = 0;
boolean showGrandmaDamaged = false;
boolean bossT = false;
int hurtGrandmaDisplayTime = 1000; // milliseconds
int startTime = 0;
int card = 0;

PFont Deltarune; // font from deltarune

// Timer Initialization
Timer autoScroll;
Timer holdCalibration;

// Text appearing related
int speed = 2;
int index = 0;



void setup() {
  size(1920, 1080); //Setup Size
  background(100, 50, 50); //Loading Screen default Colour
  // Populate an array with a list of available capture devices
  String[] cameras = Capture.list();
  // Initialize the camera object using the first element of the list denoted by cameras[0]
  cam = new Capture(this, cameras[0]);

  //Initializing all the sounds here
  introSong = new SoundFile(this, "a3_intromusic_FINAL-V1.mp3");
  Calibration = new SoundFile(this, "302-CALIBRATION DONE.wav");
  Bedroom = new SoundFile(this, "bedroom-music-v2.mp3");
  Jump = new SoundFile(this, "302-JUMP E.mp3");
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
  musicianBanger = new SoundFile(this, "melo.mp3");
  RichSong = new SoundFile(this, "302_-_suitor_2_music_v1.mp3");
  finalBattle = new SoundFile(this, "302 - boss battle music draft v1 (mastered).mp3");

  // ALL Image Initialization
  Opening = new Gif(this, "Title.gif");
  Talking = new Gif(this, "FinalHead.gif");
  musTalk = new Gif(this, "Mus.gif");
  richTalk = new Gif(this, "RichTalk.gif");
  romTalk = new Gif(this, "Romancetalking.gif");
  Grandma = new Gif(this, "Grandma.gif");
  jumpIcon = new Gif(this, "jumpIcon.gif");
  bigJump = new Gif(this, "Big Jump.gif");
  Instr1 = loadImage("bossfight_guide1.png");
  Instr2 = loadImage("bossfight_guide2.png");
  Instr3 = loadImage("bossfight_guide3.png");
  Instr4 = loadImage("bossfight_guide4.png");
  Instr5 = loadImage("bossfight_guide5.png");
  Instr6 = loadImage("bossfight_guide6.png");
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
  angyBG = loadImage("Angy.png");
  stareBG = loadImage("Scene end.png");
  hugBG = loadImage("Crying.png");
  suitor1Defeat = loadImage("suitor1Defeat.png");
  suitor2Defeat = loadImage("suitor2Defeat.png");
  gameOverTitle = loadImage("badending.png");
  gameOverTitle2 = loadImage("goodending.png");
  
  // Dialogue Sounds Initialization
  Dialogue1 = new SoundFile(this, "01-BEDROOM.mp3");
  Dialogue2 = new SoundFile(this, "02-BEDROOM.mp3");
  Dialogue3 = new SoundFile(this, "03-BEDROOM.mp3");
  Dialogue4 = new SoundFile(this, "04-BEDROOM.mp3");
  Dialogue5 = new SoundFile(this, "05-BEDROOM.mp3");
  Dialogue6 = new SoundFile(this, "06-TRAIN.mp3");
  Dialogue7 = new SoundFile(this, "07-TRAIN.mp3");
  Dialogue8 = new SoundFile(this, "08-TRAIN.mp3");
  Dialogue9 = new SoundFile(this, "09-TRAIN.mp3");
  Dialogue10 = new SoundFile(this, "10-TRAIN.mp3");
  Dialogue11 = new SoundFile(this, "11-TRAIN.mp3");
  Dialogue12 = new SoundFile(this, "12-SUITOR 1.mp3");
  Dialogue13 = new SoundFile(this, "13-SUITOR 1.mp3");
  Dialogue14 = new SoundFile(this, "14-SUITOR 1.mp3");
  Dialogue15 = new SoundFile(this, "15-SUITOR 1.mp3");
  Dialogue16 = new SoundFile(this, "16-SUITOR 2.mp3");
  Dialogue17 = new SoundFile(this, "17-SUITOR 2.mp3");
  Dialogue18 = new SoundFile(this, "18-SUITOR 2.mp3");
  Dialogue19 = new SoundFile(this, "19-SUITOR 3.mp3");
  Dialogue20 = new SoundFile(this, "20-SUITOR 3.mp3");
  Dialogue21 = new SoundFile(this, "21-SUITOR 3.mp3");
  Dialogue22 = new SoundFile(this, "22-SUITOR 3.mp3");
  Dialogue23 = new SoundFile(this, "23-SUITOR 3.mp3");
  Dialogue24 = new SoundFile(this, "24-SUITOR 3.mp3");
  Dialogue25 = new SoundFile(this, "25-SUITOR 3.mp3");
  Dialogue26 = new SoundFile(this, "26-SUITOR 3.mp3");
  Dialogue27 = new SoundFile(this, "27-SUITOR 3.mp3");
  Dialogue28 = new SoundFile(this, "28-SUITOR 3.mp3");
  Dialogue29 = new SoundFile(this, "29-SUITOR 3.mp3");
  Dialogue30 = new SoundFile(this, "30-SUITOR 3.mp3");
  Dialogue31 = new SoundFile(this, "31-SUITOR 3.mp3");
  Dialogue32 = new SoundFile(this, "32-SUITOR 3.mp3");
  Dialogue33 = new SoundFile(this, "33-SUITOR 3.mp3");
  Dialogue34 = new SoundFile(this, "34-SUITOR 3.mp3");
  Dialogue35 = new SoundFile(this, "01-POSTFIGHT.mp3");
  Dialogue36 = new SoundFile(this, "02-POSTFIGHT.mp3");
  Dialogue37 = new SoundFile(this, "03-POSTFIGHT.mp3");
  Dialogue38 = new SoundFile(this, "04-POSTFIGHT.mp3");
  Dialogue39 = new SoundFile(this, "05-POSTFIGHT.mp3");
  Dialogue40 = new SoundFile(this, "06-POSTFIGHT.mp3");
  Dialogue41 = new SoundFile(this, "07-POSTFIGHT.mp3");
  Dialogue42 = new SoundFile(this, "08-POSTFIGHT.mp3");
  Dialogue43 = new SoundFile(this, "09-POSTFIGHT.mp3");
  Dialogue44 = new SoundFile(this, "10-POSTFIGHT.mp3");
  Dialogue45 = new SoundFile(this, "11-POSTFIGHT.mp3");
  Dialogue46 = new SoundFile(this, "12-POSTFIGHT.mp3");
  Dialogue47 = new SoundFile(this, "13-POSTFIGHT.mp3");

  // Dialogue Initialization
  lore = new Dialogue();
  defeat = new Dialogue();
  bossTUT = new Dialogue();
  grandma = new Dialogue();
  //Timer Initalization
  autoScroll = new Timer(5000);
  pause = new Timer(3125);
  holdCalibration = new Timer(3000);
  attack = new Timer(5000);

  //Boss initalization
  timeTicking = new SoundFile(this, "302-BOMB FUSE.mp3");
  grandmaHurt = new SoundFile(this, "302-GRANDMA aiya (higher).mp3");
  wrongAction = new SoundFile(this, "302-FAIL (higher).mp3");
  winSound = new SoundFile(this, "302-victory (melody).mp3");
  loseSound = new SoundFile(this, "302-defeat v1.mp3");
  bossBattleBGM = new SoundFile(this, "302 - boss battle music draft v1 (mastered).mp3");
  bg = loadImage("bossbg.png");
  redCard = loadImage("o_card.png");
  blueCard = loadImage("x_card.png");
  Grandma1 = loadImage("grandma_normal.png");
  Grandma2 = loadImage("grandma_mad.png");
  Grandma3 = loadImage("grandma_insane.png");
  Grandma4 = loadImage("grandma_damaged.png");
  Grandma5 = loadImage("grandma_disappointed.png");
  chatBubble = loadImage("chatbubble.png");
  winScreen = loadImage("goodending.png");
  loseScreen = loadImage("badending.png");
  rope = loadImage("rope.png");
  health = loadImage("greendot.png");
  bossHealthBar = loadImage("bosshealthbar.png");
  ropeBurn = new Gif(this, "rope_burnt.gif");
  // repeat for other images
  ropeBurn.loop();
  // adjust sfx volume
  timeTicking.amp(0.1);

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
  musTalk.loop();
  richTalk.loop();
  romTalk.loop();
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
  
  if (bossIns) {
    BossTutorial();
  }

  if (Game) {
    gameScreen();
  }

  if (Defeat) {
    defeatScreen();
  }

  if (Death) {
    deathScreen();
  }
}

void calibrate() { // State where we check if you are standing in the proper location
  image(calibrateIns, 0, 0); // Set the background to the Calibration Instruction Screen
  if (cam.available() == true) { // Check if Camera is available [1]
    cam.read(); //[1]
  }
  imageMode(CENTER);
  image(cam, width / 2, height / 2, cam.width, cam.height); //Display Camera
  imageMode(CORNER);

  if (calibrated()) { //Function to check if calibrated than it changes states
    Calibration.play();
    Calibrate = false;
    Start = true;
  }
}

void startScreen() { // State where we introduce the game title
  image(Opening, 0, 0, 1920, 1080); // Sets background
  if (Jump()) { //Checks for jumps if jumped than it changes states
    introSong.pause();
    Bedroom.loop();
    Start = false;
    Lore = true;
  }
}

void loreScreens() { // State where all of the initial Dialogue happens
  switch (lore.curScene) {
    /* Key Functions for the Dialogue Class:
     .sound(soundFile) is used before display scene to start all the sounds that should be played in the scene
     .displayScene(Picture of Person, Dialogue, Name of Person, Background Image) is used to setup the scene what they should say who is saying and where
     .moveScene(newScene) changes and resets dialogue states and changes the current scene
     .endLore() changes the state from Lore to Game
     For more information check the Dialogue Class File*/
  case 1:
    lore.sound(Dialogue1);
    lore.displayScene(Talking, "Phew, finally back in my dorm room.", "YA CHENG", Location);
    lore.moveScene(2);
    break;
  case 2:
    lore.sound(Dialogue2);
    lore.displayScene(Talking, "Hmm... a package for me?", "YA CHENG", Box);
    lore.moveScene(3);
    break;
  case 3:
    lore.sound(boxOpen);
    lore.sound(Dialogue3);
    lore.displayScene(Talking, "A letter from Mother... 'Don't fall in love', huh...", "YA CHENG", openBox);
    lore.moveScene(4);
    break;
  case 4:
    lore.playMovie(sadScene);
    lore.moveScene(5);
    break;
  case 5:
    lore.sound(Dialogue4);
    lore.displayScene(Talking, "*sigh* Ever since I was young,\nI always had to maintain my family's honour.", "YA CHENG", sadScene);
    lore.moveScene(6);
    break;
  case 6:
    lore.sound(Dialogue5);
    lore.displayScene(Talking, "I thought I'd be trapped under their roof forever,\nbut one day I got admitted to a university far away...", "YA CHENG", sadScene);
    lore.moveScene(7);
    break;
  case 7:
    lore.sound(Dialogue6);
    lore.displayScene(Grandma, "I just wanted to say one thing to you before you leave...", "MOM", Train);
    lore.moveScene(8);
    break;
  case 8:
    lore.sound(Dialogue7);
    lore.displayScene(Grandma, "Just because I'm not there...", "MOM", Train);
    lore.moveScene(9);
    break;
  case 9:
    lore.sound(Dialogue8);
    lore.displayScene(Grandma, "Does not mean you can fall in love.", "MOM", Train);
    lore.moveScene(10);
    break;
  case 10:
    lore.sound(Dialogue9);
    lore.displayScene(Grandma, "And remember...", "MOM", Train);
    lore.moveScene(11);
    break;
  case 11:
    lore.sound(Dialogue10);
    lore.displayScene(Grandma, "I'm coming to visit you after your classes end.", "MOM", Train);
    lore.moveScene(12);
    break;
  case 12:
    lore.sound(Dialogue11);
    lore.displayScene(Talking, "Yes, Mother...", "YA CHENG", Train);
    lore.exitLore();
    break;
  }
}

void instructionScreen() {
  fill(0);
  rect(0, 0, width, height); // Fill the screen with a black wall
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
    if (autoScroll.isFinished()) {
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
    if (Jump()) {
      index = 0;
      Scene2 = false;
      Scene3 = true;
    }
  }
  if (Scene3) {
    if (scene3Time) {
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

void defeatScreen() {
  /* Whenever a suitor is defeated this dialogue is played
   Structure is similar to Lore Dialogue Class*/
  if (MusicianDialogue) {
      switch (defeat.curScene){
        case 1:
        defeat.sound(Dialogue12);
        defeat.displayScene(musTalk, "Hello, beautiful... \nWould you like to be my muse for my next album?",
        "CHANG YING", suitor1Defeat);
        defeat.moveScene(2);
        break;
        case 2:
        defeat.sound(Dialogue13);
        defeat.displayScene(Talking, "Thanks, but I'm not interested.", "YA CHENG", suitor1Defeat);
        defeat.moveScene(3);
        break;
        case 3:
        defeat.sound(Dialogue14);
        defeat.displayScene(musTalk, "*dejected* Could you at least buy my latest single?", "CHANG YING", suitor1Defeat);
        defeat.moveScene(4);
        break;
        case 4:
        defeat.sound(Dialogue15);
        defeat.displayScene(Talking, "No thanks.", "YA CHENG", suitor1Defeat);
        defeat.exitDefeat(1);
        break;
      }
    }
  if (RichDialogue) {
      switch (defeat.curScene){
        case 1:
        defeat.sound(Dialogue16);
        defeat.displayScene(richTalk, "A high-achieving woman like yourself \ndeserves a high-value man like me, no?",
        "SHOU SHAN", suitor2Defeat);
        defeat.moveScene(2);
        break;
        case 2:
        defeat.sound(Dialogue17);
        defeat.displayScene(richTalk, "I could buy anything you could ever want.", "SHOU SHAN", suitor2Defeat);
        defeat.moveScene(3);
        break;
        case 3:
        defeat.sound(Dialogue18);
        defeat.displayScene(Talking, "*hesitant* I... I don't need anything from you.", "YA CHENG", suitor2Defeat);
        defeat.moveScene(4);
        break;
        case 4:
        defeat.sound(Dialogue19);
        defeat.displayScene(richTalk, "I guess money can't buy everything...", "SHOU SHAN", suitor2Defeat);
        defeat.exitDefeat(2);
        break;
      }
  }
  if (RomanticDialogue) {
        switch (defeat.curScene){
        case 1:
        defeat.sound(Dialogue20);
        defeat.displayScene(romTalk, "The way the light catches your face... it's like a painting.",
        "QING LING", suitor2Defeat);
        defeat.moveScene(2);
        break;
        case 2:
        defeat.sound(Dialogue19);
        defeat.displayScene(Talking, "Oh, stop it.", "YA CHENG", suitor2Defeat);
        defeat.moveScene(3);
        break;
        case 3:
        defeat.sound(Dialogue22);
        defeat.displayScene(romTalk, "Ya Cheng, I've been wanting to tell you this for a while.", "QING LING", suitor2Defeat);
        defeat.moveScene(4);
        break;
        case 4:
        defeat.sound(Dialogue22);
        defeat.displayScene(romTalk, "I... I think I'm falling for you", "QING LING", suitor2Defeat);
        defeat.moveScene(5);
        break;
        case 5:
        defeat.sound(Dialogue24);
        defeat.displayScene(Talking, "I... I don't know what to say.", "YA CHENG", suitor2Defeat);
        defeat.moveScene(6);
        break;
        case 6:
        defeat.sound(Dialogue25);
        defeat.displayScene(romTalk, "You don't have to say anything.", "QING LING", suitor2Defeat);
        defeat.moveScene(7);
        break;
        case 7:
        defeat.sound(Dialogue26);
        defeat.displayScene(romTalk, "Just know that I care about you deeply.", "QING LING", suitor2Defeat);
        defeat.moveScene(8);
        break;
        case 8:
        defeat.sound(Dialogue27);
        defeat.displayScene(Talking, "I... I care about you too.", "YA CHENG", suitor2Defeat);
        defeat.moveScene(9);
        break;
        case 9:
        defeat.sound(Dialogue28);
        defeat.displayScene(Talking, "But...", "YA CHENG", suitor2Defeat);
        defeat.moveScene(10);
        break;
        case 10:
        defeat.sound(Dialogue29);
        defeat.displayScene(Grandma, "What...the? What is this?", "MOM", angyBG);
        defeat.moveScene(11);
        break;
        case 11:
        defeat.sound(Dialogue30);
        defeat.displayScene(Talking, "Mom, we...", "YA CHENG", angyBG);
        defeat.moveScene(12);
        break;
        case 12:
        defeat.sound(Dialogue31);
        defeat.displayScene(Grandma, "I can't believe this!", "MOM", angyBG);
        defeat.moveScene(13);
        break;
        case 13:
        defeat.sound(Dialogue32);
        defeat.displayScene(Talking, "I know, mother. I tried...", "YA CHENG", angyBG);
        defeat.moveScene(14);
        break;
        case 14:
        defeat.sound(Dialogue33);
        defeat.displayScene(Grandma, "Tried? That's not good enough!", "MOM", angyBG);
        defeat.moveScene(15);
        break;
        case 15:
        defeat.sound(Dialogue34);
        defeat.displayScene(Grandma, "We need to talk now!", "MOM", angyBG);
        defeat.exitDefeat(3);
        break;
      }
  }
    if (grandmaDialogue){
      switch(grandma.curScene){
        case 1:
        grandma.sound(Dialogue35);
        grandma.displayScene(Grandma, "Is this... really what you desire, my child?",
        "MOM", stareBG);
        grandma.moveScene(2);
        break;
        case 2:
        grandma.sound(Dialogue36);
        grandma.displayScene(Talking, "Yes, mother. I truly love him.", "YA CHENG", stareBG);
        grandma.moveScene(3);
        break;
        case 3:
        grandma.sound(Dialogue37);
        grandma.displayScene(Grandma, "...", "MOM", stareBG);
        grandma.moveScene(4);
        break;
        case 4:
        grandma.sound(Dialogue38);
        grandma.displayScene(Talking, "I know that you're only against this \nbecause you love me and want the best for me.", "YA CHENG", stareBG);
        grandma.moveScene(5);
        break;
        case 5:
        grandma.sound(Dialogue39);
        grandma.displayScene(Talking, "I know that, and I'm very thankful.", "YA CHENG", stareBG);
        grandma.moveScene(6);
        break;
        case 6:
        grandma.sound(Dialogue40);
        grandma.displayScene(Talking, "So please, just once, \ntrust me to make this choice for myself.", "YA CHENG", stareBG);
        grandma.moveScene(7);
        break;
        case 7:
        grandma.sound(Dialogue41);
        grandma.displayScene(Grandma, "...", "MOM", stareBG);
        grandma.moveScene(8);
        break;
        case 8:
        grandma.sound(Dialogue42);
        grandma.displayScene(Grandma, "Okay.", "MOM", hugBG);
        grandma.moveScene(9);
        break;
        case 9:
        grandma.sound(Dialogue43);
        grandma.displayScene(Talking, "?!", "YA CHENG", hugBG);
        grandma.moveScene(10);
        break;
        case 10:
        grandma.sound(Dialogue44);
        grandma.displayScene(Grandma, "Go. Be with him. Before I change my mind.", "MOM", hugBG);
        grandma.moveScene(11);
        break;
        case 11:
        grandma.sound(Dialogue45);
        grandma.displayScene(Talking, "Mother, I… Thank you so much-", "YA CHENG", hugBG);
        grandma.moveScene(12);
        break;
        case 12:
        grandma.sound(Dialogue46);
        grandma.displayScene(Grandma, "You. \nTake care of my foolish daughter for me.", "MOM", hugBG);
        grandma.moveScene(13);
        break;
        case 13:
        grandma.sound(Dialogue47);
        grandma.displayScene(romTalk, "I will do my best, ma'am.", "QING LING", hugBG);
        grandma.exitDefeat(5);
        break;
      }
    }
  }

void gameScreen() {
  image(gameBG, 0, 0); //Sets Background
  image(suitorHealthBar, width / 2 - 125, 110, 277, 108); // Adds the Healthbar for the suitors
  fill(0);
  rect(0, 800, 1920, 280); //Creates the bottom black bar as a background for graphical elements
  noStroke();
  fill(131, 222, 241);
  rect(0, height- 269, 269, 269); //Fills the back of the Player Healthbar
  if (Jump() && !pauseCounter) { // Whenever there's a jump and the came is not paused energy is incremented 20
    energyCharge = energyCharge + 20;
  }
  chargingMax = constrain(energyCharge, 0, 100); // Constrains the bar to 100 max
  fill(chargingMax, 0, 255 - chargingMax); // Changes the colour of the bar according to the amount of charge
  rect(0, 872 - 105, chargingMax * 20, 25); // draws the bar
  image(Bolt, 5, 730, 30, 30); // Draws the bolt symbol beside the charge bar
  image(chargeBar, 0, 760, 1920, 40); // Draws the charge bar on top of the charge
  if (brokenHearts == 0) { // if no broken hearts than its an angry face
    image(angyFace, 0, height - 259, 259, 259);
  }
  if (brokenHearts == 1) {  // if one broken heart than its a happy face
    image(happyFace, 0, height - 259, 259, 259);
  }
  if (brokenHearts == 2) { // if two broken hearts than its an excited face
    image(excitedFace, 0, height - 259, 259, 259);
  }
  image(momFrame, 0, height - 269, 269, 269); // Healthbar Frame for mom
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

void Suit1() {
  /* General Structure of Suitors:
   Suitor#.display(x, y, width, height) this function just displays the suitor
   if (attacked()) is a function that when you get attacked it plays a sound, shows a fist, and mutates their hp variable
   for (int i = 0; i < Musician.Health(); i++) produces the health bar on the screen for the suitors health
   pauseCountDown(); means that after all of these elemnts are displayed if pause hasn't happened yet than it will happen
   if (firstAtk && pause.isFinished())initiates the first attack countdown
   if (Suitor#.isDead()) is a check when the Suitor is dead which is when its health is 0
   if (attack.isFinished() && pause.isFinished()) identifies when the suitor completes an attack with its associated behaviours usually just reducing health to 0 but if health == 0 it will deathCheck()
   attack.start() after an attack is completed to reset the cycle
   curSize = lerp(curSize, curSize + ((millis()- attack.giveTime()) / 2), 0.2); is a function that affects the size of the heart as the suitor charges up an attack
   This applies to all 3 suitors and uses mainly the Suitor class which you can check for more details
   */
  Musician.display(width/2, height/2 - 30, 521, 521);
  float curSize = 65.125;
  if (attacked()) {
    oofSound();
    image(fist, width/2, height/2, random(70, 85), random(70, 85));
    Musician.damaged(energyCharge / 20);
    energyCharge = 0;
  }
  for (int i = 0; i < Musician.Health(); i++) {
    image(health, width / 2 + (65 * i) - 120, 140, 60, 69);
  }

  pauseCountdown();

  if (firstAtk && pause.isFinished()) {
    attack = new Timer(Musician.atk()[0]);
    attack.start();
    firstAtk = false;
  }
  if (Musician.isDead()) {
    pauseCounter = true;
    musicianBanger.pause();
    heartShatter.play();
    MusicianDialogue = true;
    Game = false;
    Defeat = true;
  }
  curSize = lerp(curSize, curSize + ((millis()- attack.giveTime()) / 2), 0.2);
  if (attack.isFinished() && pause.isFinished()) {
    kyaSound();
    if (playerHealth > 0) {
      playerHealth--;
      if (playerHealth == 0) {
        deathCheck();
      }
    }
    attack.start();
  }
  if (!Musician.isDead() && pause.isFinished()) {
    imageMode(CENTER);
    image(heart, width /2, height /2, curSize, curSize);
    imageMode(CORNER);
  }
}

void Suit2() {
  Rich.display(width/2, height/2 -30, 521, 521);
  float curSize = 65.125;
  if (attacked()) {
    oofSound();
    image(fist, width/2, height/2, random(125, 150), random(125, 150));
    Rich.damaged(energyCharge / 20);
    energyCharge = 0;
  }
  for (int i = 0; i < Rich.Health(); i++) {
    image(health, width / 2 + (35 * i) - 120, 140, 30, 69);
  }

  pauseCountdown();

  if (firstAtk && pause.isFinished()) {
    attack = new Timer(Rich.atk()[0]);
    attack.start();
    firstAtk = false;
  }
  if (Rich.isDead()) {
    pauseCounter = true;
    Bedroom.pause();
    heartShatter.play();
    RichSong.pause();
    RichDialogue = true;
    Game = false;
    Defeat = true;
  }
  curSize = lerp(curSize, curSize + ((millis()- attack.giveTime())), 0.2);
  if (attack.isFinished() && pause.isFinished()) {
    kyaSound();
    if (playerHealth > 0) {
      playerHealth--;
      if (playerHealth == 0) {
        deathCheck();
      }
    }
    attack.start();
  }
  if (!Rich.isDead() && pause.isFinished()) {
    imageMode(CENTER);
    image(heart, width /2, height /2, curSize, curSize);
    imageMode(CORNER);
  }
}

void Suit3() {
  Romantic.display(width/2, height/2 -30, 521, 521);
  float curSize = 25.125;
  if (attacked()) {
    oofSound();
    image(fist, width/2, height/2, random(125, 150), random(125, 150));
    Romantic.damaged(energyCharge / 20);
    energyCharge = 0;
  }
  for (int i = 0; i < Romantic.Health(); i++) {
    image(health, width / 2 + (5.2 * i) - 120, 140, 4.8, 69);
  }

  pauseCountdown();

  if (firstAtk && pause.isFinished()) {
    attack = new Timer(Romantic.atk()[0]);
    attack.start();
    firstAtk = false;
  }
  if (Romantic.isDead()) {
    heartShatter.play();
    RomanticDialogue = true;
    Game = false;
    Defeat = true;
  }
  curSize = lerp(curSize, curSize + ((millis()- attack.giveTime())), 0.2);
  if (attack.isFinished() && pause.isFinished()) {
    kyaSound();
    if (playerHealth > 0) {
      playerHealth--;
      if (playerHealth == 0) {
        Game = false;
        RomanticDialogue = true;
        Defeat = true;   
      }
    }
    attack.start();
  }
  if (!Romantic.isDead() && pause.isFinished()) {
    imageMode(CENTER);
    image(heart, width /2, height /2, curSize, curSize);
    imageMode(CORNER);
  }
}

void deathScreen() {
  if (goodEnding) { // when you are defeated at the 3rd Suitor you go here
    new_Boss();
  } else {
    if (Scene1) {

      if (firstDeath) { // Start autoscroll and play the cutscene once
        gameoverScene.play();
        autoScroll.start();
        firstDeath = false;
      }
      image(gameoverScene, 0, 0); // show the animation
      if (autoScroll.isFinished()) { // move scene states
        Scene1 = false;
        Scene2 = true;
      }
    }
    if (Scene2) {
      fill(0);
      rect(0, 0, width, height); //Set a black screen
      imageMode(CORNER);
      image(gameOverTitle, 0, 0); // Gameover Title Card
      imageMode(CORNER);
    }
  }
}
boolean Jump() {
  if (cam.available() == true) { // Check camera availability [1]
    cam.read();
  }
  // Update the OpenCV object with the latest webcam image [1]
  opencv.loadImage(cam);


  // Detect faces in the webcam image using the face classifier
  // The detect function returns an array of java.awt.Rectangle objects with the location,
  // width, and height of each detected object.
  Rectangle[] faces = opencv.detect(); //[1]
  // Loop through all the detected faces

  if (faces.length > 0) {
    for (int i = 0; i < 1; i++) {
      if (faces[i].width > minSize && faces[i].height > minSize) { // only faces at a minimum size are tracked to make sure false faces don't get picked up
        // Get the coordinates and dimensions of the currently tracked face
        int y = faces[i].y; //[1]
        int x = faces[i].x; //[1]
        int w = faces[i].width; //[1]
        if (prevY == -1000) { // Set first prevY and prevX's
          prevY = y;
          prevX = x;
        }
        camY = lerp(prevY, y, 0.1); // attempts to smoothen the experience
        camX = lerp(prevX, x, 0.1); // attempts to smoothen the experience

        if (y < prevY - 35 && faces[i] != null && millis() - jumpDelay >= 550 && w <= storedW + 16 && w >= storedW - 16) { // tracks if you jump
          println("jump");
          Jump.play();
          jumpDelay = millis();
          return true;
        } else if (prevY - 35 < y && y < prevY - 32 && faces[i] != null && millis() - jumpDelay >= 550 && w <= storedW + 16 && w >= storedW - 16) { // behaviour for false jump not fleshed out yet
        }
        if (y != 0) { // set prevY, and prevX
          prevY = y;
          prevX = x;
        }
      }
    }
  }
  return false;
}

boolean attacked() { // checks if attacked
  if (millis() - atkDelay > 2000 && chargingMax == 100) { // if time since delay is greater than 2000 and Charge is 100 you attack
    println("attacked");
    atkDelay = millis();
    return true;
  }
  return false;
}

boolean calibrated() {
  if (cam.available() == true) { // check camera availability [1]
    cam.read();
  }
  // Update the OpenCV object with the latest webcam image
  opencv.loadImage(cam); // [1]
  if (firstCalibration) { //start timer
    holdCalibration.start();
    firstCalibration = false;
  }

  // Detect faces in the webcam image using the face classifier
  // The detect function returns an array of java.awt.Rectangle objects with the location,
  // width, and height of each detected object.
  Rectangle[] faces = opencv.detect();
  // Loop through all the detected faces
  if (faces.length > 0) {
    for (int i = 0; i < 1; i++) {
      if (faces[i].width > minSize && faces[i].height > minSize) { // only faces at a minimum size are tracked to make sure false faces don't get picked up
        // Get the coordinates and dimensions of the currently tracked face
        int x = faces[i].x; //[1]
        int w = faces[i].width; //[1]
        int y = faces[i].y; //[1]
        rectMode(CENTER);
        stroke(255, 0, 0);
        strokeWeight(5);
        noFill();
        rect(x + 680, y + 325, 65, 65); // put rectangle on your face
        rectMode(CORNER);
        strokeWeight(1);
        if (w > minSize && w < 65 && faces[i] != null) { // check if you are far away enough but not too far away for the camera to pick you up
          pauseCountdown(); // start a pause timer counting down from 3 to 1
          if (holdCalibration.isFinished()) { // calibrated successfully long enough
            storedW = w; // store your w to refer to when checking for jumps to ensure that you are still at the optimal distance
            pauseCounter = true; // pause becomes true for the sake of pausing later
            return true;
          }
        } else {
          holdCalibration.start(); // reset the timer everytime you fail the optimal distance check
          pauseCounter = true; //set pause so it will activate during the game
        }
      }
    }
  }
  return false;
}


void displayText(String dialogue, int x, int y) { //Types out the text from the first word to the end
  if (index < dialogue.length()) {
    String partialMessage = dialogue.substring(0, index+1); // Incrementally increase the number of characters displayed
    text(partialMessage, x, y);
    index += speed;
  } else if (index == dialogue.length() || index == dialogue.length() + 1) { // When the conversation is over just print out the entire text
    text(dialogue, x, y);
  }
}

void kyaSound() { // Randomize between a series of Kya Sounds
  switch(randomSound(kyas.length)) {
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

void oofSound() { // Randomize between a series of Oof Sounds
  switch(randomSound(oofs.length)) {
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

void deathCheck() { // Change state to death
  Lore = false;
  Game = false;
  Death = true;
}
void momHealthbar() { // Generate the mom health bar and broken heart counter
  fill(72, 64, 88);
  noStroke();
  rect((width / 2 - 250), 851, 42 + (47 *9), 79);
  for (int x = 0; x < playerHealth; x++) { // mom health bar
    image(momHealth, (width / 2 - 250) + (47 * x), 856, 42, 74);
  }
  image(momHealthBar, width / 2 - 270, 810, 497, 136);
  for (int z = 0; z < brokenHearts; z++) { // broken heart counter
    image(broken, (width / 2 - 250) + (z * 75.125), 950, 65.125, 65.125);
  }
}

int randomSound(int lengthArray) { //randomize an array
  int random = int(random(0, lengthArray + 1));
  return random;
}

void cameraTrack() { // Camera track for the bottom right corner
  noFill();
  stroke(255);
  rect(width - 269, height - 269, 269, 269);

  image(jumpIcon, camX + (width - 269), camY + (height - 269));
}

void pauseCountdown() { // pause timer control
  if (pauseCounter) { //initial timer
    pause.start();
    pauseCounter = false;
  }
  if (!pause.isFinished()) { // countdown behaviours
    fill(0, 120);
    rect(0, 0, width, height);
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

void movieEvent(Movie m) { // movie play event
  m.read();
}


void keyPressed() { // Debugging tool to skip to final boss for testing
  if (key == 'm') {
    textSize(32);
    introSong.stop();
    bossBattleBGM.loop();
    Start = false;
    Death = true;
    goodEnding = true;
  }
  if (key == 's') {
    Start = false;
    Lore = true;
  }
  if (key == 'y') {
    Calibrate = false;
    index = 0;
    Defeat = true;
    RomanticDialogue = true;
  }
  if (key == 'a') {
    attacked();
  }
  if (key == 'j'){
    Jump();
    Game = true;
  }
}

//Citations:
// [1] David Han. Face Tracking with OpenCV (2023). Retrieved March 13th 2024 from https://learn.uwaterloo.ca/d2l/le/content/983488/viewContent/5369538/View
