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

int collisions = 0;

void setup() {
  size(1200, 600);
  background(35);
  knives = 1;

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
      float overlap = Math.abs(5+e.getSizeX());
      if (Math.abs(player.getX()-e.getX()) < overlap && Math.abs(player.getY()-e.getY()) < overlap) {
        lives--;
      }
      if (lives == 0) {
        player.setIsDead(true);
      }
      //println((player.getX() - e.getX()) + " " + (player.getY() - e.getY()));
    }
  }
}

void buddysystem(){ //so enemies don't overlap each other
  //workin on it
}

boolean killEnemy(Knife k) {
  if (!k.getStopped()) {
    for (int i = 0; i < enemies.size (); i++) {
      Enemy e = enemies.get(i);
      float overlap = Math.abs(7+e.getSizeX());
      if (Math.abs(k.getX()-e.getX()) < overlap && Math.abs(k.getY()-e.getY()) < overlap) {
        println("dong");
        println("numEnemies= " + enemies.size());
        e.setIsDead(true);
        enemies.remove(i);
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
      if (Math.abs(player.getX()-k.getX()) < 25 && Math.abs(player.getY()-k.getY()) < 25) {
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
    }
  } 
  if ( currRoom.getHasDirection(SOUTH)) {
    if (currRoom.getDoor(SOUTH).inDoor(player)) {
      currRoom = currRoom.getRoom(SOUTH);
    }
  } 
  if (currRoom.getHasDirection(EAST)) {
    if (currRoom.getDoor(EAST).inDoor(player)) {
      currRoom = currRoom.getRoom(EAST);
    }
  }
  if (currRoom.getHasDirection(WEST)) {
    if (currRoom.getDoor(WEST).inDoor(player)) {
      currRoom = currRoom.getRoom(WEST);
    }
  }
<<<<<<< HEAD

  println("NORTH:" + currRoom.getHasDirection(NORTH));
  println("SOUTH:" + currRoom.getHasDirection(SOUTH));
  println("EAST:" + currRoom.getHasDirection(EAST));
  println("WEST:" + currRoom.getHasDirection(WEST));
}


=======
  //println(b);
}

>>>>>>> 53802fadc404d155182a5a992a9cc29d7b9c5b03
void drawEnemies() {
  if (!test.getIsDead()) {
    test.spawn();
    //test.move(currRoom.getSizeX(), currRoom.getSizeY(), player.getX(), player.getY());
  }

  if (!test2.getIsDead()) {
    test2.spawn();
    //test2.move(currRoom.getSizeX(), currRoom.getSizeY(), player.getX(), player.getY());
  }
}
<<<<<<< HEAD

=======
>>>>>>> 53802fadc404d155182a5a992a9cc29d7b9c5b03
