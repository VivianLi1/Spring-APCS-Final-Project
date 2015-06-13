public class Floor2 {

  private final int NORTH = 0;
  private final int SOUTH = 1;
  private final int EAST = 2;
  private final int WEST = 3;

  private Room[][] floor;
  private Room spawn;
  private int indX, indY;
  private int floorNum;
  private int totalRooms;

  Random rand = new Random();

  public Floor2(int num) {
    floorNum = num;
    totalRooms = floorNum * 2;

    if (floorNum > 5) {
      totalRooms = 10;
    }

    floor = new Room[totalRooms][totalRooms];
    spawn = new Room();
  }


  public Floor2() {
    this(1);
  }

  void createCenter() {
    floor[floor.length / 2][floor[0].length / 2] = spawn;
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
    int i = 1;
    while (i < totalRooms) {
      int m = rand.nextInt(floor.length - 1);
      int n = rand.nextInt(floor[0].length - 1);
      if (floor[m][n] == null) {
        if ( !(isOutOfBounds(m + 1, n))) {
          if (floor[m + 1][n] != null) {
            floor[m][n] = new Room(i + 1);
            floor[m][n].setHasDirection(NORTH, true);
            i++;
          }
        } 
        if ( !(isOutOfBounds(m - 1, n))) {
          if (floor[m - 1][n] != null) {
            floor[m][n] = new Room(i + 1);
            floor[m][n].setHasDirection(SOUTH, true);
            i++;
          }
        } 
        if ( !(isOutOfBounds(m, n + 1))) {
          if (floor[m][n + 1] != null) {
            floor[m][n] = new Room(i + 1);
            floor[m][n].setHasDirection(EAST, true);
            i++;
          }
        } 
        if ( !(isOutOfBounds(m, n - 1))) {
          if (floor[m][n - 1] != null) {
            floor[m][n] = new Room(i + 1);
            floor[m][n].setHasDirection(WEST, true);
            i++;
          }
        }
      }
    }
    println(Arrays.deepToString(floor));
  }

  Room getSpawn() {
    return spawn;
  }
}


