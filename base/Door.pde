public class Door {

  private final int NORTH = 0;
  private final int SOUTH = 1;
  private final int EAST = 2;
  private final int WEST = 3;

  private float xcord, ycord;
  private float x, y;
  private int sizeX, sizeY;
  private int direction;
  private int w;
  private int l;

  public Door(float x_, float y_, int sx, int sy, int dir) {
    x = x_;
    y = y_;
    sizeX = sx;
    sizeY = sy;

    w = 20;
    l = sizeX;

    direction = dir;
    if (dir == NORTH) { 
      xcord = (x - sizeX/2);
      ycord = y - sizeY;
    } else if (dir == SOUTH) {
      xcord = x - sizeX/2;
      ycord = y + sizeY - w;
    } else if (dir == EAST) {
      xcord = x + sizeX - w;
      ycord = y - sizeY/2;
    } else if (dir == WEST) {
      xcord = x - sizeX;
      ycord = y - sizeY/2;
    }
  }

  public void createDoor() {
    rectMode(CORNER);
    //fill(0);
    if (direction == NORTH || direction == SOUTH) {
      rect(xcord, ycord, l, w);
    } else {
      rect(xcord, ycord, w, l);
    }
  }


  //need to do this
  public boolean inDoor(Player p) {
    if (direction == NORTH) {
      return (p.getX() < xcord + l && p.getX() > xcord && p.getY() < ycord + l);
    } else if (direction == SOUTH) {
      return (p.getX() < xcord + l && p.getX() > xcord && p.getY() > ycord + l);
    } else if (direction == EAST) {
      return (p.getX() < xcord + w && p.getY() > ycord && p.getY() < ycord + l);
    } else {
      return (p.getX() > xcord + w && p.getY() > ycord && p.getY() < ycord + l);
    }
  }
}

