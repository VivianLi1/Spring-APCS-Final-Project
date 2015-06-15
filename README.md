# Spring-APCS-Final-Project
Vivian Li and Mindy Ruan's Final Project for APCS

TEAM NAME: Ocean Ravioli
PROJECT NAME: Ocean Ravioli
(sorry)

PROJECT DESCRIPTION:
We plan to create a dungeon crawler game. It will consist of the player navigating and battling through an interconnected series of rooms (floors). The player will be equipped with one knife and must kill monsters to reach the next floor. After thrown, the player must retrieve the knife to be able to use it again.  Currently, we plan for the dungeon to be endless, however this feature is subject to change. There is also going to be a scoreboard that keeps track of the number of kills, floors/rooms completed, etc.

GOALS
- MINIMUM FEATURES
  - rooms connected to each other
  - monsters that actively tries to kill the player
  - a player that moves
  - the knife must kill the enemies

- TO BE COMPLETED FIRST
  - room generation
  - walls/boundaries
  - connecting rooms
  - player
  - movement
  - staying in the map
  - enemies
    - killable with weapon
    - must want to kill player

- CAN BE WORKED ON CONCURRENTLY
  - graphics/AI of the enemies
  - rooms/player/enemies + their graphics

- STEPS THAT ARE DETERMINED BY OTHER STEPS
  - must generate monsters before the weapon can be tested
  - individual rooms must be created before they can be connected
  - scoreboard will be completed at the end (hopefully)

- OK WITH LEAVING OUT
  - multiple enemies with different AIs
  - endless dungeon
  - power ups
  - more variations of room shape/style


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
- testing: using 2d arrays for room generation

13/6
- enemy buddy system: enemies don't overlap anymore!
  - (still gotta fix overlap in y-direction; shouldn't be too hard)
- buddy system now works for both x and y directions
- added countdown right before game starts
- knives now stop at doors
- added restart option at gameover (spacebar to restart)
- drew jellyfish and walls and cave things
- 2d array room generation - done

14/6
- invincibility period after player is hit by enemy
- new enemies spawned when player enters new room
- made start and how to play screens
- knives that aren't picked up remain in the room they were thrown in
- made enemy: Squid : stationary, shoots ink pellets at player
- Ink class: squid knives B^)
- made pixels for squids, ink pellets, player knives
- made a scoreboard: keeps track of lives, knives, floor #, kills
- player can now move down floors (using exit)
