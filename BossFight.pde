class bossFight{
  int [] attackZone;
  int hp;
  Timer chargeTime;
  Timer laserTime;
  float radius;
  float [] playerHit;
  float [] laserHit;
  boolean chargin;
  boolean lasering;
  int laserMode;
  float lastX;
  float lastY;
  
  bossFight() {
    hp = 10;
    attackZone = new int[] {0,1,2,3,4,5,6,7};
    chargeTime = new Timer (3000);
    laserTime = new Timer (2900);
    radius = 128;
    chargin = true;
    lasering = true;
    laserMode = 0;
  }
  
  boolean damaged(){
    hp--;
    if (hp == 0) {
      return true;
    } else {
      return false;
    }
  }
  
  int giveHealth(){
    return hp;
  }
  
  
  boolean charging(){
    if (chargeTime.isFinished() && millis() - laserTime.giveTime() > 3000){
      laserTime.start();
      return false;
    } 
    return true;
  }
  
  int chooseZone(){
    return attackZone[int(random(0,7))];
  }
  
  void displayCharacter(){
  if (cam.available() == true) {
    cam.read();
  }
  float x;
  float y;
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
        y = faces[i].y + 165;
        x = faces[i].x + 626;
        boundaryCheck(x,y);
        lastX = x;
        lastY = y;
        if (x - lastX > 200 || y - lastY > 200){
          x = lastX;
          y = lastY;
        }
    if (!iFrames.isFinished()){
      tint(255, 201, 74);
    } else if (iFrames.isFinished()){
      noTint();
    }
    image(jumpIcon, x, y, 128,128);
    noTint();
      playerHit = new float [] {x, y, radius / 6, radius / 6};
      
  }
    }
  } else if (faces.length == 0){
    x = lastX;
    y = lastY;
    playerHit = new float [] {x, y, radius / 6, radius / 6};
  }
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

  void displayAttack(int zone){

    switch (laserMode) {
      case 0:
      if (millis() - chargeTime.giveTime() > 3000 && chargin){
        chargeTime.start();
        chargin = false;
        println("happens");
      }
      laserHit = new float [] {0,0,0,0};
      charge(zone);
      if (chargeTime.isFinished()){
        chargin = true;
        laserMode++;
      }
      break;
      case 1:
      if (millis() - laserTime.giveTime() > 3000 && lasering){
        laserTime.start();
        lasering = false;
      }
      laser(zone);
      if (laserTime.isFinished()){
        lasering = true;
        laserMode--;
      }
    }
  }
  
  
  
  boolean detectCollision(){
    if (rectRect(playerHit[0], playerHit[1], playerHit[2], playerHit[3], laserHit[0], laserHit[1], laserHit[2], laserHit[3])){
      return true;
    }
    return false;
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

void displayGrandma(){
  if (hp == 10 || hp == 9){
    image(Grandma1, 18,723, 258,318);
  }
  if (hp == 8 || hp == 7){
    image(Grandma2, 18,723, 258,318);
  }
  if (hp == 6 || hp == 5){
    image(Grandma3, 18,723, 258,318);
  }
  if (hp == 4 || hp == 3){
    image(Grandma4, 18,723, 258,318);
  }
  if (hp == 2 || hp == 1){
    image(Grandma5, 18,723, 258,318);
  }
}

void charge(int zone){
  switch(zone){
      case 0:
      image(chargeLeft,313,218, 217, 217); //face
      break;
      case 1:
      
      image(chargeLeft,313,540, 217, 217);
      break;
      case 2:
      image(chargeUp,688,-73, 217, 217);
      break;
      case 3:
      image(chargeUp,1010, -73, 217, 217);  
      break;
      case 4:
      image(chargeRight,1345,218, 217, 217);
      break;
      case 5:
      image(chargeRight,1345, 540, 217, 217);
      break;
      case 6:
      fill(0,255,0);
      image(chargeDown,688,852, 217, 217);
      break;
      case 7:
      fill(0,255,0);
      image(chargeDown,1010,852, 217, 217);
      break;
    }
  }

void laser(int zone){
  switch(zone){
      case 0:
      laserHit = new float [] {626, 165,1317,341}; // hitbox
      image(rageLeft,313,218, 217, 217); //face
      image(laserLeft, 626, 165,1317,341); //laser
      break;
      case 1:
      laserHit = new float [] {626, 492,1317,341};
      image(rageLeft,313,540, 217, 217);
      image(laserLeft,626, 492,1317,341);
      break;
      case 2:
      laserHit = new float [] {626, 165,341,1317};
      image(rageUp,688,-73, 217, 217);
      image(laserUp,626, 165,341,1317);
      break;
      case 3:
      laserHit = new float [] {953, 165,341,1317};
      image(rageUp,1010, -73, 217, 217);  
      image(laserUp,953, 165,341,1317);
      break;
      case 4:
      laserHit = new float [] {-23, 165,1317,341};
      image(rageRight,1345,218, 217, 217);
      image(laserRight,-23, 165,1317,341);
      break;
      case 5:
      laserHit = new float [] {-23, 492,1317,341};
      image(rageRight,1345, 540, 217, 217);
      image(laserRight,-23, 492,1317,341);
      break;
      case 6:
      laserHit = new float [] {626, -485,341, 1317};
      image(rageDown,688,852, 217, 217);
      image(laserDown,626, -485,341, 1317);
      break;
      case 7:
      laserHit = new float [] {953, -485,341, 1317};
      image(rageDown,1010,852, 217, 217);
      image(laserDown,953, -485,341, 1317);
      break;
    }
  }
}
