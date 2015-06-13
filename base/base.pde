import java.awt.Rectangle;

final int START = 0;
final int PLAY = 1;
final int GAMEOVER = 2;
final int INVINCIBLE = 3;

private final int NORTH = 0;
private final int SOUTH = 1;
private final int EAST = 2;
private final int WEST = 3;

boolean gameStart;

int mode = INVINCIBLE;
//int mode = PLAY;

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

int time2;
int invincibility = 3000;

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
  gameStart = true;
  time2 = millis();
  /*
  time2 = millis();
   //println(gameStart);
   while (gameStart) {
   player.setInvincible(true);
   println(player.getInvincible());
   if (millis() - time2 >= invincibility) {
   player.setInvincible(false);
   gameStart = false;
   }
   }
   println(player.getInvincible());
   */
}

void draw() {
  switch(mode) {
  case 1: 
    play();
    break;
  case 2: 
    gameOver();
    break;
  case 3:
    if (!(millis() - time2 >= invincibility)) {
      invincible();
      timer(invincibility, millis() - time2);
    } else {
      mode = PLAY;
    }
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
  if (mode == GAMEOVER) {
    if (keyCode == 32) {
      mode = PLAY;
      setup();
      draw();
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

void invincible() {
  background(35);
  noStroke();
  smooth();
  currRoom.create();
  fill(0);
  currRoom.drawDoors();
  player.spawn();
  drawEnemies(false);
}

void timer(int t, int ms){
  int countdown = ms;
  textSize(100);
  fill(255,255,255);
  textAlign(CENTER);aaa
  text("GET READY", width/2, height/2-75);
  
  textSize(150);
  textAlign(CENTER);
  text(""+((t/1000)-(countdown/1000)), width/2, height/2+75);
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
    //println(gameStart);
    player.spawn();
    player.move(currRoom.getSizeX(), currRoom.getSizeY());

    enemyCollision();
    drawKnives();
    drawEnemies(true);
    //enemyCollision();
    doorCollision();

    //println(time);
    //println(millis());

    //println(millis());
    if (isSpace && knives > 0) {
      if (millis() - time >= wait) {
        //enemyCollision();
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

  //if(keyCode ==
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

/*
void buddySystem(int index) {
 Enemy e = enemies.get(0);
 Enemy f;
 Rectangle r1 = e.getBounds();
 //Rectangle r1 = new Rectangle((int)e.getCornerX(), (int)e.getCornerY(), 2*e.getSizeX(), 2*e.getSizeY());
 //rect((int)e.getCornerX(), (int)e.getCornerY(), 2*e.getSizeX(), 2*e.getSizeY());
 //println("r1 = "+(int)e.getCornerX()+" "+(int)e.getCornerY());
 //for (Enemy f : enemies) {
 for (int i = 0; i < enemies.size (); i++) {
 if (i != index) {
 f = enemies.get(1);
 //f = enemies.get(i);
 //Rectangle r1 = new Rectangle((int)e.getCornerX(), (int)e.getCornerY(), 2*e.getSizeX(), 2*e.getSizeY());
 //rect((int)e.getCornerX(), (int)e.getCornerY(), 2*e.getSizeX(), 2*e.getSizeY());
 Rectangle r2 = new Rectangle((int)f.getCornerX(), (int)f.getCornerY(), 2*f.getSizeX(), 2*f.getSizeY());
 //fill(0, 255, 0);
 //rect((int)f.getCornerX(), (int)f.getCornerY(), 2*f.getSizeX(), 2*f.getSizeY());
 
 float avg = (e.getSizeX() + f.getSizeX())/2;
 //println(
 
 if (r1.intersects (r2)) {
 rect((int)e.getCornerX(), (int)e.getCornerY(), 2*e.getSizeX(), 2*e.getSizeY());
 fill(0, 255, 0);
 rect((int)f.getCornerX(), (int)f.getCornerY(), 2*f.getSizeX(), 2*f.getSizeY());
 
 println("BAM");
 if (e.getX() <= f.getX()) { //e left of f
 e.setX(e.getX()-avg);
 f.setX(f.getX()+avg);
 }
 if (f.getX() < e.getX()) { //f left of e
 e.setX(e.getX()+avg);
 f.setX(f.getX()-avg);
 }
 e.setCornerX(e.getX()-e.getSizeX());
 e.setCornerY(e.getY()-e.getSizeY());
 f.setCornerX(f.getX()-f.getSizeX());
 f.setCornerY(f.getY()-f.getSizeY());
 
 r1 = new Rectangle((int)e.getCornerX(), (int)e.getCornerY(), 2*e.getSizeX(), 2*e.getSizeY());
 r2 = new Rectangle((int)f.getCornerX(), (int)f.getCornerY(), 2*f.getSizeX(), 2*f.getSizeY());
 
 //rect((int)e.getCornerX(), (int)e.getCornerY(), 2*e.getSizeX(), 2*e.getSizeY());
 //fill(0, 255, 0);
 //rect((int)f.getCornerX(), (int)f.getCornerY(), 2*f.getSizeX(), 2*f.getSizeY());
 }
 }
 //println("r2 = "+(int)f.getCornerX()+" "+(int)f.getCornerY());
 }
 }
 */

void buddySystem(int e1, int e2) {
  Enemy e = enemies.get(e1);
  Enemy f = enemies.get(e2);
  Rectangle r1 = e.getBounds();
  Rectangle r2 = f.getBounds();

  if (r1.intersects (r2)) {
    //println("BAM");

    if (e.getX() <= f.getX()) { //e left of f
      e.setX(e.getX()-0.4);
      f.setX(f.getX()+0.4);
    }
    if (f.getX() < e.getX()) { //f left of e
      e.setX(e.getX()+0.4);
      f.setX(f.getX()-0.4);
    }
    if (e.getY() <= f.getY()) { //e above f
      e.setY(e.getY()-0.4);
      f.setY(f.getY()+0.4);
    }
    if (f.getY() < e.getY()) { //f above e
      e.setY(e.getY()+0.4);
      f.setY(f.getY()-0.4);
    }
    e.setCornerX(e.getX()-e.getSizeX());
    e.setCornerY(e.getY()-e.getSizeY());
    f.setCornerX(f.getX()-f.getSizeX());
    f.setCornerY(f.getY()-f.getSizeY());
  }
}


void drawEnemies(boolean move) {
  for (int i = 0; i < enemies.size (); i++) {
    Enemy e = enemies.get(i);
    if (!e.getIsDead()) {
      e.spawn();
      for (int j = 0; j < enemies.size (); j++) {
        if ( i != j ) {
          buddySystem(i, j);
        }
      }
      //Enemy f = enemies.get(j);

      //buddySystem(i);
      if (move) {
        e.move(currRoom.getSizeX(), currRoom.getSizeY(), player.getX(), player.getY());
      }
      //buddySystem(i);
    }
  }
}

