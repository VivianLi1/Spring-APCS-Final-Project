public class Ink extends Knife {

  float dx;
  float dy;
  float angle;
  float boundLeft, boundRight, boundUp, boundDown;

  public Ink(float xcor, float ycor, int angle) {
    super(xcor, ycor, angle);
    dx = 0;
    dy = 0;
    
    boundLeft = width/2-200+8;
    boundRight = width/2+200-8;
    boundUp = height/2-200+8;
    boundDown = height/2+200-8;
    
  }
  
  public float getX(){
    return super.getX();
  }
  
  public float getY(){
    return super.getY();
  }

  public void calcAngle(float px, float py) {
    if (super.getX() != px || super.getY() != py) {
      dx = px - super.getX();
      dy = py - super.getY();

      angle = (float)Math.atan2(dy, dx);
    }
  }
  
  public boolean hitWall(){
    if (super.getX() == boundLeft || super.getX() == boundRight || super.getY() == boundUp || super.getY() == boundDown){
      //print("HITTTTT");
      return true;
    }
    return false;
  }

  public void move() {
    /*
      dx = px - super.getX();
     dy = py - super.getY();
     angle = (float)Math.atan2(dy, dx);
     */

    super.setX((float)(super.getX() + 2 * Math.cos(angle)));
    super.setY((float)(super.getY() + 2 * Math.sin(angle)));
    
    super.setX(constrain(super.getX(), boundLeft, boundRight)); 
    super.setY(constrain(super.getY(), boundUp, boundDown));
    
    

    
  }

  public void spawn() {
    fill(133, 0, 12);
    ellipseMode(RADIUS);
    ellipse(super.getX(), super.getY(), 8, 8);
  }
}
