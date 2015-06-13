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

    if (floorNum < 2) {
      totalRooms = 4;
    }
    if (floorNum > 5) {
      totalRooms = 10;
    }

    floor = new Room[totalRooms][totalRooms];
    spawn = new Room();
    
    indX = floor.length / 2;
    indY = floor[0].length / 2;
  }


  public Floor2() {
    this(1);
  }

  void createSpawn() {
    floor[indX][indY] = spawn;
  }

  boolean isOutOfBounds(int m, int n) {
    return (m > floor.length - 1|| m < 0 || n > floor[0].length - 1 || n < 0);
  } 

  void generate() {
    createSpawn();
    int i = 1;
    while (i < totalRooms) {
      int m = rand.nextInt(floor.length - 1);
      int n = rand.nextInt(floor[0].length - 1);
      if (floor[m][n] == null) {
        if ( !(isOutOfBounds(m + 1, n))) {
          if (floor[m + 1][n] != null) {
            floor[m][n] = new Room(i + 1);
            //floor[m][n].setHasDirection(NORTH, true);
            i++;
          }
        } 
        if ( !(isOutOfBounds(m - 1, n))) {
          if (floor[m - 1][n] != null) {
            floor[m][n] = new Room(i + 1);
            //floor[m][n].setHasDirection(SOUTH, true);
            i++;
          }
        } 
        if ( !(isOutOfBounds(m, n + 1))) {
          if (floor[m][n + 1] != null) {
            floor[m][n] = new Room(i + 1);
            //floor[m][n].setHasDirection(EAST, true);
            i++;
          }
        } 
        if ( !(isOutOfBounds(m, n - 1))) {
          if (floor[m][n - 1] != null) {
            floor[m][n] = new Room(i + 1);
            //floor[m][n].setHasDirection(WEST, true);
            i++;
          }
        }
      }
    }
    //println(Arrays.deepToString(floor));
  }

  Room getSpawn() {
    return spawn;
  }

  void setDirections(Room r) {
    if ( !(isOutOfBounds(indX + 1, indY))) {
      if (floor[indX + 1][indY] != null) {
        floor[indX][indY].setHasDirection(NORTH, true);
      }
    }
    if ( !(isOutOfBounds(indX - 1, indY))) {
      if (floor[indX - 1][indY] != null) {
        floor[indX][indY].setHasDirection(SOUTH, true);
      }
    }
    if ( !(isOutOfBounds(indX, indY + 1))) {
      if (floor[indX][indY + 1] != null) {
        floor[indX][indY].setHasDirection(EAST, true);
      }
    }
    if ( !(isOutOfBounds(indX , indY - 1))) {
      if (floor[indX][indY - 1] != null) {
        floor[indX][indY].setHasDirection(WEST, true);
      }
    }
  }
  
  int getIndX(){
    return indX;
  }
  
  int getIndY(){
    return indY;
  }
  
  void setIndX(int x){
    indX = x;
  }
  
  void setIndY(int y){
    indY = y;
  }
  
  Room getRoom(int x, int y){
    return floor[x][y];
  }
}

