public class Killable {

  public float x, y;
  public int sizeX, sizeY;
  public boolean isDead;
  public int knifeCount;

  public Killable(float x_, float y_, int sx, int sy) {
    x = x_;
    y = y_;
    sizeX = sx;
    sizeY = sy;
    isDead = false;
  }  

  public Killable() {
  }

  void move() {
  }  

  public float getX() {
    return x;
  }

  public float getY() {
    return y;
  }
}

