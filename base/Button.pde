

public class Button{
  
  float x, y;
  int sizeX, sizeY;
  
  boolean pressed;
  String txt;
  
  public Button(float xx, float yy, int sx, int sy, String s){
    x = xx;
    y = yy;
    
    sizeX = sx;
    sizeY = sy; 
    
    pressed = false;
    txt = s;
  }
  
  void setPressed(boolean b){
    pressed = b;
  }
  
}
  
