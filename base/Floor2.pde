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

  void hasDirection(int dir) {
    int b = rand.nextInt(2);

    if (b == 0) {
      currRoom.setHasDirection(dir, true);
      currRoom.setRoom(dir);
    } else {
      currRoom.setHasDirection(dir, false);
    }
  }

  void generate() {
    createCenter();
    int connections = rand.nextInt(4) + 1;
    int[] connect = new int[connections];
    int i = 0;
    int j = 0; 
    while (i < connections + 1 && j < 4) {
      int b = rand.nextInt(2);
      if (b == 0) {
        currRoom.setHasDirection(j, true);
        i++;
      }
      j++;
    }
  }
}

