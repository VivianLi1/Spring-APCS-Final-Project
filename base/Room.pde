public class Room {

  private final int NORTH = 0;
  private final int SOUTH = 1;
  private final int EAST = 2;
  private final int WEST = 3;

  private float x, y;
  private int sizeX, sizeY;
  private boolean hasNorth, hasSouth, hasEast, hasWest;
  private Room north, south, east, west;
  private int roomNum;


  public Room(float x_, float y_, int sx, int sy, boolean n, boolean s, boolean e, boolean w, int num) {
    x = x_;
    y = y_;

    sizeX = sx;
    sizeY = sy;

    hasNorth = n;
    hasSouth = s;
    hasEast = e;
    hasWest = w;

    north = null;
    south = null;
    east = null;
    west = null;

    roomNum = num;
  }


  public Room(float x_, float y_, int sx, int sy, int num) {
    this(x_, y_, sx, sy, false, false, false, false, num);
  }

  public Room(float x_, float y_, boolean n, boolean s, boolean e, boolean w, int num) {
    this(x_, y_, 200, 200, n, s, e, w, num);
  }

  public Room(float x_, float y_, int num) {
    this(x_, y_, 200, 200, false, false, false, false, num);
  }

  public Room() {
    //this(width/2, height/2, 400, 250, false, false, false, false, 1);
    this(width/2, height/2, 200, 200, false, false, false, false, 1);
  }

  public int getSizeX() {
    return sizeX;
  }

  public int getSizeY() {
    return sizeY;
  }

  public void create() {
    rectMode(CORNERS);
    fill(100);
    rect(width/2-sizeX, height/2-sizeY, width/2+sizeX, height/2+sizeY);
  }

  public void setHasDirection(int dir, boolean b) {
    switch(dir) {
    case 0: 
      hasNorth = b;
    case 1: 
      hasSouth = b;
    case 2: 
      hasEast = b;
    case 3: 
      hasWest = b;
    }
  }

  public boolean getHasDirection(int dir) {
    boolean b = false;
    switch(dir) {
    case 0: 
      b = hasNorth;
    case 1: 
      b = hasSouth;
    case 2: 
      b = hasEast;
    case 3: 
      b = hasWest;
    }
    return b;
  }

  public void setRoom(int dir) {
    switch(dir) {
    case 0: 
      north = new Room(x, y-sizeY, false, true, false, false, roomNum++);
    case 1: 
      south = new Room(x, y+sizeY, true, false, false, false, roomNum++);
    case 2: 
      east = new Room(x+sizeX, y, false, false, false, true, roomNum++);
    case 3: 
      west = new Room(x-sizeX, y, false, false, true, false, roomNum++);
    }
  }

  public void drawDoors() {
    if (hasNorth) {
      Door doorNorth = new Door(x, y, sizeX, sizeY, NORTH);
      doorNorth.createDoor();
    }
    if (hasSouth) {
      Door doorSouth = new Door(x, y, sizeX, sizeY, SOUTH);
      doorSouth.createDoor();
    }
    if (hasEast) {
      Door doorEast = new Door(x, y, sizeX, sizeY, EAST);
      doorEast.createDoor();
    }
    if (hasWest) {
      Door doorWest = new Door(x, y, sizeX, sizeY, WEST);
      doorWest.createDoor();
    }
  }

  public void setRoomNum(int i) {
    roomNum = i;
  }

  public int getRoomNum() {
    return roomNum;
  }
}

