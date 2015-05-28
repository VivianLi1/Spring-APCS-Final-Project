public class Room {

  private int sizeX, sizeY;

  public Room(int x, int y) {
    sizeX = x;
    sizeY = y;
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
}

