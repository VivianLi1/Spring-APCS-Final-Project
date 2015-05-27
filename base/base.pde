//Player player;
boolean isUp, isLeft, isDown, isRight, isSpace;
int knives;
int direction = 87; //default: shoot up
ArrayList<Knife> thrown = new ArrayList<Knife>();

Player player;
Enemy test;
Enemy test2;

void setup() {
  size(1200, 600);
  background(35);
  knives = 100;
  
  player = new Player(width/2, height/2, 24, 24);
  
  test = new Enemy(x - 10, y - 10, 10, 10);
  test2 = new Enemy(x - 50, y - 50, 15, 15);
  test.spawn();
  test2.spawn();
}

void draw() {
  background(35);
  noStroke();
  smooth();

  rectMode(CORNERS);
  fill(100);
  rect(width/2-200, height/2-200, width/2+200, height/2+200);

  x = constrain(x, width/2-200+24, width/2+200-24);
  y = constrain(y, height/2-200+24, height/2+200-24);
  
  test.spawn();
  test2.spawn();
  test.move(x, y);
  test2.move(x, y);
  
  move();
  drawKnives();

  if (isSpace && knives > 0) {
    knives--;
    Knife k = new Knife(x, y, direction);
    thrown.add(k);
    println(thrown.size());
  }
  
}

void keyPressed() {
  //print(keyCode);
  if (keyCode == 87) {    // W - UP - 87
    isUp = true;
  }
  if (keyCode == 65) {    // A - LEFT - 65
    isLeft = true;
  }
  if (keyCode == 83) {    // S - DOWN - 83
    isDown = true;
  }
  if (keyCode == 68) {    // D - RIGHT - 68
    isRight = true;
  }
  
  if (keyCode == 32) {    // SPACE - THROW - 32
    isSpace = true;
  }
  
}

void keyReleased() {
  if (keyCode == 87) {
    isUp = false;
  }
  if (keyCode == 65) {
    isLeft = false;
  }
  if (keyCode == 83) {
    isDown = false;
  }
  if (keyCode == 68) {
    isRight = false;
  }
  if (keyCode == 32) {
    isSpace = false;
  }
}

void drawKnives() {
  for (Knife k : thrown) {
    k.move();
    fill(133,0,12);
    ellipse(k.getX(),k.getY(),16,16);
  }
}
