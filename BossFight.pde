class bossFight{
  int [] attackZone;
  int hp;
  Timer attackSpd;
  int radius;
  
  bossFight() {
    hp = 10;
    attackZone = new int[] {0,1,2,3,4,5,6,7};
    attackSpd = new Timer (2500);
    radius = 128;
  }
  
  boolean damaged(){
    hp--;
    if (hp == 0) {
      return true;
    } else {
      return false;
    }
  }
  
  
  int chooseZone(){
    return attackZone[int(random(0,7))];
  }
  
  float [] displayCharacter(){
  if (cam.available() == true) {
    cam.read();
  }
    // Update the OpenCV object with the latest webcam image
  opencv.loadImage(cam);
  noFill();
  stroke(255);
  strokeWeight(5);
  rect(626,165,668,668);
  strokeWeight(1);
  // Detect faces in the webcam image using the face classifier
  // The detect function returns an array of java.awt.Rectangle objects with the location,
  // width, and height of each detected object.
  Rectangle[] faces = opencv.detect();
  // Loop through all the detected faces
  
  if (faces.length > 0){
    for (int i = 0; i < 1; i++) {
      if (faces[i].width > minSize && faces[i].height > minSize){ // only faces at a minimum size are tracked to make sure false faces don't get picked up
        // Get the coordinates and dimensions of the currently tracked face
        float y = faces[i].y + 165;
        y = constrain(y, 165, 833);
        float x = faces[i].x + 626;
        x = constrain(x, 626, 1294);
        
    image(jumpIcon, x, y, 128,128);
      float [] hitBox = new float [] {x, y, radius, radius};
    return hitBox;
  }
    }
  }
  return null;
  }
  
void boundaryCheck(float x, float y){
          if (x > 1294 - radius) { // borrowed from Circle Collision Example
        x = 1294 - radius;
      } else if (x < 626 + radius) {
        x = 626 + radius;
      } else if (y > 833 - radius) {
        y = 833-radius;
      } else if (y < 165 + radius) {
        y = 165 + radius;
      }
}

  float [] displayAttack(int zone){
    switch(zone){
      case 0:
      fill(255,0,0);
      float[] atk1 = new float [] {626, 165,1317,341}; // hitbox
      rect(313,218, 217, 217); //face
      fill(233,255,97);
      rect(626, 165,1317,341); //laser
      return atk1;
      case 1:
      fill(255,0,0);
      float[] atk2 = new float [] {626, 492,1317,341};
      rect(313,540, 217, 217);
      fill(233,255,97);
      rect(626, 492,1317,341);
      return atk2;
      case 2:
      float[] atk3 = new float [] {968.76, 165.45,341,1317};
      fill(255,0,0);
      rect(710,-73, 217, 217);
      fill(233,255,97);
      rect(968.76, 165.45,341,1317);
      return atk3;
      case 3:
      float[] atk4 = new float [] {1294, 165.45,341,1317};
      fill(255,0,0);
      rect(1010, -73, 217, 217);  
      fill(233,255,97);
      rect(1294, 165.45,341,1317);
      return atk4;
      case 4:
      float[] atk5 = new float [] {-23, 165,1317,341};
      fill(255,0,0);
      rect(1345,218, 217, 217);
      fill(233,255,97);
      rect(-23, 165,1317,341);
      return atk5;
      case 5:
      float[] atk6 = new float [] {-23, 492,1317,341};
      fill(255,0,0);
      rect(1345, 540, 217, 217);
      fill(233,255,97);
      rect(-23, 492,1317,341);
      return atk6;
      case 6:
      float[] atk7 = new float [] {960, -484,341, 1317};
      fill(255,0,0);
      rect(710,852, 217, 217);
      fill(233,255,97);
      rect(960, -484,341, 1317);
      return atk7;
      case 7:
      float[] atk8 = new float [] {1300, -484,341, 1317};
      fill(255,0,0);
      rect(1010,852, 217, 217);
      fill(233,255,97);
      rect(1300, -484,341, 1317);
      return atk8;
    }
    return null;
  }
  boolean detectCollision(float [] atkHitbox, float [] playerHitbox){
    if (rectRect(playerHitbox[0], playerHitbox[1], playerHitbox[2], playerHitbox[3], atkHitbox[0], atkHitbox[1], atkHitbox[2], atkHitbox[3])){
      println("hit");
      return true;
    }
    return false;
  }
  
  boolean initiateAttack(){
    if (detectCollision(displayAttack(chooseZone()), displayCharacter())) {
      return true;
    }
    return false;
  }
}

boolean rectRect(float r1x, float r1y, float r1w, float r1h, float r2x, float r2y, float r2w, float r2h) { // Hit Collision of two rectangles https://www.jeffreythompson.org/collision-detection/rect-rect.php

  // are the sides of one rectangle touching the other?

  if (r1x + r1w >= r2x &&    // r1 right edge past r2 left
      r1x <= r2x + r2w &&    // r1 left edge past r2 right
      r1y + r1h >= r2y &&    // r1 top edge past r2 bottom
      r1y <= r2y + r2h) {    // r1 bottom edge past r2 top
        return true;
  }
  return false;
}
