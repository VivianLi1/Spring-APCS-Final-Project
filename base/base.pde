//Player player;
float x, y;
boolean isUp, isLeft, isDown, isRight, isSpace;

void setup(){
  size(1200,600);
  background(35);
  x = width/2;
  y = height/2;
}

void draw(){
  background(35);
  noStroke();
  smooth();
  
  rectMode(CORNERS);
  fill(100);
  rect(width/2-200,height/2-200,width/2+200,height/2+200);
  
  x = constrain(x, width/2-200+24, width/2+200-24);
  y = constrain(y, height/2-200+24, height/2+200-24);
  
  ellipseMode(RADIUS);
  fill(255);
  ellipse(x, y, 24, 24);
  
  move();
}

void move(){
  if (isUp){
    y -= 2.0;
  }
  if (isLeft){
    x -= 2.0;
  }
  if (isDown){
    y += 2.0;
  }
  if (isRight){
    x += 2.0;
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
