//Player player;
float x, y;
boolean isUp, isLeft, isDown, isRight, isSpace;
int knives;
int direction = 87; //default: shoot up
ArrayList<Knife> thrown = new ArrayList<Knife>();

Enemy test;

void setup() {
  size(1200, 600);
  background(35);
  x = width/2;
  y = height/2;
  knives = 100;
  
  test = new Enemy(x - 10, y - 10, 10, 10);
  test.spawn();
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

  ellipseMode(RADIUS);
  fill(255);
  ellipse(x, y, 24, 24);
  
  test.spawn();
  test.move(x, y);

  move();
  drawKnives();

  if (isSpace && knives > 0) {
    knives--;
    Knife k = new Knife(x, y, direction);
    thrown.add(k);
    println(thrown.size());
  }
  
}

void move() {
  if (isUp) {
    y -= 2.0;
    direction = 87;
  }
  if (isLeft) {
    x -= 2.0;
    direction = 65;
  }
  if (isDown) {
    y += 2.0;
    direction = 83;
  }
  if (isRight) {
    x += 2.0;
    direction = 68;
  }
  //println(direction);
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
    ellipse(k.getX(),k.getY(),16,16);
  }
}
