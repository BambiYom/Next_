class suitor{
  PImage suitorFace;
  int atkSpeed;
  int atkDamage;
  int maxHealth;
  int curHealth;
  
  suitor(PImage Char, int Speed, int Damage, int max){
    suitorFace = Char;
    atkSpeed = Speed;
    atkDamage = Damage;
    maxHealth = max;
    curHealth = max;
  }
  
  void display(int x, int y, int w, int h){
    imageMode(CENTER);
    image(suitorFace, x, y, w, h);
    imageMode(CORNER);
  }
  
  int Health(){
    return curHealth;
  }
  int totalHealth(){
    return maxHealth;
  }
  int[] atk(){
    return new int [] {atkSpeed, atkDamage};
  }
  void damaged(int amount){
    if (curHealth - amount >= 0){
    curHealth = curHealth - amount;
    } else {
      curHealth = 0;
    }
  }
  boolean isDead(){
    if (curHealth == 0) {
      return true;
    }
    return false;
  }
}
