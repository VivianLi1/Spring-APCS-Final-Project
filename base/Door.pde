public class Door {

  private int x, y;
  private int sizeX, sizeY;
  private int direction;

  public Door(int x_, int y_, int sx, int sy, int dir) {
    x = x_;
    y = y_;
    sizeX = sx;
    sizeY = sy;

    direction = dir;
  }

  public void createDoor(int dir) {
    switch(dir) {
    case 0:
      rect(x - sizeX/2, y - sizeY, x + sizeX/2, y - sizeY + 20);
    case 1:
      rect(x - sizeX/2, y + sizeY - 20, x + sizeX/2, y + sizeY);
    case 2:
      rect(x + sizeX - 20, y - sizeY/2, x + sizeX, y + sizeY/2);
    case 3:
      rect(x - sizeX, y - sizeY/2, x - sizeX + 20, y + sizeY/2);
    }
  }

  //need to do this
  public boolean inDoor(Player p) {
    return false;
  }
}

