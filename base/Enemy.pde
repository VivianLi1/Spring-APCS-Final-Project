public class Enemy{
  
  private float x, y;
  private int sizeX, sizeY;
  private boolean isDead;
  
  public Enemy(){
    this(50,50,10,10);
  }
  
  public Enemy(float x_, float y_, int sx, int sy){
    x = x_;
    y = y_;
    sizeX = sx;
    sizeY = sy;
    isDead = false;
  }  
 
 void spawn(){
  fill(255, 0, 0); 
  ellipse(x, y, sizeY, sizeX);
  } 
}
