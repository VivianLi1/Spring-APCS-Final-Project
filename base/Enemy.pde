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
    
    ellipseMode(RADIUS);
    fill(255, 0, 0); 
    ellipse(x, y, sizeY, sizeX);
  }
  
  void resetX(float xx, int mode) {
    if (mode == 0) { //e left of f
      x = constrain(x, width/2-roomX+getSizeX(), xx);
    } else { //f left of e
      x = constrain(x, xx, width/2+roomX-getSizeX());
    }
    x = constrain(x, width/2-roomX+getSizeX(), width/2+roomX-getSizeX());
  }

  void resetY(float yy, int mode) {
    if (mode == 0) { //e above f
      y = constrain(y, height/2-roomY+getSizeY(), yy);
    } else { //f above e
      y = constrain(y, yy, height/2+roomY-getSizeY());
    }
  }

  
  
}

