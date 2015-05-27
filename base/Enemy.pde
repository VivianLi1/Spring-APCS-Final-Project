public class Enemy extends Killable{
  
  private float dx, dy;
  private int speed = 1;
  
  public Enemy(){
    this(50,50,10,10);
  }
  
  public Enemy(float x_, float y_, int sx, int sy){
    super(x_, y_, sx, sy);
  }  
 
 public void move(float xx, float yy){
    if(x != xx || y != yy){
      dx = xx - x;
      dy = yy - y;
      
      float angle = (float)Math.atan2(dy, dx);
      
      x += speed * Math.cos(angle);
      y += speed * Math.sin(angle);
      
      x = constrain(x, width/2-200+16, width/2+200-16); 
      y = constrain(y, height/2-200+16, height/2+200-16);
    }
 }
 
 void spawn(){
    fill(255, 0, 0); 
    ellipse(x, y, sizeY, sizeX);
  } 
}
