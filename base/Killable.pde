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
    this(width/2, height/2, 15, 15);
  }

  public void move(int roomx, int roomy) {
    x = constrain(x, width/2-roomx+getSizeX(), width/2+roomx-getSizeY()); 
    y = constrain(y, height/2-roomy+getSizeX(), height/2+roomy-getSizeY());
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

  public boolean getIsDead() {
    return isDead;
  }
  
  public void setIsDead(boolean dead){
    isDead = dead;
  }
}

