public class Door {

  private float xcord, ycord;
  private int x, y;
  private int sizeX, sizeY;
  private int direction;
  private int w = 20;
  private int l = sizeX/2;

  public Door(int x_, int y_, int sx, int sy, int dir) {
    x = x_;
    y = y_;
    sizeX = sx;
    sizeY = sy;

    direction = dir;
    switch(dir) {
    case 0: 
      xcord = x - sizeX/2;
      ycord = y - sizeY;
    case 1:
      xcord = x - sizeX/2;
      ycord = y + sizeY - w;
    case 2:
      xcord = x + sizeX - w;
      ycord = y - sizeY/2;
    case 3:
      xcord = x - sizeX;
      ycord = y - sizeY/2;
    }
  }

  public void createDoor(int dir) {
    switch(dir) {
    case 0:
      rect(xcord, ycord, l, w);
    case 1:
      rect(xcord, ycord, l, w);
    case 2:
      rect(xcord, ycord, l, w);
    case 3:
      rect(xcord, ycord, l, w);
    }
  }

  //need to do this
  public boolean inDoor(Player p) {
    return false;
  }
}

