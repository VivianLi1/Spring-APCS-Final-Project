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
    l = sizeX/2-2;

    direction = dir;
    if (dir == NORTH) { 
      xcord = (x - sizeX/4);
      ycord = y - sizeY;
    } else if (dir == SOUTH) {
      xcord = x - sizeX/4;
      ycord = y + sizeY - w;
    } else if (dir == EAST) {
      xcord = x + sizeX - w;
      ycord = y - sizeY/4;
    } else if (dir == WEST) {
      xcord = x - sizeX;
      ycord = y - sizeY/4;
    }
  }

  public void createDoor() {
    rectMode(CORNER);
    //fill(0);
    if (direction == NORTH || direction == SOUTH) {
      rect(xcord, ycord, l+0.5, w);
    } else {
      rect(xcord, ycord, w, l+0.5);
    }
    //println(mouseX < xcord + l && mouseX > xcord && mouseY < ycord + w && mouseY > ycord);
    //println(mouseX <= xcord + w && mouseX >= xcord && mouseY >= ycord && mouseY <= ycord + l);
  }

  //need to do this
  public boolean inDoor(Player p) {
    if (direction == NORTH) {
      return (p.getX() + p.getSizeX() <= xcord + l && p.getX() - p.getSizeX() >= xcord && p.getY() - p.getSizeY() <= ycord + w && p.getY() - p.getSizeY() >= ycord);
    } else if (direction == SOUTH) {
      return (p.getX() + p.getSizeX() <= xcord + l && p.getX() + p.getSizeX() >= xcord && p.getY() + p.getSizeY() <= ycord + w && p.getY() + p.getSizeY() >= ycord);
    } else if (direction == EAST) {
      return (p.getX() + p.getSizeX() <= xcord + w && p.getX() + p.getSizeX() >= xcord && p.getY() + p.getSizeY() >= ycord && p.getY() + p.getSizeY() <= ycord + l);
    } else {
      return (p.getX() - p.getSizeX() <= xcord + w && p.getX() + p.getSizeX() >= xcord && p.getY() + p.getSizeY() >= ycord && p.getY() - p.getSizeY() <= ycord + l);
    }
  }

  public float getX() {
    return x;
  }

  public float getY() {
    return y;
  }
  
  public Rectangle getBounds(){
    Rectangle r;
    if (direction == NORTH || direction == SOUTH) {
      r = new Rectangle((int)xcord, (int)ycord, l, w);
    }else{
      r = new Rectangle((int)xcord, (int)ycord, w, l);
    }
    return r;
  }
}
