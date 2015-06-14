import java.awt.Rectangle;
import java.util.*;

final int START = 0;
final int PLAY = 1;
final int GAMEOVER = 2;
final int INVINCIBLE = 3;
final int RESET = 4;
final int INSTRUCTIONS = 5;

private final int NORTH = 0;
private final int SOUTH = 1;
private final int EAST = 2;
private final int WEST = 3;

boolean gameStart;

//int mode = START;
int mode = INSTRUCTIONS;
//int mode = INVINCIBLE;
//int mode = PLAY;

boolean isSpace;
int knives;
int lives = 3;
int direction = 87; //default: shoot up
ArrayList<Knife> thrown = new ArrayList<Knife>();
//ArrayList<Enemy> enemies = new ArrayList<Enemy>();
ArrayList<Enemy> enemies;

Floor currFloor;
Room currRoom;
Player player;
PImage walls;
PImage cave;

int time;
int wait = 500;

int time2;
int time3;
boolean hit;
int invincibility = 3000;

int collisions = 0;

void setup() {
  size(1200, 600, P2D);
  background(35);
  knives = 100;

  walls = loadImage("walls.png");
  cave = loadImage("cave.png");

  player = new Player(width/2, height/2, 24, 24);

  currFloor = new Floor(6, player);
  currFloor.generate();
  currRoom = currFloor.getSpawn();

  enemies = currRoom.getEnemies();
  //makeEnemies(3);

  //player.spawn();
  gameStart = true;
  time2 = millis();
}

void draw() {
  switch(mode) {
  case 0:
    startGame();
    break;
  case 1: 
    play();
    break;
  case 2: 
    gameOver();
    break;
  case 3:
    if (!(millis() - time2 >= invincibility)) {
      invincible();
      textSize(100);
      fill(255, 255, 255);
      textAlign(CENTER);
      text("GET READY", width/2, height/2-75);
      timer(invincibility, millis() - time2);
    } else {
      mode = PLAY;
    }
    break;
  case 4:
    reset();
    break;
  case 5:
    instructions();
    break;
  }
  //println(mouseX, mouseY);
}

void keyPressed() {
  //println(keyCode);
  if (mode == PLAY) {
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
    if (keyCode == 32) {    // SPACE - RESTART
      mode = RESET;
    }
  }
  if (mode == START) {
    if (keyCode == 32) {    // SPACE - START GAME
      mode = RESET;
    }
    if (keyCode == 81) {    // Q - HOW TO PLAY
      mode = INSTRUCTIONS;
    }
  }
  if (mode == INSTRUCTIONS){
    if (keyCode == 81) {    // Q - RETURN TO MENU
      mode = START;
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

void startGame() {
  background(35);
  noStroke();
  smooth();

  fill(255, 255, 255);
  textAlign(CENTER);
  textSize(150);
  text("OCEAN RAVIOLI", width/2, height/2-75);

  textSize(60);
  text("PRESS SPACEBAR TO BEGIN", width/2, height/2+75);
  text("PRESS 'Q' FOR HOW TO PLAY", width/2, height/2+136);
}

void instructions() {
  background(35);
  noStroke();
  smooth();
  
  fill(255, 255, 255);
  textSize(75);
  textAlign(CENTER);
  text("HOW TO PLAY", width/2, height/2-140);
  
  textSize(40);
  text(" W  -     UP  ", width/2, height/2-80);
  text(" A  -   LEFT ", width/2, height/2-40);
  text("  S  -  DOWN", width/2, height/2);
  text(" D  -  RIGHT", width/2, height/2+40);
  text("SPACE  -  SHOOT     ", width/2, height/2+80);
  
  text("PRESS 'Q' TO RETURN TO START MENU", width/2, height/2+150);
  
}

void invincible() {
  background(35);
  noStroke();
  smooth();

  image(walls, width/2-250, height/2-250);
  if (currRoom.getHasDirection(NORTH)) {
    image(cave, width/2-45, height/2-246);
  }
  if (currRoom.getHasDirection(SOUTH)) {
    image(cave, width/2-45, height/2+156);
  }
  if (currRoom.getHasDirection(WEST)) {
    image(cave, width/2-246, height/2-45);
  }
  if (currRoom.getHasDirection(EAST)) {
    image(cave, width/2+156, height/2-45);
  }

  currRoom.create();
  currFloor.setDirections(currRoom);

  fill(000, 140, 174);
  currRoom.drawDoors();
  player.spawn();
  drawEnemies(false);
}

void timer(int t, int ms) {
  int countdown = ms;
  /*
  textSize(100);
   fill(255, 255, 255);
   textAlign(CENTER);
   text("GET READY", width/2, height/2-75);
   */
  fill(255, 255, 255);
  textSize(150);
  textAlign(CENTER);
  text(""+((t/1000)-(countdown/1000)), width/2, height/2+75);
}

void play() {
  background(35);
  noStroke();
  smooth();

  image(walls, width/2-250, height/2-250);
  if (currRoom.getHasDirection(NORTH)) {
    image(cave, width/2-45, height/2-246);
  }
  if (currRoom.getHasDirection(SOUTH)) {
    image(cave, width/2-45, height/2+156);
  }
  if (currRoom.getHasDirection(WEST)) {
    image(cave, width/2-246, height/2-45);
  }
  if (currRoom.getHasDirection(EAST)) {
    image(cave, width/2+156, height/2-45);
  }

  currRoom.create();
  currFloor.setDirections(currRoom);
  fill(000, 140, 174);
  currRoom.drawDoors();

  if (!player.getIsDead()) {
    //println(gameStart);
    player.spawn();
    player.move(currRoom.getSizeX(), currRoom.getSizeY());

    if (!hit) {
      enemyCollision();
    } else if (!(millis() - time3 >= invincibility)) {
      invincible();
      timer(3000, millis() - time3);
    } else {
      hit = false;
      mode = PLAY;
    }

    //println(hit);
    //println(lives);

    drawKnives();
    drawEnemies(true);

    /*
    if(enemyCollision() && lives > 0){
     mode = INVINCIBLE;
     }
     */
    doorCollision();

    if (lives == 0) {
      player.setIsDead(true);
    }

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
  textSize(150);
  text("GAME OVER", width/2, height/2-75);
  textSize(75);
  text("PRESS SPACEBAR TO RESTART", width/2, height/2+75);
}

void reset() {
  isSpace = false;
  knives = 100;
  lives = 3;
  direction = 87;
  thrown = new ArrayList<Knife>();
  //enemies = new ArrayList<Enemy>();
  currFloor = new Floor(6, player);
  currFloor.generate();
  currRoom = currFloor.getSpawn();
  enemies = currRoom.getEnemies();
  player = new Player(width/2, height/2, 24, 24);
  //makeEnemies(3);
  player.spawn();
  gameStart = true;
  time2 = millis();
  mode = INVINCIBLE;
}

void drawKnives() {
  for (Knife k : thrown) {
    if (killEnemy(k)) {
      k.setStopped(true);
    } else if (doors(k)) {
      k.setStopped(true);
    } else if (!k.getStopped()) {
      k.move(currRoom.getSizeX(), currRoom.getSizeY());
    }
    fill(133, 0, 12);
    ellipseMode(RADIUS);
    ellipse(k.getX(), k.getY(), 8, 8);
  }
}

/*
void enemyCollision() {
 for (Enemy e : enemies) {
 if (e.getIsDead() == true) {
 continue;
 } else {
 float overlap = Math.abs(5+e.getSizeX());
 if (Math.abs(player.getX()-e.getX()) < overlap && Math.abs(player.getY()-e.getY()) < overlap) {
 lives--;
 }
 }
 }
 //return false;
 }
 */

/*
if (!(millis() - time2 >= invincibility)) {
 invincible();
 timer(invincibility, millis() - time2);
 */

void enemyCollision() {
  for (Enemy e : enemies) {
    //println(""+millis() + " "+time3 + ""+invincibility);
    if (e.getIsDead() == true) {
      continue;
    } else {
      float overlap = Math.abs(5+e.getSizeX());
      if (Math.abs(player.getX()-e.getX()) < overlap && Math.abs(player.getY()-e.getY()) < overlap) {
        lives--;
        hit = true;
        time3 = millis();
      }
      if (lives == 0) {
        player.setIsDead(true);
      }
    }
  }
}

/*
void makeEnemies(int num) {
 int count = 0;
 Random r = new Random();
 for (int i = 0; i < num; i++) {
 Enemy e = new Enemy(player.getX()-r.nextInt(100)-50, player.getY()+r.nextInt(100)-50, 20, 20);
 enemies.add(e);
 }
 }
 */

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

boolean doors(Knife k) {
  if (k.getDir() == 87 && currRoom.getHasDirection(NORTH)) {
    if (k.hitDoor(currRoom.getDoor(NORTH))) {
      k.setY(k.getY()+1);
      //k.setY(constrain(k.getY(), height/2-currRoom.getSizeX()+20+8, height/2+currRoom.getSizeX()-8));
    }
  } else if (k.getDir() == 65 && currRoom.getHasDirection(WEST)) {
    return k.hitDoor(currRoom.getDoor(WEST));
  } else if (k.getDir() == 83 && currRoom.getHasDirection(SOUTH)) {
    return k.hitDoor(currRoom.getDoor(SOUTH));
  } else if (k.getDir() == 68 && currRoom.getHasDirection(EAST)) {
    return k.hitDoor(currRoom.getDoor(EAST));
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
      currRoom = currFloor.getRoom(currFloor.getIndX() + 1, currFloor.getIndY());
      enemies = currRoom.getEnemies();
      currFloor.setIndX(currFloor.getIndX() + 1);
      player.setX(currRoom.getX());
      player.setY(currRoom.getY() + currRoom.getSizeY() / 2);
    }
  } 
  if ( currRoom.getHasDirection(SOUTH)) {
    if (currRoom.getDoor(SOUTH).inDoor(player)) {
      currRoom = currFloor.getRoom(currFloor.getIndX() - 1, currFloor.getIndY());
      enemies = currRoom.getEnemies();
      currFloor.setIndX(currFloor.getIndX() - 1);
      player.setX(currRoom.getX());
      player.setY(currRoom.getY() - currRoom.getSizeY() / 2);
    }
  } 
  if (currRoom.getHasDirection(EAST)) {
    if (currRoom.getDoor(EAST).inDoor(player)) {
      currRoom = currFloor.getRoom(currFloor.getIndX(), currFloor.getIndY() + 1);
      enemies = currRoom.getEnemies();
      currFloor.setIndY(currFloor.getIndY() + 1);
      player.setX(currRoom.getX() - currRoom.getSizeX() / 2);
      player.setY(currRoom.getY());
    }
  }

  if (currRoom.getHasDirection(WEST)) {
    if (currRoom.getDoor(WEST).inDoor(player)) {
      currRoom = currFloor.getRoom(currFloor.getIndX(), currFloor.getIndY() - 1);
      enemies = currRoom.getEnemies();
      currFloor.setIndY(currFloor.getIndY() - 1);
      player.setX(currRoom.getX() + currRoom.getSizeX() / 2);
      player.setY(currRoom.getY());
    }
  }


  //println("NORTH:" + currRoom.getHasDirection(NORTH));
  //println("SOUTH:" + currRoom.getHasDirection(SOUTH));
  //println("EAST:" + currRoom.getHasDirection(EAST));
  //println("WEST:" + currRoom.getHasDirection(WEST));
}

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
