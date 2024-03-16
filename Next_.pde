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

int prevY;
int prevX;
int jumpDelay;
int minSize = 50;
int curPage = 0;
Gif Opening;
Gif Talking;
PImage Test;
boolean Calibrate = true;
boolean Start = false;
boolean Lore = false;
boolean Instruction = false;
boolean Game = false;
Page Scene1; 
Page [] Cutscene1;

// variable to hold the Audio input 
AudioIn input;
// variable to hold the Amplitude analyzer
Amplitude volume;

void setup() {
  size(1920,1080);
  // Populate an array with a list of available capture devices
  String[] cameras = Capture.list();
  // Initialize the camera object using the first element of the list denoted by cameras[0]
  cam = new Capture(this, cameras[0]);
  
  Opening = new Gif(this, "Title.gif");
  Talking = new Gif(this, "FinalHead.gif");
  Test = loadImage("Title.gif");
  frameRate(30);
  Scene1 = new Page(new int[] {1, 2}, new String[] {"choice1, choice2"}, "Text goes here", Test, Talking);
  Cutscene1 = new Page [] {Scene1};
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
  
  Opening.loop();
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
    println("I got here");
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
  background(25);
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
    Start = false;
    Game = true;
  }
}

void loreScreens(){
    Scene1.displayPage();
    if (Jump()){
      Lore = false;
      Game = true;
    }
}

void instructionScreen(){
  
}

void gameScreen(){
  fill(255, 246, 228);
  noStroke();
  rect(58, 45, 1420, 990, 25);
  if (cam.available() == true) {
    cam.read();
  }
  if (Jump()){
  }
  // Display the webcam image
    image(cam, 1000, 100, cam.width, cam.height);
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
        
        
        if(y < prevY - 40 && faces[i] != null && millis() - jumpDelay >= 550) { // tracks if you lift your head 40 pixels up
          println("jump");
          jumpDelay = millis();
          return true;
        }
        prevY = y;
    
    

      }
    }
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
        int w = faces[i].width;
           
        if (w > minSize && w < 80 && faces[i] != null) {
          return true;
        }
      }
    }
  } 
  return false;
}
