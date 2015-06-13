public class Killable {

  public float x, y;
  public int sizeX, sizeY;
  public boolean isDead;
  public int knifeCount;
  public int roomX;
  public int roomY;
  public float cornerX;
  public float cornerY;


  public Killable(float x_, float y_, int sx, int sy) {
    x = x_;
    y = y_;
    sizeX = sx;
    sizeY = sy;
    isDead = false;
    cornerX = x-sizeX;
    cornerY = y-sizeY;
  }  

  public Killable() {
    this(width/2, height/2, 15, 15);
  }

  public void move(int roomx, int roomy) {
    roomX = roomx;
    roomY = roomY;
    x = constrain(x, width/2-roomx+getSizeX(), width/2+roomx-getSizeX()); 
    y = constrain(y, height/2-roomy+getSizeY(), height/2+roomy-getSizeY());
  }  

  public float getX() {
    return x;
  }

  public float getY() {
    return y;
  }
  
  public void setX(float xx){
    x = xx;
  }
  
  public void setY(float yy){
    y = yy;
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
  
  public float getCornerX(){
    return cornerX;
  }
  
  public float getCornerY(){
    return cornerY;
  }
  
  public void setCornerX(float xx){
    cornerX = xx;
  }
  
  public void setCornerY(float yy){
    cornerY = yy;
  }
  
  public Rectangle getBounds(){
   Rectangle r = new Rectangle((int)x-sizeX, (int)y-sizeY, sizeX*2, sizeY*2);
   return r;
  }
  
}

