public class Knife {

  private float x, y;
  private int dir;

  public Knife(float xcor, float ycor, int direction) {
    x = xcor;
    y = ycor;
    dir = direction;
    
    /*
    ellipseMode(RADIUS);
    fill(255);
    ellipse(x,y,16,16);

    move();
    */
  }
  
  public float getX(){
    return x;
  }
  
  public float getY(){
    return y;
  }

  public void move() {
    if (dir == 87) {
      y -= 5.0;
    }
    if (dir == 65) {
      x -= 5.0;
    }
    if (dir == 83) {
      y += 5.0;
    }
    if (dir == 68) {
      x += 5.0;
    }
    x = constrain(x, width/2-200+16, width/2+200-16); 
    y = constrain(y, height/2-200+16, height/2+200-16);
    //println(direction);
  }
  
}
