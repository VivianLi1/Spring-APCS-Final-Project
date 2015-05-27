//Player player;
boolean isSpace;
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
  
  test = new Enemy(player.getX() - 10, player.getY() - 10, 10, 10);
  test2 = new Enemy(player.getX() - 50, player.getY() - 50, 15, 15);
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
  
  player.spawn();
  player.move();
  
  test.spawn();
  test2.spawn();
  test.move(player.getX(), player.getY());
  test2.move(player.getX(), player.getY());
  
  drawKnives();

  if (isSpace && knives > 0) {
    knives--;
    Knife k = new Knife(player.getX(), player.getY(), direction);
    thrown.add(k);
    println(thrown.size());
  }
  
}

void keyPressed() {
  //print(keyCode);
  if (keyCode == 87) {    // W - UP - 87
    player.setUp(true);
  }
  if (keyCode == 65) {    // A - LEFT - 65
    player.setLeft(true);
  }
  if (keyCode == 83) {    // S - DOWN - 83
    player.setDown(true);
  }
  if (keyCode == 68) {    // D - RIGHT - 68
    player.setRight(true);
  }
  
  if (keyCode == 32) {    // SPACE - THROW - 32
    isSpace = true;
  }
  
}

void keyReleased() {
  if (keyCode == 87) {
    player.setUp(false);
  }
  if (keyCode == 65) {
    player.setLeft(false);
  }
  if (keyCode == 83) {
    player.setDown(false);
  }
  if (keyCode == 68) {
    player.setRight(false);
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
