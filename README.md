# Spring-APCS-Final-Project
Vivian Li and Mindy Ruan's Final Project for APCS

TEAM NAME: Ocean Ravioli

VERSIONS
- version 1 - https://github.com/VivianLi1/Spring-APCS-Final-Project/tree/version1
- version 2 - https://github.com/VivianLi1/Spring-APCS-Final-Project/tree/version2

LOG

23/5
- Basic movement for Player
  - stays within walls, no movement delay
  - CON: different rooms mean different boundaries :^( find a more efficient way later

24/5
- (crappy) Knife throwing
  - stays within walls when thrown
  - CON: not throwing 50000 knives from one click (ie make some delay)

26/5
- Began Enemy class
- Enemy now follows Player

27/5
- Moved Player into its own seperate class
- Implemented Killable class and extended it to Player and Enemy

28/5
- Created seperate Room class
- Player dies from enemy collisions
- Player can now pick up knives (knives dont kill enemies yet)

29/5

30/5
- Door class
- Room generation begins
   - creates the room after deciding a direction

31/5
- fixed bug where Player died after reaching a certain x and y coord
- knives now kill enemies
- added modes (and broke knives killing enemies thanks)

1/6
- better Door class

4/6
- door can be drawn now
- door boundaries added for collisions

5/6
- fixed mistake: knives now kill enemies again
- fixed bug which caused knives to stop wherever enemies used to be

6/6
- started buddy system (collisions between enemies)
- improved enemy collision

7/6
- Player can switch rooms
   - BUG: null pointer exception when going north and west
   - BUG: nothing happens when going east

8/6
- made makeEnemies(int num) function (makes spawning easier)
- added bullet delay so things aren't too crazy

9/6
- working on doors and changing rooms
  - changing rooms work when going left, then back through the right; also works when going down, then back up
  - does not work when going right or up first

10/6
- loaded ravioli images onto player :^)
- changed some dimensions to make things work the same
