public class Squid extends Enemy {

  ArrayList<Ink> shot = new ArrayList<Ink>();
  int time4 = millis();
  PImage squid = loadImage("squid.png");
  //private int ink;

  public Squid() {
    super(width/2-100, height/2-100, 10, 10);
    //ink = 100;
  }

  public Squid(float x_, float y_, int sx, int sy) {
    super(x_, y_, sx, sy);
    //ink = 100;
  }

  void spawn() {
    setIsDead(false);
    x = constrain(x, width/2-200+16, width/2+200-16);
    y = constrain(y, height/2-200+16, height/2+200-16);
    image(squid,x-20,y-20);
    /*
    ellipseMode(RADIUS);
    fill(255,0,0); 
    ellipse(x, y, sizeY, sizeX);
    */
  }

  void shoot(float px, float py) {
    Ink i = new Ink(super.getX(), super.getY(), 87);
    i.calcAngle(px, py);
    shot.add(i);
  }

  boolean drawInk(float px, float py) {
    for (int i = 0; i < shot.size (); i++) {
      Ink ink = shot.get(i);
      ink.move();
      if (hitPlayer(ink,px,py)){
        //p.loseLife();
        shot.remove(i);
        return true;
      } else if (!(ink.hitWall())) {
        ink.spawn();
      } else {
        shot.remove(i);
      }
    }
    return false;
  }

  boolean hitPlayer(Ink ink, float px, float py) {
    float overlap = Math.abs(20);
    //println(Math.abs(ink.getX()-p.getX()));
    
      if (Math.abs(ink.getX()-px) < overlap && Math.abs(ink.getY()-py) < overlap) {
        //shot.remove(i);
        return true;
      }
    return false;
  }
  
  boolean move(int roomx, int roomy, float px, float py){
    if (millis() - time4 >= delay) {
      //println("shoot");
      shoot(px, py);
      time4 = millis();
    }
    if (drawInk(px,py)){
      return true;
    }
    return false;
  }
  
  void setX(float xx) {
    super.setX(xx);
  }
  
  void setY(float yy) { 
    super.setY(yy);
  }
  
  float getX(){
    return super.getX();
  }
  
  float getY(){
    return super.getY();
  }
  
}
