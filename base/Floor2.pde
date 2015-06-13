public class Floor2 {

  Room[][] floor;
  Room currRoom;
  int floorNum;
  int totalRooms;

  Random rand = new Random();

  public Floor2(int num) {
    floorNum = num;
    totalRooms = floorNum * 2;

    if (floorNum > 5) {
      totalRooms = 10;
    }

    floor = new Room[totalRooms][totalRooms];
    currRoom = new Room();
  }


  public Floor2() {
    this(1);
  }

  void createCenter() {
    floor[floor.length / 2][floor[0].length] = currRoom;
  }

  /*
  void hasDirection(int dir) {
   int b = rand.nextInt(2);
   
   if (b == 0) {
   currRoom.setHasDirection(dir, true);
   currRoom.setRoom(dir);
   } else {
   currRoom.setHasDirection(dir, false);
   }
   }
   */

  boolean isOutOfBounds(int m, int n) {
    return (m > floor.length - 1|| m < 0 || n > floor[0].length - 1 || n < 0);
  } 

  void generate() {
    createCenter();
    int i = 0;
    while (i < 5) {
      int m = rand.nextInt(floor.length - 1);
      int n = rand.nextInt(floor[0].length - 1);
      if (floor[m][n] == null) {
        if ( !(isOutOfBounds(m + 1, n))) {
          if (floor[m + 1][n] != null) {
            floor[m][n] = new Room(currRoom.getX(), currRoom.getY() + 200, i + 1);
            i++;
          }
        } else if ( !(isOutOfBounds(m - 1, n))) {
          if (floor[m - 1][n] != null) {
            floor[m][n] = new Room(currRoom.getX(), currRoom.getY() + 200, i + 1);
            i++;
          }
        } else if ( !(isOutOfBounds(m, n + 1))) {
          if (floor[m][n + 1] != null) {
            floor[m][n] = new Room(currRoom.getX(), currRoom.getY() + 200, i + 1);
            i++;
          }
        } else if ( !(isOutOfBounds(m, n - 1))) {
          if (floor[m][n - 1] != null) {
            floor[m][n] = new Room(currRoom.getX(), currRoom.getY() + 200, i + 1);
            i++;
          }
        }
      }
    }
  }
}
