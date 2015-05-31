public class Enemy extends Killable {

  private float dx, dy;
  private int speed = 1;

  public Enemy() {
    this(50, 50, 10, 10);
  }

  public Enemy(float x_, float y_, int sx, int sy) {
    super(x_, y_, sx, sy);
  }  

  public void move(int roomx, int roomy, float xx, float yy) {
    super.move(roomx, roomy);
    if (x != xx || y != yy) {
      dx = xx - x;
      dy = yy - y;

      float angle = (float)Math.atan2(dy, dx);

      x += speed * Math.cos(angle);
      y += speed * Math.sin(angle);

    }
  }

  void spawn() {
    setIsDead(false);
    
    fill(255, 0, 0); 
    ellipse(x, y, sizeY, sizeX);
  }
  
  
}

