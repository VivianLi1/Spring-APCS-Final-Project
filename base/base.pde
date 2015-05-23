//Player player;
float x, y, minX, maxX, minY, maxY;
float x2,y2;
boolean isUp, isLeft, isDown, isRight, isSpace;

void setup(){
  size(1200,600);
  background(35);
  x = width/2;
  y = height/2;
  
  x2 = width/2;
  y2 = height/2;
  
  minX = width/2-174;
  maxX = width/2+174;
  minY = height/2-174;
  maxY = height/2+174;
}

void draw(){
  background(35);
  noStroke();
  smooth();
  
  rectMode(CORNERS);
  fill(100);
  rect(width/2-200,height/2-200,width/2+200,height/2+200);
  
  x2 = constrain(x2, width/2-200+24, width/2+200-24);
  y2 = constrain(y2, height/2-200+24, height/2+200-24);
  
  ellipseMode(RADIUS);
  fill(255);
  ellipse(x2, y2, 24, 24);
  
  move();
}

void move(){
  if (isUp){
    y2 -= 2.0;
  }
  if (isLeft){
    x2 -= 2.0;
  }
  if (isDown){
    y2 += 2.0;
  }
  if (isRight){
    x2 += 2.0;
  }
}

void keyPressed(){
  //print(keyCode);
  if (keyCode == 87){    // W - UP - 87
    isUp = true;
  }
  if (keyCode == 65){    // A - LEFT - 65
    isLeft = true;
  }
  if (keyCode == 83){    // S - DOWN - 83
    isDown = true;
  }
  if (keyCode == 68){    // D - RIGHT - 68
    isRight = true;
  }
  if (keyCode == 32){    // SPACE - THROW - 32
    isSpace = true;
  }
}

void keyReleased(){
  if (keyCode == 87){
    isUp = false;
  }
  if (keyCode == 65){
    isLeft = false;
  }
  if (keyCode == 83){
    isDown = false;
  }
  if (keyCode == 68){
    isRight = false;
  }
}
