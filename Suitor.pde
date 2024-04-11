class suitor{
  PImage suitorFace; // Suitor Face
  int atkSpeed; // How Fast Suitor attacks
  int atkDamage; // How much damage Suitor does each attack
  int maxHealth; // How much health Suitor has total
  int curHealth; // How much health Suitor has currently
  
  suitor(PImage Char, int Speed, int Damage, int max){ // initialize all the variables
    suitorFace = Char;
    atkSpeed = Speed;
    atkDamage = Damage;
    maxHealth = max;
    curHealth = max;
  }
  
  void display(int x, int y, int w, int h){ // Show suitor at this location
    imageMode(CENTER);
    image(suitorFace, x, y, w, h);
    imageMode(CORNER);
  }
  
  int Health(){ // give current health
    return curHealth;
  }
  int totalHealth(){ // give max health
    return maxHealth;
  }
  int[] atk(){ // attack returns an array of speed and damage
    return new int [] {atkSpeed, atkDamage};
  }
  void damaged(int amount){ // damaged stores the damage into the class
    if (curHealth - amount >= 0){
    curHealth = curHealth - amount;
    } else {
      curHealth = 0;
    }
  }
  boolean isDead(){ // dead check if health = 0
    if (curHealth == 0) {
      return true;
    }
    return false;
  }
}
