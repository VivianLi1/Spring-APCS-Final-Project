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
  
  public void setY(float yy){
    y = yy;
  }
  
  public float getX(){
    return x;
  }
  
  public float getY(){
    return y;
  }
  
  public int getDir(){
    return dir;
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
  
  public boolean hitDoor(Door d){
    Rectangle r1 = new Rectangle((int)x-8, (int)y-8, 16, 16);
    Rectangle r2 = d.getBounds();
    if (r1.intersects(r2)){
      if (dir == 87){
        y = boundUp + 1;
      }else if (dir == 65){
        x = boundLeft + 1;
      }else if (dir == 83){
        y = boundDown - 1;
      }else if (dir == 68){
        x = boundRight - 1;
      }
      stopped = true;
    }
    return r1.intersects(r2);
  }
  
  public boolean getStopped(){
    return stopped;
  }
  
  public void setStopped(boolean stop) {
    stopped = stop;
  }
  
}
