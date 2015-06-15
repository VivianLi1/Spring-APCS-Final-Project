public class Special {

  float x, y;
  int sizeX, sizeY;

  public Special(float x_, float y_) {
    x = x_;
    y = y_;

    sizeX = 50;
    sizeY = 50;
  }

  void drawSpecial() {
    rect(x, y, sizeX, sizeY);
  }

  float getX() {
    return x;
  }

  float getY() {
    return y;
  }

  int getSizeX() {
    return sizeX;
  }

  int getSizeY() {
    return sizeY;
  }

  boolean inSpecial(Player p) {
    return (p.getX() + p.getSizeX() > x && p.getX() - p.getSizeX() < x + sizeX && 
      p.getY() + p.getSizeY() > y && p.getY() - p.getSizeY() < y + sizeY);
  }
}

