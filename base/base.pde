import java.awt.Rectangle;
import java.util.*;

final int START = 0;
final int PLAY = 1;
final int GAMEOVER = 2;
final int INVINCIBLE = 3;
final int RESET = 4;
final int INSTRUCTIONS = 5;
final int CHEAT = 6;

private final int NORTH = 0;
private final int SOUTH = 1;
private final int EAST = 2;
private final int WEST = 3;

boolean gameStart;
boolean newGame;

int mode = START;
//int mode = INSTRUCTIONS;
//int mode = INVINCIBLE;
//int mode = PLAY;
//int mode = CHEAT;
//int mode = GAMEOVER;

boolean isSpace;
int knives;
int lives = 3;
int direction = 87; //default: shoot up
//ArrayList<Knife> thrown = new ArrayList<Knife>();
//ArrayList<Enemy> enemies = new ArrayList<Enemy>();
ArrayList<Knife> thrown;
ArrayList<Enemy> enemies;

Floor currFloor;
Room currRoom;
Player player;
//Room exitRoom;
Special exit;
Special newKnife;
int floorNum;
int enemiesKilled;

PImage walls;
PImage cave;
PImage knife1, knife2, knife3, knife4;

int time;
int wait = 500;

int time2;
int time3;
int time4;
int time5;
int delay;
boolean hit;
int invincibility = 3000;
boolean invincible;

int livesCheat;
int knivesCheat;

void setup() {
  size(1200, 600, P2D);
  background(35);

  walls = loadImage("walls.png");
  cave = loadImage("cave.png");
  knife1 = loadImage("smoll1.png");
  knife2 = loadImage("smoll2.png");
  knife3 = loadImage("smoll3.png");
  knife4 = loadImage("smoll4.png");

  player = new Player(width/2, height/2, 24, 24);
  player.setKnives(knivesCheat);

  floorNum = 1;
  enemiesKilled = 0;
  knivesCheat = 1;
  livesCheat = 3;
  currFloor = new Floor(floorNum, player);
  currFloor.generate();
  currRoom = currFloor.getSpawn();
  //currFloor.chooseExit();

  enemies = currRoom.getEnemies();
  thrown = currRoom.getThrown();

  gameStart = true;
  time2 = millis();

  time4 = millis();
  delay = 1000;

  exit = new Special(width/2, height/2);
  newKnife = new Special(width/2, height/2);
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
  case 6:
    cheat();
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
      newGame = true;
      mode = RESET;
    }
  }
  if (mode == INSTRUCTIONS) {
    if (keyCode == 82) {    // R - RETURN TO MENU
      mode = START;
    }
  }
  if (mode == START) {
    if (keyCode == 32) {    // SPACE - START GAME
      mode = RESET;
    } else if (keyCode == 81) {    // Q - HOW TO PLAY
      //println("INST");
      mode = INSTRUCTIONS;
    } else if (keyCode == 67) {    // C - CHEAT
      mode = CHEAT;
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
  text("PRESS 'C' TO CHEAT", width/2, height/2+196);
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

  text("PRESS 'R' TO RETURN TO START MENU", width/2, height/2+150);
}

void info() {
  fill(255, 255, 255);
  textSize(20);
  textAlign(LEFT);
  text("FLOOR : " + floorNum, 50, height/2 - 180);
  text("LIVES : " + lives, 50, height/2-140);
  text("KNIVES REMAINING : " + player.getKnives(), 50, height/2-100);
  text("ENEMIES KILLED : " + enemiesKilled, 50, height/2 - 60);
}

void cheat() {
  background(35);
  noStroke();
  smooth();

  fill(255, 255, 255);
  textSize(75);
  textAlign(CENTER);
  text("YOU'RE A CHEATER", width/2, height/2-140);
  
  textSize(40);
  text("LIVES : " + livesCheat, width/2, height/2-80);
  textSize(20);
  text("PRESS 'A'/'D' TO ADJUST", width/2, height/2-60);
  
  textSize(40);
  text("KNIVES : " + knivesCheat, width/2, height/2);
  textSize(20);
  text("PRESS 'W'/'S' TO ADJUST", width/2, height/2+20);
  
  textSize(40);
  text("PRESS 'R' TO RETURN TO MENU", width/2, height/2+100);
  
  if (keyPressed == true) {
    //println(key);
    if (key == 'A' || key == 'a') {
      livesCheat--;
      if (livesCheat <= 3) {
        livesCheat = 3;
      }
    }
    if (key == 'D' || key == 'd') {
      livesCheat++;
      if (livesCheat > 100) {
        livesCheat = 100;
      }
    }
    if (key == 'W' || key == 'w') {
      knivesCheat--;
      if (knivesCheat <= 1) {
        knivesCheat = 1;
      }
    }
    if (key == 'S' || key == 's') {
      knivesCheat++;
      if (knivesCheat > 100) {
        knivesCheat = 100;
      }
    }
    if (key == 'R' || key == 'r') {
      player.setKnives(knivesCheat);
      lives = livesCheat;
      //println(livesCheat);
      //println(player.getKnives());
      mode = START;
      //break;
    }
  }
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

  info();

  fill(000, 140, 174);
  currRoom.drawDoors();
  player.spawn();
  player.setKnives(knivesCheat);
  lives = livesCheat;
  drawEnemies(false);
}

void timer(int t, int ms) {
  int countdown = ms;
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

  player.setKnives(knivesCheat);
  lives = livesCheat;
  info();

  if ( currRoom.getIsExit()) {
    fill(0);
    exit.drawSpecial();
  }
  if ( currRoom.getIsKnifeRoom() && newKnife != null) {
    fill(255);
    newKnife.drawSpecial();
  }

  if (!player.getIsDead()) {
    //println(gameStart);
    player.spawn();
    player.move(currRoom.getSizeX(), currRoom.getSizeY());

    if (!hit) {
      enemyCollision();
    } else {
      if (!(millis() - time5 >= invincibility)) {
        invincible();
        textSize(150);
        timer(3000, millis() - time5);
      } else if (!(millis() - time3 >= invincibility)) {
        invincible();
        textSize(150);
        timer(3000, millis() - time3);
      } else {
        hit = false;
        mode = PLAY;
      }
    }
    
    drawKnives();
    if (hit) {
      drawEnemies(false);
    } else { 
      drawEnemies(true);
    }
    doorCollision();

    if (livesCheat < 0) {
      player.setIsDead(true);
    }

    if (millis() - time2 > wait) {
      if (isSpace && player.getKnives() > 0) {
        player.setKnives(player.getKnives()-1);
        currRoom.addKnives(player);
        time2 = millis();
        knivesCheat--;
      }
    }

    pickUpKnife();

    if (currRoom.getIsExit()) {
      exitCollision();
    }
    if ( currRoom.getIsKnifeRoom() && newKnife != null) {
      newKnifeCollision();
    }
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
  text("PRESS SPACEBAR TO RESTART", width/2, height/2+50);
  
  textSize(20);
  text("FLOOR : " + floorNum, width/2, height/2 + 105);
  text("ENEMIES KILLED : " + enemiesKilled, width/2, height/2 + 125);
}

void reset() {
  isSpace = false;
  player.setKnives(100);
  lives = 3;
  direction = 87;
  //thrown = new ArrayList<Knife>();
  //enemies = new ArrayList<Enemy>();
  floorNum = 1;
  enemiesKilled = 0;
  lives = 3;
  if (newGame) {
    knivesCheat = 1;
    livesCheat = 3;
    newGame = false;
  }
  currFloor = new Floor(floorNum, player);  
  currFloor.generate();
  currRoom = currFloor.getSpawn();
  enemies = currRoom.getEnemies();
  thrown = currRoom.getThrown();
  player = new Player(width/2, height/2, 24, 24);
  //makeEnemies(3);
  player.spawn();
  player.setKnives(1);
  gameStart = true;
  time2 = millis();
  mode = INVINCIBLE;
  //newGame = false;
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

    if (k.getDir() == 87) {
      image(knife1, k.getX()-8, k.getY()-8);
    }
    if (k.getDir() == 65) {
      image(knife4, k.getX()-8, k.getY()-8);
    }
    if (k.getDir() == 83) {
      image(knife3, k.getX()-8, k.getY()-8);
    }
    if (k.getDir() == 68) {
      image(knife2, k.getX()-8, k.getY()-8);
    }
  }
}

void enemyCollision() {
  for (Enemy e : enemies) {
    //println(""+millis() + " "+time3 + ""+invincibility);
    if (e.getIsDead() == true) {
      continue;
    } else {
      float overlap = Math.abs(5+e.getSizeX());
      if (Math.abs(player.getX()-e.getX()) < overlap && Math.abs(player.getY()-e.getY()) < overlap) {
        livesCheat--;
        hit = true;
        time3 = millis();
      }
      if (livesCheat < 0) {
        player.setIsDead(true);
      }
    }
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
        enemiesKilled++;
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
        player.setKnives(player.getKnives() + 1);
        thrown.remove(i);
        knivesCheat++;
      }
    }
  }
}

void doorCollision() {
  if (currRoom.getHasDirection(NORTH)) {
    if (currRoom.getDoor(NORTH).inDoor(player)) {
      currRoom = currFloor.getRoom(currFloor.getIndX() + 1, currFloor.getIndY());
      enemies = currRoom.getEnemies();
      thrown = currRoom.getThrown();
      currFloor.setIndX(currFloor.getIndX() + 1);
      player.setX(currRoom.getX());
      player.setY(currRoom.getY() + currRoom.getSizeY() / 2);
    }
  } 
  if ( currRoom.getHasDirection(SOUTH)) {
    if (currRoom.getDoor(SOUTH).inDoor(player)) {
      currRoom = currFloor.getRoom(currFloor.getIndX() - 1, currFloor.getIndY());
      enemies = currRoom.getEnemies();
      thrown = currRoom.getThrown();
      currFloor.setIndX(currFloor.getIndX() - 1);
      player.setX(currRoom.getX());
      player.setY(currRoom.getY() - currRoom.getSizeY() / 2);
    }
  } 
  if (currRoom.getHasDirection(EAST)) {
    if (currRoom.getDoor(EAST).inDoor(player)) {
      currRoom = currFloor.getRoom(currFloor.getIndX(), currFloor.getIndY() + 1);
      enemies = currRoom.getEnemies();
      thrown = currRoom.getThrown();
      currFloor.setIndY(currFloor.getIndY() + 1);
      player.setX(currRoom.getX() - currRoom.getSizeX() / 2);
      player.setY(currRoom.getY());
    }
  }

  if (currRoom.getHasDirection(WEST)) {
    if (currRoom.getDoor(WEST).inDoor(player)) {
      currRoom = currFloor.getRoom(currFloor.getIndX(), currFloor.getIndY() - 1);
      enemies = currRoom.getEnemies();
      thrown = currRoom.getThrown();
      currFloor.setIndY(currFloor.getIndY() - 1);
      player.setX(currRoom.getX() + currRoom.getSizeX() / 2);
      player.setY(currRoom.getY());
    }
  }
}

void buddySystem(int e1, int e2) {
  Enemy e = enemies.get(e1);
  Enemy f = enemies.get(e2);
  Rectangle r1 = e.getBounds();
  Rectangle r2 = f.getBounds();

  if (r1.intersects (r2)) {

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
      if (move) {
        if (e.move(currRoom.getSizeX(), currRoom.getSizeY(), player.getX(), player.getY())) {
          livesCheat--;
          hit = true;
          time5 = millis();
        }
      }
    }
  }
}

void exitCollision() {
  if (exit.inSpecial(player)) {
    currFloor = new Floor(floorNum + 1, player);
    floorNum++;
    setupNewFloor();
  }
}

void newKnifeCollision() {
  if (newKnife.inSpecial(player)) {
    player.setKnives(player.getKnives() + 1);
    newKnife = null;
  }
}

void setupNewFloor() {
  currFloor = new Floor(floorNum, player);
  currFloor.generate();
  currRoom = currFloor.getSpawn();
  //currFloor.chooseExit();

  enemies = currRoom.getEnemies();
  thrown = currRoom.getThrown();
  //makeEnemies(3);

  player.spawn();
}
