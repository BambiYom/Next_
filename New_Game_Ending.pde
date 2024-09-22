void new_Boss(){
  image(bg, 0, 0);
  // Update timer
  if (curCase >= 0) { // Only increment timer if on a case
    timer++;
  }
  fill(0);
  rect(0, 574, 1920, 506);
  noStroke();
  image(bossHealthBar, 656, 58, 600, 150);
  image(chatBubble, 1178, 248);
  for (int i = 0; i < hp; i++) {
    image(health, 801 + (55 * i) - 120, 120, 60, 69); // to fix the spacing you have to do the math to make sure each segment is even
  }
  for (int z = 0; z < curRope; z++) {
    image(rope, (width / 39 * z), 610);
  }
  image(ropeBurn, width / 39 * curRope, 610);
  displayGrandma();
  showcase();
  if (hp > 0 && curCase > 10) { // return to first case if grandma is not defeated and reached the maximum case
  curCase = 0;
  }
  if (showGrandmaDamaged) { // Show Grandma hurt face for 1 sec if damaged
    image(Grandma4, 780, 193);
    if (millis() - startTime > hurtGrandmaDisplayTime) {
      showGrandmaDamaged = false;
    }
  }
  if (hp == 0){
    bossBattleBGM.stop();
    timeTicking.stop();
    Death = false;
    Defeat = true;
  }
  if (curRope <= 0){
    image(loseScreen, 0,0);
    loseSound.play();
    bossBattleBGM.stop();
    timeTicking.stop();
    wrongAction.pause();
    noLoop();
  }
  if (timer % 5 == 0) { // Every 2 seconds the rope shortens
      curRope -= 2;
  }
}

void showcase() {
  switch(curCase) {
  case 0:
    image(redCard, 600, 675);
    card = 0;
    fill(0);
    text("I saw you holding", 1220, 298); 
    text("hands with that ", 1220, 298 + 46);
    text("boy! Break it off!", 1220, 298 + 92);
    fill(255);
    text("No, I won't. I love him.", 670, 880);
    cardCheck();
    break;
  case 1:
    image(blueCard, 600, 675);
    card = 1;
    fill(0);
    text("What do you mean", 1220, 298);
    text("'no'? I am your", 1220, 298 + 46);
    text("mother, and you", 1220, 297 +92);
    text(" will obey me.", 1220, 297 + 138);
    fill(255);
    text("I'll listen to you.", 690, 880);
    text("Sorry for overstepping.", 690, 880 + 46);
//    if (oneTime){
//      curRope = maxRope;
//      oneTime = false;
//    }
    cardCheck();
    break;
  case 2:
    card = 1;
    image(blueCard, 600, 675);
//    if (oneTime){
//      curRope = maxRope;
//      oneTime = false;
//    }
    fill(0);
    text("Love at such a", 1220, 298);
    text("young age is", 1220, 298 + 46);
    text("just a distraction", 1220, 297 +92);
    text("from studies.", 1220, 297 + 138);
    text("This is foolish.", 1220, 297 + 184);
    fill(255);
    text("You're right, academics", 690, 880);
    text("are more important.", 690, 880 + 46);
    cardCheck();
    break;
  case 3:
    image(redCard, 600, 675);
//    if (oneTime){
//      curRope = maxRope;
//      oneTime = false;
//    }
    card = 0;
    fill(0);
    text("Didn't I raise", 1220, 298);
    text("you better? Enough ", 1220, 298 + 46);
    text("with this dating", 1220, 297 +92);
    text("nonsense!", 1220, 297 + 138);
    fill(255);
    text("You raised me to ", 675, 880);
    text("prioritize family honour", 675, 880 + 46);
    text("over my own desires.", 675, 880 + 92);
    cardCheck();
    break;
  case 4:
    image(blueCard, 600, 675);
//    if (oneTime){
//      curRope = maxRope;
//      oneTime = false;
//    }
    card = 1;
    fill(0);
    text("What YOU want", 1220, 298);
    text("doesn't matter.", 1220, 298 + 46);
    text("Think of", 1220, 297 +92);
    text("the family!", 1220, 297 + 138);
    fill(255);
    text("Family is more", 675, 880);
    text("important. What I want", 675, 880 + 46);
    text("doesn't matter.", 675, 880 + 92);
    cardCheck();
    break;
  case 5:
    image(redCard, 600, 675);
    card = 0;
    fill(0);
    text("I'm only thinking", 1220, 298);
    text("about what's best", 1220, 298 + 46);
    text("for you.", 1220, 297 +92);
    fill(255);
    text("How are you so", 675, 880);
    text("sure this is what's", 675, 880 + 46);
    text("best for me?", 675, 880 + 92);
//    if (oneTime){
//      curRope = maxRope;
//      oneTime = false;
//    }
    cardCheck();
    break;
  case 6:
    image(redCard, 600, 675);
    card = 0;
    fill(0);
    text("How dare you -", 1220, 298);
    text("of course I'm", 1220, 298 + 46);
    text("right, I'm your", 1220, 297 +92);
    text("MOTHER!", 1220, 297 + 138);
    fill(255);
    text("What about dad?", 675, 880);
    text("Did your parents approve", 675, 880 + 46);
    text("of you and him?", 675, 880 + 92);
//    if (oneTime){
//      curRope = maxRope;
//      oneTime = false;
//    }
    cardCheck();
    break;
  case 7:
    image(blueCard, 600, 675);
//    if (oneTime){
//      curRope = maxRope;
//      oneTime = false;
//    }
    card = 1;
    fill(0);
    text("That doesn't", 1220, 298);
    text("matter. That's", 1220, 298 + 46);
    text("different.", 1220, 297 +92);
    fill(255);
    text("You're right. ", 675, 880);
    cardCheck();
    break;
  case 8:
    image(redCard, 600, 675);
//    if (oneTime){
//      curRope = maxRope;
//      oneTime = false;
//    }
    card = 0;
    fill(0);
    text("Love won't get you", 1220, 298);
    text("a good job. And", 1220, 298 + 46);
    text("how do you plan on", 1220, 297 +92);
    text("settling down here", 1229, 297 + 138);
    text("with him?", 1229, 297 + 184);
    fill(255);
    text("We can figure that ", 675, 834);
    text("out together. It doesn't ", 675, 834 + 46);
    text("all have to be", 675, 834 + 92);
    text("perfect from the start.", 675, 834 + 138);
    cardCheck();
    break;
  case 9:
    image(redCard, 600, 675);
//    if (oneTime){
//      curRope = maxRope;
//      oneTime = false;
//    }
    card = 0;
    fill(0);
    text("ENOUGH.", 1220, 298);
    text("Stop this at once,", 1220, 298 + 46);
    text("or we're sending", 1220, 297 +92);
    text("you back home.", 1229, 297 + 138);
    fill(255);
    text("Mother, I'm an adult now.", 675, 834);
    text("Please, for once,", 675, 834 + 46);
    text("support me in making", 675, 834 + 92);
    text("my own decisions.", 675, 834 + 138);
    cardCheck();
    break;
    case 10:
    image(redCard, 600, 675);
//    if (oneTime){
//      curRope = maxRope;
//      oneTime = false;
//    }
    card = 0;
    fill(0);
    text("......", 1220, 298);
    fill(255);
    text("I'm sorry, Grandma,", 675, 834);
    text("but I have to", 675, 834 + 46);
    text("follow my heart.", 675, 834 + 92);
    cardCheck();
    break;
  }
}

void displayGrandma() { // Changes grandma based on her health
  if (hp == 10 && !showGrandmaDamaged || hp == 9 && !showGrandmaDamaged) {
    image(Grandma1, 780, 193);
  }
  if (hp == 8 && !showGrandmaDamaged || hp == 7 && !showGrandmaDamaged) {
    image(Grandma2, 780, 193);
  }
  if (hp == 6 && !showGrandmaDamaged || hp == 5 && !showGrandmaDamaged) {
    image(Grandma3, 780, 193);
  }
  if (hp == 4 && !showGrandmaDamaged || hp == 3 && !showGrandmaDamaged) {
    image(Grandma3, 780, 193);
  }
  if (hp == 2 && !showGrandmaDamaged || hp == 1 && !showGrandmaDamaged) {
    image(Grandma5, 780, 193);
  }
}

void cardCheck(){ // 0 is red card and 1 is blue card
  switch(card){
    case 0:
      if (Jump()){
        hp--;
        grandmaHurt.play();
        showGrandmaDamaged = true; // Grandma got damaged
        startTime = millis();
        curRope = maxRope;
        curCase++;
      } else if (curRope == 0){
          curRope = curRope - 5;
          curCase++;
          maxRope -= 4;
          if (maxRope > 0){
            curRope = maxRope;
          } else if (maxRope < 0) {
            curRope = 0;
          }
          wrongAction.play();
      }
      break;
    case 1:
      if (Jump()){
          curCase++;
          maxRope -= 4;
          if (maxRope > 0){
            curRope = maxRope;
          } else if (maxRope < 0) {
            curRope = 0;
          }
          wrongAction.play();
      } else if (curRope == 0){
          hp--;
          grandmaHurt.play();
          showGrandmaDamaged = true; // Grandma got damaged
          startTime = millis();
          curRope = maxRope;
          curCase++;
      }
      break;
  }
}
