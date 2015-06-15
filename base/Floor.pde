public class Floor {

  private final int NORTH = 0;
  private final int SOUTH = 1;
  private final int EAST = 2;
  private final int WEST = 3;

  private Room[][] floor;
  private ArrayList<Room> rooms;

  private Room spawn;
  private int indX, indY;
  private int floorNum;
  private int totalRooms;
  private Player player;

  Random rand = new Random();

  public Floor(int num, Player p) {
    floorNum = num;
    totalRooms = floorNum * 2;

    if (floorNum < 2) {
      totalRooms = 4;
    }
    if (floorNum > 5) {
      totalRooms = 10;
    }

    player = p;
    floor = new Room[totalRooms][totalRooms];
    rooms = new ArrayList<Room>();
    spawn = new Room(player);

    indX = floor.length / 2;
    indY = floor[0].length / 2;
    noStroke();
    smooth();
    fill(35);
  }


  public Floor(Player p) {
    this(1, p);
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
            floor[m][n] = new Room(i + 1, player);
            rooms.add(floor[m][n]);
            i++;
          }
        } 
        if ( !(isOutOfBounds(m - 1, n))) {
          if (floor[m - 1][n] != null) {
            floor[m][n] = new Room(i + 1, player);
            rooms.add(floor[m][n]);
            i++;
          }
        } 
        if ( !(isOutOfBounds(m, n + 1))) {
          if (floor[m][n + 1] != null) {
            floor[m][n] = new Room(i + 1, player);
            rooms.add(floor[m][n]);
            i++;
          }
        } 
        if ( !(isOutOfBounds(m, n - 1))) {
          if (floor[m][n - 1] != null) {
            floor[m][n] = new Room(i + 1, player);
            rooms.add(floor[m][n]);
            i++;
          }
        }
      }
    }
    
    int m = rand.nextInt(floor.length);
    int n = rand.nextInt(floor[0].length);
    while (floor[m][n] == null || floor[m][n] == floor[indX][indY]) {
      m = rand.nextInt(floor.length);
      n = rand.nextInt(floor[0].length);
    }
    floor[m][n].setIsExit(true);
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
    if ( !(isOutOfBounds(indX, indY - 1))) {
      if (floor[indX][indY - 1] != null) {
        floor[indX][indY].setHasDirection(WEST, true);
      }
    }
  }

  int getIndX() {
    return indX;
  }

  int getIndY() {
    return indY;
  }

  void setIndX(int x) {
    indX = x;
  }

  void setIndY(int y) {
    indY = y;
  }

  Room getRoom(int x, int y) {
    return floor[x][y];
  }
/*
  void chooseExit() {
    int m = rand.nextInt(floor.length);
    int n = rand.nextInt(floor[0].length);
    while (floor[m][n] == null || floor[m][n] == floor[indX][indY]) {
      m = rand.nextInt(floor.length);
      n = rand.nextInt(floor[0].length);
    }
    floor[m][n].setIsExit(true);
  }
  */
}

