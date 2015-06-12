public class Room {

  private final int NORTH = 0;
  private final int SOUTH = 1;
  private final int EAST = 2;
  private final int WEST = 3;

  private float x, y;
  private int sizeX, sizeY;
  private boolean hasNorth, hasSouth, hasEast, hasWest;
  private Room north, south, east, west;
  //private Room parNorth, parSouth, parEast, parWest;
  private int roomNum;

  private Door doorNorth, doorSouth, doorEast, doorWest;

  public Room(float x_, float y_, int sx, int sy, boolean n, boolean s, boolean e, boolean w, Room pN, Room pS, Room pE, Room pW, int num) {
    x = x_;
    y = y_;

    sizeX = sx;
    sizeY = sy;

    hasNorth = n;
    hasSouth = s;
    hasEast = e;
    hasWest = w;

    north = pN;
    south = pS;
    east = pE;
    west = pW;

    roomNum = num;

    doorNorth = null; 
    doorSouth = null; 
    doorEast = null; 
    doorWest = null;
  }


  public Room(float x_, float y_, int sx, int sy, int num) {
    this(x_, y_, sx, sy, false, false, false, false, null, null, null, null, num);
  }

  public Room(float x_, float y_, boolean n, boolean s, boolean e, boolean w, Room pN, Room pS, Room pE, Room pW, int num) {
    this(x_, y_, 200, 200, n, s, e, w, pN, pS, pE, pW, num);
  }

  public Room(float x_, float y_, int num) {
    this(x_, y_, 200, 200, false, false, false, false, null, null, null, null, num);
  }

  public Room() {
    //this(width/2, height/2, 400, 250, false, false, false, false, 1);
    this(width/2, height/2, 200, 200, false, false, false, false, null, null, null, null, 1);
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

  public void setRoom(int dir) {
    /*
    if (dir == NORTH) {
     north = new Room(x, y-sizeY, false, true, false, false, roomNum++);
     } else if (dir == SOUTH) {
     south = new Room(x, y+sizeY, true, false, false, false, roomNum++);
     } else if (dir == EAST) {
     east = new Room(x+sizeX, y, false, false, false, true, roomNum++);
     } else {
     west = new Room(x-sizeX, y, false, false, true, false, roomNum++);
     }
     */
    if (dir == NORTH) {
      north = new Room(x, y, false, true, false, false, null, this, null, null, roomNum++);
    } 
    if (dir == SOUTH) {
      south = new Room(x, y, true, false, false, false, this, null, null, null, roomNum++);
    } 
    if (dir == EAST) {
      east = new Room(x, y, false, false, false, true, null, null, null, this, roomNum++);
    } 
    if (dir == WEST) {
      west = new Room(x, y, false, false, true, false, null, null, this, null, roomNum++);
    }
  }

  public Room getRoom(int dir) {
    if (dir == NORTH) {
      return north;
    } else if (dir == SOUTH) {
      return south;
    } else if (dir == EAST) {
      return east;
    } else {
      return west;
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

