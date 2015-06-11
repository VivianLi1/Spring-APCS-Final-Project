final int START = 0;
final int PLAY = 1;
final int GAMEOVER = 2;

private final int NORTH = 0;
private final int SOUTH = 1;
private final int EAST = 2;
private final int WEST = 3;

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

int time;
int wait = 500;

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

  makeEnemies(3);

  player.spawn();

  time = millis();
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
  //println(mouseX, mouseY);
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

  //currFloor.createRoom(currRoom);
  currRoom.create();
  fill(0);
  currRoom.drawDoors();
  if (!player.getIsDead()) {

    player.spawn();
    player.move(currRoom.getSizeX(), currRoom.getSizeY());

    drawKnives();
    drawEnemies();
    enemyCollision();
    doorCollision();

    //println(time);
    //println(millis());

    //println(millis());
    if (isSpace && knives > 0) {
      if (millis() - time >= wait) {
        //println("THROWWWWWWW");
        knives--;
        Knife k = new Knife(player.getX(), player.getY(), direction);
        thrown.add(k);
        time = millis();
        //println(thrown.size());
      }
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
    ellipseMode(RADIUS);
    ellipse(k.getX(), k.getY(), 8, 8);
  }
}

void enemyCollision() {
  for (Enemy e : enemies) {
    if (e.getIsDead() == true) {
      continue;
    } else {
      float overlap = Math.abs(5+e.getSizeX());
      if (Math.abs(player.getX()-e.getX()) < overlap && Math.abs(player.getY()-e.getY()) < overlap) {
        lives--;
      }
      if (lives == 0) {
        player.setIsDead(true);
      }
    }
  }
}

void buddysystem() { //so enemies don't overlap each other
  //workin on it
}

void makeEnemies(int num) {
  int count = 0;
  Random r = new Random();
  for (int i = 0; i < num; i++) {
    Enemy e = new Enemy(player.getX()-r.nextInt(100)-50, player.getY()+r.nextInt(100)-50, 20, 20);
    enemies.add(e);
  }
}

boolean killEnemy(Knife k) {
  if (!k.getStopped()) {
    for (int i = 0; i < enemies.size (); i++) {
      Enemy e = enemies.get(i);
      float overlap = Math.abs(7+e.getSizeX());
      if (Math.abs(k.getX()-e.getX()) < overlap && Math.abs(k.getY()-e.getY()) < overlap) {
        e.setIsDead(true);
        enemies.remove(i);
        //println("numEnemies= " + enemies.size());
        return true;
      }
    }
  }
  return false;
}

void pickUpKnife() {
  for (int i = 0; i < thrown.size (); i++) {
    Knife k = thrown.get(i);
    if (k.getStopped()) {
      if (Math.abs(player.getX()-k.getX()) < 20 && Math.abs(player.getY()-k.getY()) < 20) {
        knives++;
        thrown.remove(i);
      }
    }
  }
}

void doorCollision() {
  if (currRoom.getHasDirection(NORTH)) {
    if (currRoom.getDoor(NORTH).inDoor(player)) {
      currRoom = currRoom.getRoom(NORTH);
      player.setX(currRoom.getX());
      player.setY(currRoom.getY() + currRoom.getSizeY() / 2);
    }
  } 
  if ( currRoom.getHasDirection(SOUTH)) {
    if (currRoom.getDoor(SOUTH).inDoor(player)) {
      currRoom = currRoom.getRoom(SOUTH);
      player.setX(currRoom.getX());
      player.setY(currRoom.getY() - currRoom.getSizeY() / 2);
    }
  } 
  if (currRoom.getHasDirection(EAST)) {
    if (currRoom.getDoor(EAST).inDoor(player)) {
      currRoom = currRoom.getRoom(EAST);
      player.setX(currRoom.getX() - currRoom.getSizeX() / 2);
      player.setY(currRoom.getY());
    }
  }

  if (currRoom.getHasDirection(WEST)) {
    if (currRoom.getDoor(WEST).inDoor(player)) {
      currRoom = currRoom.getRoom(WEST);
      player.setX(currRoom.getX() + currRoom.getSizeX() / 2);
      player.setY(currRoom.getY());
    }
  }


  //println("NORTH:" + currRoom.getHasDirection(NORTH));
  //println("SOUTH:" + currRoom.getHasDirection(SOUTH));
  //println("EAST:" + currRoom.getHasDirection(EAST));
  //println("WEST:" + currRoom.getDoor(WEST).inDoor(player));
}


void drawEnemies() {
  for (Enemy e : enemies) {
    if (!e.getIsDead()) {
      e.spawn();
      //e.move(currRoom.getSizeX(), currRoom.getSizeY(), player.getX(), player.getY());
    }
  }
}

