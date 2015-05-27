public class Player extends Killable {

  boolean isUp, isLeft, isDown, isRight = false;

  public Player(float x_, float y_, int sx, int sy) {
    super(x_, y_, sx, sy);
  } 

  void spawn() {
    ellipseMode(RADIUS);
    fill(255);
    ellipse(x, y, 24, 24);
  }

  void move() {
    if (isUp) {
      y -= 2.0;
      direction = 87;
    }
    if (isLeft) {
      x -= 2.0;
      direction = 65;
    }
    if (isDown) {
      y += 2.0;
      direction = 83;
    }
    if (isRight) {
      x += 2.0;
      direction = 68;
    }
    //println(direction);

    x = constrain(x, width/2-200+16, width/2+200-16); 
    y = constrain(y, height/2-200+16, height/2+200-16);
  }

  void setUp(boolean b) {
    isUp = b;
  }

  void setLeft(boolean b) {
    isLeft = b;
  }

  void setDown(boolean b) {
    isDown = b;
  }

  void setRight(boolean b) {
    isRight = b;
  }
  
}

