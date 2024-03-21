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
Gif Opening;
Gif Talking;
Gif jumpIcon;
PImage Location;
PImage Box;
PImage openBox;
PImage calibrateIns;
PImage angyFace;
PImage heart;
boolean Calibrate = true;
boolean Start = false;
boolean Lore = false;
boolean Instruction = false;
boolean Game = false;

boolean Scene1 = true;
boolean scene1Time = true;
boolean Scene2 = false;
boolean scene2Time = true;
boolean Scene3 = false;
boolean scene3Time = true;
boolean Scene4 = false;
boolean scene4Time = true;
boolean finishedDialogue = false;
boolean isDead = false;

boolean firstAtk = true;
int atkSpeed1 = 350;
boolean suitor1 = true;
suitor Musician;
int atkSpeed2 = 250;
boolean suitor2 = false;
suitor Rich;
int atkSpeed3 = 150;
boolean suitor3 = false;
suitor Romantic;
Timer attack;

PFont Deltarune; // font from deltarune

  // Timer Initialization
Timer autoScroll;

// Text appearing related
int speed = 1;
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
  jumpIcon = new Gif(this, "jumpIcon.gif");
  Location = loadImage("LocationSet.png");
  Box = loadImage("Box.png");
  openBox = loadImage("openBox.png");
  calibrateIns = loadImage("calibrate.png");
  angyFace = loadImage("momangry.png");
  heart = loadImage("Heart.png");
  
  //Timer Initalization
  autoScroll = new Timer(3500);
  
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
  
  Musician = new suitor(angyFace, atkSpeed1, 1, 4);
  
  Opening.loop();
  Talking.loop();
  jumpIcon.loop();
  introSong.loop();
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
    displayText("Statement 1", 600, 900);
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
    displayText("Statement 2", 600, 900);
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
    displayText("Statement 3", 600, 900);
    image(jumpIcon, 1800, 1000);
    if (scene3Time) {
      autoScroll.start();
      scene3Time = false;
    }
    if (Jump() || autoScroll.isFinished()) { //Temporary to get to game screen
      index = 0;
      Scene3 = false;
      Lore = false;
      Game = true;
    }
  } 
  
  if (Scene4) {
  }
    if (Jump() && finishedDialogue){
      Lore = false;
      Game = true;
    }
}

void instructionScreen(){
  
}

void gameScreen(){
  float volumeVal = volume.analyze(); //from audio
  println(volumeVal);
  if (cam.available() == true) {
    cam.read();
  }
  if (suitor1) {
    Suit1();
  }
  fill(0);
  rect(0, 800, 1920, 300);
  if (Jump()){
    energyCharge = energyCharge + 20;
  }
  if (attacked(volumeVal)){
    energyCharge = 0;
  }
  chargingMax = constrain(energyCharge, 0, 200);
  rect(width - 200, height - 100, 50, -chargingMax * 5);
  
  for (int i = 0; i <= 10; i++){
    fill(255,0,0);
    rect((i * 40) + (width / 2 - 150), 900, 40, 40); 
  }
  for (int x = 0; x < 10 - playerHealth; x++){
    fill(20);
    rect((x * 40) + (width / 2 - 150), 900, 40, 40);     
  }
  // Display the webcam image
    image(cam, 1500, 100, cam.width, cam.height);
    imageMode(CENTER);
    imageMode(CORNER);
  image(jumpIcon, 1800, 1000);
  
}

void Suit1(){
  Musician.display(width/2, height/2, 521, 521);
  float curSize = heart.width;
  for (int i = 0; i < Musician.totalHealth(); i++){
    fill(255,0,0);
    rect(0 + (100 * i), 0, 10,10);
  }
  if (firstAtk){
    attack = new Timer(Musician.atk()[0]);
    attack.start();
    firstAtk = false;
  }
  curSize = lerp(curSize, curSize + ((millis()- attack.giveTime()) *2), 0.2);
  if (attack.isFinished()){
    if (playerHealth > 0) {
      playerHealth--;
    } else {
      playerHealth = 0;
      isDead = true;
    }
    attack.start();
  }
  image(heart, width /2, height /2 , curSize, curSize);
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
  if (volume >= 0.09 && millis() - atkDelay > 550) {
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
  } else if (index == dialogue.length()) {
    text(dialogue, x, y);
  }
}
