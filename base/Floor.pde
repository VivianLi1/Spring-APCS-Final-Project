import java.util.*;

public class Floor {

  private final int NORTH = 0;
  private final int SOUTH = 1;
  private final int EAST = 2;
  private final int WEST = 3;

  //  ArrayList<Room> floor = new ArrayList<Room>();
  private int totalRoomNum;
  private int floorNum;
  //private int direction;
  //  private int currRoomNum;

  public Floor() {
    this(1);
  }

  public Floor(int num) {
    floorNum = num;
    totalRoomNum = floorNum * 2;
    //floor.add(new Room());
    //currRoomNum = 1;
  }

  /*
  public void chooseDir() {
   Random rand = new Random();
   int dir = rand.nextInt(4);
   switch(dir) {
   case 0: 
   direction = NORTH;
   break;
   case 1: 
   direction = SOUTH;
   break;
   case 2: 
   direction = EAST;
   break;
   case 3: 
   direction = WEST;
   break;
   }
   }
   */

  public void connectRoom(Room r) {
    Random rand = new Random();
    int direction = rand.nextInt(4);
    if (direction == NORTH && r.getHasDirection(NORTH) == false) {
      r.setHasDirection(NORTH, true);
    } else if (direction == SOUTH && r.getHasDirection(SOUTH) == false) {
      r.setHasDirection(SOUTH, true);
    } else if (direction == EAST && r.getHasDirection(EAST) == false) {
      r.setHasDirection(EAST, true);
    } else if (direction == WEST && r.getHasDirection(WEST) == false) {
      r.setHasDirection(WEST, true);
    }
  }

  public void createRoom(Room r) {
    if (r.getHasDirection(NORTH) == true) {
      r.setRoom(NORTH);
    } else if (r.getHasDirection(SOUTH) == true) {
      r.setRoom(SOUTH);
    } else if (r.getHasDirection(EAST) == true) {
      r.setRoom(EAST);
    } else if (r.getHasDirection(WEST) == true) {
      r.setRoom(WEST);
    }
  }

  public void checkDoors() {
  }
}

