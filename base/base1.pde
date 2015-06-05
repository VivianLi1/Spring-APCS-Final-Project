final int START = 0;
final int PLAY = 1;
final int GAMEOVER = 2;

int mode = PLAY;

boolean isSpace;
int knives;
int lives = 3;
int direction = 87; //default: shoot up
ArrayList<Knife> thrown = new ArrayList<Knife>();
ArrayList<Enemy> enemies = new ArrayList<Enemy>();

Floor currFloor;
Room currRoom;
Player player;
Enemy test;
Enemy test2;

int collisions = 0;

void setup() {
  size(1200, 600);
  background(35);
  knives = 100;

  currFloor = new Floor();
  currRoom = new Room();

  //floor1.chooseDir();
  currFloor.connectRoom(currRoom);
  currFloor.createRoom(currRoom);

  player = new Player(width/2, height/2, 24, 24);


  test = new Enemy(player.getX() + 50, player.getY() - 50, 10, 10);
  test2 = new Enemy(player.getX() - 50, player.getY() - 50, 15, 15);
  enemies.add(test);
  enemies.add(test2);

  player.spawn();
}

void draw() {
  switch(mode) {
  case 1: 
    play();
    break;
  case 2: 
    gameOver();
    break;
  }
  println(mouseX, mouseY);
}

void keyPressed() {
  if (mode == PLAY) {
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
}

void keyReleased() {
  if (mode == PLAY) {
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
}

void play() {
  background(35);
  noStroke();
  smooth();

  currRoom.create();
  fill(0);
  currRoom.drawDoors();
  if (!player.getIsDead()) {
    player.spawn();
    player.move(currRoom.getSizeX(), currRoom.getSizeY());

    if (!test.getIsDead()) {
      enemies.add(test);
      test.spawn();
    }

    if (!test2.getIsDead()) {
      enemies.add(test2);
      test2.spawn();
    }


    test.spawn();
    test2.spawn();
    //test.move(currRoom.getSizeX(), currRoom.getSizeY(), player.getX(), player.getY());
    //test2.move(currRoom.getSizeX(), currRoom.getSizeY(), player.getX(), player.getY());


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
    mode = GAMEOVER;
  }
}

void gameOver() {
  background(0);
  fill(255);
  textAlign(CENTER);
  textSize(50);
  text("GAME OVER", width/2, height/2);
}

void drawKnives() {
  for (Knife k : thrown) {
    if (killEnemy(k)) {
      k.setStopped(true);
    } else if (!k.getStopped()) {
      k.move(currRoom.getSizeX(), currRoom.getSizeY());
    }
    fill(133, 0, 12);
    ellipse(k.getX(), k.getY(), 16, 16);
  }
}

void enemyCollision() {
  for (Enemy e : enemies) {
    if (e.getIsDead() == true) {
      continue;
    } else {
      if (Math.abs(player.getX()-e.getX()) < 25 && Math.abs(player.getY()-e.getY()) < 25) {
        lives--;
      }
      if (lives == 0) {
        player.setIsDead(true);
      }
      //println((player.getX() - e.getX()) + " " + (player.getY() - e.getY()));
    }
  }
}

boolean killEnemy(Knife k) {
  for (int i = 0; i < enemies.size (); i++) {
    Enemy e = enemies.get(i);
    if (Math.abs(k.getX()-e.getX()) < 20 && Math.abs(k.getY()-e.getY()) < 20) {
      println("dong");
      e.setIsDead(true);
      enemies.remove(i);
      return true;
    }
  }
  return false;
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

void doorCollision(){
}
