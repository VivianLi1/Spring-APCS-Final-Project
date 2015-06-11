public class Knife {

  private float x, y;
  private int dir;
  private boolean stopped;
  private float boundUp, boundDown, boundLeft, boundRight;

  public Knife(float xcor, float ycor, int direction) {
    x = xcor;
    y = ycor;
    dir = direction;
  }
  
  public float getX(){
    return x;
  }
  
  public float getY(){
    return y;
  }

  public void move(int roomx, int roomy) {
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
    boundLeft = width/2-roomx+8;
    boundRight = width/2+roomx-8;
    boundUp = height/2-roomy+8;
    boundDown = height/2+roomy-8;
    
    x = constrain(x, boundLeft, boundRight); 
    y = constrain(y, boundUp, boundDown);
    
    if (hitWall()){
      stopped = true;
    }
    //println(direction);
  }
  
  public boolean hitWall(){
    if (x == boundLeft || x == boundRight || y == boundUp || y == boundDown){
      //print("HITTTTT");
      return true;
    }
    return false;
  }
  
  public boolean getStopped(){
    return stopped;
  }
  
  public void setStopped(boolean stop) {
    stopped = stop;
  }
  
}
