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

  private Door doorNorth, doorSouth, doorEast, doorWest;

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

    doorNorth = null; 
    doorSouth = null; 
    doorEast = null; 
    doorWest = null;
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

  public void setRoom(int dir) {
    if (dir == NORTH) {
      north = new Room(x, y-sizeY, false, true, false, false, roomNum++);
    } else if (dir == SOUTH) {
      south = new Room(x, y+sizeY, true, false, false, false, roomNum++);
    } else if (dir == EAST) {
      east = new Room(x+sizeX, y, false, false, false, true, roomNum++);
    } else {
      west = new Room(x-sizeX, y, false, false, true, false, roomNum++);
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
}

