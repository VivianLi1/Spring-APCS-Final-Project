public class Room {

  private final int NORTH = 0;
  private final int SOUTH = 1;
  private final int EAST = 2;
  private final int WEST = 3;

  private float x, y;
  private int sizeX, sizeY;
  private boolean hasNorth, hasSouth, hasEast, hasWest;
  private int roomNum;
  private Door doorNorth, doorSouth, doorEast, doorWest;
  
  private ArrayList<Enemy> enemies = new ArrayList<Enemy>();
  private ArrayList<Knife> thrown = new ArrayList<Knife>();
  private Player player;
  
   
  public Room(float x_, float y_, int sx, int sy, boolean n, boolean s, boolean e, boolean w, int num, Player p) {
    x = x_;
    y = y_;

    sizeX = sx;
    sizeY = sy;

    hasNorth = n;
    hasSouth = s;
    hasEast = e;
    hasWest = w;

    roomNum = num;
    
    player = p;
    makeEnemies(3);
  }

  public Room(int num, Player p) {
    this(width/2, height/2, 200, 200, false, false, false, false, num, p);
  }

  public Room(Player p) {
    this(1, p);
  }

  public float getX() {
    return x;
  }

  public float getY() {
    return y;
  }
  
  public int getSizeX() {
    return sizeX;
  }

  public int getSizeY() {
    return sizeY;
  }

  public void create() {
    rectMode(CORNERS);
    fill(000, 140, 174);
    rect(width/2-sizeX, height/2-sizeY, width/2+sizeX, height/2+sizeY);
  }

  public void setHasDirection(int dir, boolean b) {
    if (dir == NORTH) {
      hasNorth = b;
    }
    if (dir == SOUTH) {
      hasSouth = b;
    }
    if (dir == EAST) {
      hasEast = b;
    }
    if (dir == WEST) {
      hasWest = b;
    }
  }

  public boolean getHasDirection(int dir) {
    if (dir == NORTH) {
      return hasNorth;
    } else if (dir == SOUTH) {
      return hasSouth;
    } else if (dir == EAST) {
      return hasEast;
    } else {
      return hasWest;
    }
  }

  public void drawDoors() {
    if (hasNorth) {
      doorNorth = new Door(x, y, sizeX, sizeY, NORTH);
      doorNorth.createDoor();
    }
    if (hasSouth) {
      doorSouth = new Door(x, y, sizeX, sizeY, SOUTH);
      doorSouth.createDoor();
    }
    if (hasEast) {
      doorEast = new Door(x, y, sizeX, sizeY, EAST);
      doorEast.createDoor();
    }
    if (hasWest) {
      doorWest = new Door(x, y, sizeX, sizeY, WEST);
      doorWest.createDoor();
    }
    /*
    println("NORTH: " + hasNorth);
     println("SOUTH: " + hasSouth);
     println("EAST: " + hasEast);
     println("WEST: " + hasWest);
     */
  }

  public Door getDoor(int dir) {
    if (dir == NORTH) {
      return doorNorth;
    } else if (dir == SOUTH) {
      return doorSouth;
    } else if (dir == EAST) {
      return doorEast;
    } else {
      return doorWest;
    }
  }

  public void setRoomNum(int i) {
    roomNum = i;
  }

  public int getRoomNum() {
    return roomNum;
  }
  
  void makeEnemies(int num) {
    Random r = new Random();
    for (int i = 0; i < num-1; i++) {
      Enemy e = new Enemy(player.getX()+(r.nextInt(300)-100), player.getY()+(r.nextInt(300)-100), 20, 20);
      relocate(e);
      enemies.add(e);
    }
    int makeSquid = r.nextInt(2);
    if (makeSquid == 1) {
      Squid s = new Squid(player.getX()+(r.nextInt(300)-100), player.getY()+(r.nextInt(300)-100), 15, 15);
      relocate(s);
      enemies.add(s);
    }else{
      Enemy e = new Enemy(player.getX()+(r.nextInt(300)-100), player.getY()+(r.nextInt(300)-100), 20, 20);
      relocate(e);
      enemies.add(e);
    }
  }
  
  void addKnives(Player p) {
    if (millis() - time >= wait) {
      //enemyCollision();
      player.setKnives(player.getKnives() - 1);
      Knife k = new Knife(p.getX(), p.getY(), direction);
      thrown.add(k);
      time = millis();
      //println(thrown.size());
    }
  }

  ArrayList<Knife> getThrown() {
    return thrown;
  }
  
  void relocate(Enemy e){
    if (e.getX() <= player.getX()) { 
      float xx = constrain(e.getX(), width/2-sizeX+e.getSizeX(), player.getX()-100);
      e.setX(xx);
    }
    if (e.getX() > player.getX()) {
      float xx = constrain(e.getX(), player.getX()+100, width/2+sizeX-e.getSizeX());
      e.setX(xx);
    }
    if (e.getY() <= player.getY()) {
      float yy = constrain(e.getY(), height/2-sizeY+e.getSizeY(), player.getY()-100);
      e.setY(yy);
    }
    if (e.getY() > player.getY()) {
      float yy = constrain(e.getY(), player.getY()+100, height/2+sizeY-e.getSizeY());
      e.setY(yy);
    }
  }
  
  
  ArrayList<Enemy> getEnemies(){
    return enemies;
  }
  
}
