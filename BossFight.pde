class bossFight{
  int [] attackZone; // denotes there are 8 zones where they can attack from
  int hp; // denotes the amount of health the boss has remaining
  Timer chargeTime; // the amount of time it takes to charge an attack
  Timer laserTime; // the amount of time the last lasts 
  float radius; // Character distance from left to right
  float [] playerHit; // player hurtbox
  float [] laserHit; // laser hitbox
  boolean chargin; // if its charging
  boolean lasering; // if its shooting
  int laserMode; // what mode its in rn
  float lastX; // previous X
  float lastY; // previous Y
  
  bossFight() { // setup the following values
    hp = 10;
    attackZone = new int[] {0,1,2,3,4,5,6,7};
    chargeTime = new Timer (3000);
    laserTime = new Timer (2900);
    radius = 128;
    chargin = true;
    lasering = true;
    laserMode = 0;
  }
  
  boolean damaged(){ // reduce hp by one and if you are dead it return true
    hp--;
    if (hp == 0) {
      return true;
    } else {
      return false;
    }
  }
  
  int giveHealth(){ // returns health probably not neccesary since you can do class.hp()
    return hp;
  }
  
  
  boolean charging(){ // check to see if you are charging
    if (chargeTime.isFinished() && millis() - laserTime.giveTime() > 3000){
      laserTime.start();
      return false;
    } 
    return true;
  }
  
  int chooseZone(){ // choose a random zone
    return attackZone[int(random(0,7))];
  }
  
  void displayCharacter(){ // show the character on screen, and track its movement
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
  rect(626,165,668,668); // draw a rectangle  where the character will be placed
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
        lastX = x; //tracks previous positions does not work correctly yet
        lastY = y; //tracks previous positions does not work correctly yet
        if (x - lastX > 200 || y - lastY > 200){ //tracks previous positions does not work correctly yet
          x = lastX; 
          y = lastY;
        }
    if (!iFrames.isFinished()){ // Tints your character as long you have iframes remaining
      tint(255, 201, 74);
    } else if (iFrames.isFinished()){
      noTint();
    }
    image(jumpIcon, x, y, 128,128); // place the icon
    noTint();
      playerHit = new float [] {x, y, radius / 6, radius / 6}; //set hitbox at that spot
      
  }
    }
  } else if (faces.length == 0){ // case if player face is lost
    x = lastX;
    y = lastY;
    playerHit = new float [] {x, y, radius / 6, radius / 6}; 
  }
  }
  
void boundaryCheck(float x, float y){ // Checks to see if you ever hit the boundary of the box
          if (x > 1294 - radius) { 
        x = 1294 - radius;
      } else if (x < 626 + radius) {
        x = 626 + radius;
      } else if (y > 833 - radius) {
        y = 833-radius;
      } else if (y < 165 + radius) {
        y = 165 + radius;
      }
}

  void displayAttack(int zone){ // Show the Laser and Charge Period

    switch (laserMode) {
      case 0: // Case when Charging
      if (millis() - chargeTime.giveTime() > 3000 && chargin){ // Starts charge timer and prevents it from resetting multiple times
        chargeTime.start();
        chargin = false;
        println("happens");
      }
      laserHit = new float [] {0,0,0,0}; // Set Laser hitbox
      charge(zone); //places the charge head at the correct zone
      if (chargeTime.isFinished()){ //change mode when done charging
        chargin = true;
        laserMode++;
      }
      break;
      case 1:
      if (millis() - laserTime.giveTime() > 3000 && lasering){ // starts laser timer and prevents it from resetting multiple times
        laserTime.start();
        lasering = false;
      }
      laser(zone); // places laser in correct zone
      if (laserTime.isFinished()){ // changes mode when done lasering
        lasering = true;
        laserMode--;
      }
    }
  }
  
  
  
  boolean detectCollision(){ // detects when a player is hit
    if (rectRect(playerHit[0], playerHit[1], playerHit[2], playerHit[3], laserHit[0], laserHit[1], laserHit[2], laserHit[3])){
      return true;
    }
    return false;
  }
  

boolean rectRect(float r1x, float r1y, float r1w, float r1h, float r2x, float r2y, float r2w, float r2h) { // Hit Collision of two rectangles [1]

  // are the sides of one rectangle touching the other?

  if (r1x + r1w >= r2x &&    // r1 right edge past r2 left
      r1x <= r2x + r2w &&    // r1 left edge past r2 right
      r1y + r1h >= r2y &&    // r1 top edge past r2 bottom
      r1y <= r2y + r2h) {    // r1 bottom edge past r2 top
        return true;
  }
  return false;
}

void displayGrandma(){ // Changes grandma based on her health
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

void charge(int zone){ // places the charge face in the given zone
  switch(zone){ // depending on the zone the head is placed in a different spot
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

void laser(int zone){ // places the laser appropriately connected to the zone and changes the face to angry
  switch(zone){ // position based on zone
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

//Citations:
//[1] Jeffery Thompson. RECTANGLE/RECTANGLE. Retrieved April 3rd 2024 from https://www.jeffreythompson.org/collision-detection/rect-rect.php
