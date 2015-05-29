boolean isSpace;
int knives;
int lives = 3;
int direction = 87; //default: shoot up
ArrayList<Knife> thrown = new ArrayList<Knife>();
ArrayList<Enemy> enemies = new ArrayList<Enemy>();

Room room1;
Player player;
Enemy test;
Enemy test2;

int collisions = 0;

void setup() {
  size(1200, 600);
  background(35);
  knives = 100;

  room1 = new Room(300, 200);

  player = new Player(width/2, height/2, 24, 24);
  //test = new Enemy(player.getX() + 50, player.getY() - 50, 10, 10);
  //test2 = new Enemy(player.getX() - 50, player.getY() - 50, 15, 15);
  //enemies.add(test);
  //enemies.add(test2);
}

void draw() {
  background(35);
  noStroke();
  smooth();

  room1.create();
  if (!player.getIsDead()) {
    player.spawn();
    player.move(room1.getSizeX(), room1.getSizeY());

    //test.spawn();
    //test2.spawn();
    //test.move(room1.getSizeX(), room1.getSizeY(), player.getX(), player.getY());
    //test2.move(room1.getSizeX(), room1.getSizeY(), player.getX(), player.getY());

    drawKnives();
    enemyCollision();

    if (isSpace && knives > 0) {
      knives--;
      Knife k = new Knife(player.getX(), player.getY(), direction);
      thrown.add(k);
      println(thrown.size());
    }

    pickUpKnife();
  } else {
    println ("GAME OVER");
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
    k.move(room1.getSizeX(), room1.getSizeY());
    fill(133, 0, 12);
    ellipse(k.getX(), k.getY(), 16, 16);
  }
}

void enemyCollision() {
  for (Enemy e : enemies) {
    if (Math.abs(player.getX()-e.getX()) < 25 && Math.abs(player.getY()-e.getY()) < 25) {
      lives--;
    }
    if (lives == 0) {
      player.setIsDead(true);
    }
  }
}

void pickUpKnife() {
  for (int i = 0; i < thrown.size (); i++) {
    Knife k = thrown.get(i);
    if (k.getStopped()) {
      if (Math.abs(player.getX()-k.getX()) < 25 && Math.abs(player.getY()-k.getY()) < 25) {
        knives++;
        thrown.remove(i);
      }
    }
  }
}

