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
int prevY = -1000;
int prevX;
int storedW;
int jumpDelay;
int atkDelay;
int minSize = 50;
int curPage = 0;
int energyCharge = 0;
int chargingMax;
int Timingperframe = 2500;
int playerHealth = 10;
int brokenHearts = 0;
Gif Opening;
Gif Talking;
Gif Grandma;
Gif jumpIcon;
Gif Train;
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
boolean scene5Time = true;
boolean isDead = false;
boolean scene6Time = true;

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

// variable to hold the Audio input 
AudioIn input;
// variable to hold the Amplitude analyzer
Amplitude volume;

void setup() {
  size(1920,1080);
  background(100, 50 , 50);
  // Populate an array with a list of available capture devices
  String[] cameras = Capture.list();
  // Initialize the camera object using the first element of the list denoted by cameras[0]
  cam = new Capture(this, cameras[0]);
  
  introSong = new SoundFile(this, "a3_intromusic_FINAL-V1.mp3");
  
  // ALL Image Initialization
  Opening = new Gif(this, "Title.gif");
  Talking = new Gif(this, "FinalHead.gif");
  Grandma = new Gif(this, "Grandma.gif");
  jumpIcon = new Gif(this, "jumpIcon.gif");
  Train = new Gif(this, "train.gif");
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
  
    // Create an Audio input and grab the 1st channel
  input = new AudioIn(this, 0);

  // Begin capturing the audio input
  input.start();
  // Create a new Amplitude analyzer
  volume = new Amplitude(this);

  // Patch the input to the volume analyzer
  volume.input(input);
  
  Musician = new suitor(Suitor1, atkSpeed1, 1, 4);
  Rich = new suitor(Suitor2, atkSpeed2, 1, 8);
  
  Opening.loop();
  Talking.loop();
  jumpIcon.loop();
  introSong.loop();
  Train.loop();
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
    Calibrate = false;
    Start = true;
  }
}

void startScreen(){
  image(Opening,0,0, 1920, 1080);

  if (Jump()) {
    introSong.pause();
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
      autoScroll.start();
      scene1Time = false;
    }
    if (Jump() || autoScroll.isFinished()) {
      index = 0;
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
      autoScroll.start();
      scene2Time = false;
    }
    if (Jump() || autoScroll.isFinished()) {
      index = 0;
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
      autoScroll.start();
      scene3Time = false;
    }
    if (Jump() || autoScroll.isFinished()) { //Temporary to get to game screen
      index = 0;
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
      autoScroll.start();
      scene4Time = false;
    }

    image(jumpIcon, 1800, 1000);
    if (scene4Time) {
      autoScroll.start();
      scene4Time = false;
    }
    if (Jump() || autoScroll.isFinished()){
      index = 0;
      Scene4 = false;
      Lore = false;
      Game = true;
    }
  }
  if (MusicianDialogue) {
    fill(125,0,0);
    rect(0,0, 1920, 1080);
    fill(0);
    rect(0, 800, 1920, 300);
    fill(255);
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
    fill(125,0,0);
    rect(0,0, 1920, 1080);
    fill(0);
    rect(0, 800, 1920, 300);
    fill(255);
    stroke(0);      
    rect(50,700,245,270);
    image(Suitor2, 50, 700, 245,270);
    stroke(255);
    fill(255);
    textSize(64);
    text("Rich Boy", 95, 1045);
    textSize(32);
    speed = 2;
    displayText("I can buy you a house!", 600, 900);
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
      Lore = false;
      Game = true;
      brokenHearts++;
      suitor2 = false;
      suitor3 = true;
    }
  }
}

void instructionScreen(){
  
}

void gameScreen(){
  fill(0);
  rect(0,0,width, height);
  if (cam.available() == true) {
    cam.read();
  }
  if (suitor1) {
    Suit1();
  }
  if (suitor2) {
    Suit2();
  }
  if (suitor3) {
    
  }
  fill(0);
  rect(0, 800, 1920, 300);
  if (Jump()){
    energyCharge = energyCharge + 20;
  }
  chargingMax = constrain(energyCharge, 0, 100);
  fill(chargingMax, 0, 255 - chargingMax);
  rect(width - 200, height - 100, 50, -chargingMax * 5);
  
    if (brokenHearts == 0){
    imageMode(CENTER);
    image(angyFace, 1600, 900, 208,208);
    imageMode(CORNER);
  }
  if (brokenHearts == 1){
    imageMode(CENTER);
    image(happyFace, 1600, 900, 208,208);
    imageMode(CORNER);
  }
  if (brokenHearts == 2){
    imageMode(CENTER);
    image(excitedFace, 1600, 900, 208,208);
    imageMode(CORNER);
  }
  // Display the webcam image
  image(cam, 1500, 100, cam.width, cam.height);
  
  for (int i = 0; i <= 10; i++){
    fill(255,0,0);
    rect((i * 40) + (width / 2 - 250), 900, 40, 40); 
  }
  for (int x = 0; x < 10 - playerHealth; x++){
    fill(20);
    rect((width / 2 - 250) - (x * 40) + 400 , 900, 40, 40);     
  }
  for (int z = 0; z < brokenHearts; z++){
    image(broken, 80 + (z * 75.125), 950, 65.125, 65.125);
  }
  
  image(jumpIcon, 1800, 1000);
}

void Suit1(){
  float volumeVal = volume.analyze(); //from audio
  Musician.display(width/2, height/2, 521, 521);
  float curSize = 65.125;
  if (attacked(volumeVal)){
    Musician.damaged(energyCharge / 20);
    energyCharge = 0;
  }
  for (int i = 0; i < Musician.Health(); i++){
    fill(255,0,0);
    rect(width / 2 + (60 * i) - 120, 0, 50, 50);
  }
  if (firstAtk){
    attack = new Timer(Musician.atk()[0]);
    attack.start();
    firstAtk = false;
  }
  if (Musician.isDead()){
      MusicianDialogue = true;
      Game = false;
      Lore = true;
  }
  curSize = lerp(curSize, curSize + ((millis()- attack.giveTime()) *10), 0.2);
  if (attack.isFinished()){
    if (playerHealth > 0) {
      playerHealth--;
    } else {
      playerHealth = 0;
      isDead = true;
    }
    attack.start();
  }
  if (!Musician.isDead()){
    image(heart, width /2, height /2 , curSize, curSize);
  }
}

void Suit2(){
  float volumeVal = volume.analyze(); //from audio
  Rich.display(width/2, height/2, 521, 521);
  float curSize = 65.125;
  if (attacked(volumeVal)){
    Rich.damaged(energyCharge / 20);
    energyCharge = 0;
  }
  for (int i = 0; i < Rich.Health(); i++){
    fill(255,0,0);
    rect(width / 2 + (60 * i) - 120, 0, 50, 50);
  }
  if (firstAtk){
    attack = new Timer(Rich.atk()[0]);
    attack.start();
    firstAtk = false;
  }
  if (Rich.isDead()){
      RichDialogue = true;
      Game = false;
      Lore = true;
  }
  curSize = lerp(curSize, curSize + ((millis()- attack.giveTime()) *10), 0.2);
  if (attack.isFinished()){
    if (playerHealth > 0) {
      playerHealth--;
    } else {
      playerHealth = 0;
      isDead = true;
    }
    attack.start();
  }
  if (!Rich.isDead()){
    image(heart, width /2, height /2 , curSize, curSize);
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
        int w = faces[i].width;
        if (prevY == -1000) {
          prevY = y;
        }
        
        
        if(y < prevY - 35 && faces[i] != null && millis() - jumpDelay >= 550 && w <= storedW + 16 && w >= storedW - 16) { // tracks if you lift your head 40 pixels up
          println("jump");
          jumpDelay = millis();
          return true;
        }
        if (y != 0) {
          prevY = y;
        }

      }
    }
  } 
  return false;
}

boolean attacked(float volume){
  if (volume >= 0.22 && millis() - atkDelay > 2000 && chargingMax == 100) {
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

// changing background based on pressing keys (For debugging)
void keyPressed() {
  if ((key == 'a' || key == 'A')) {
    Calibrate = false;
    Start = true;
  }

  if ((key == 's' || key == 'S')) {
    Start = false;
    Lore = true;
  }
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
