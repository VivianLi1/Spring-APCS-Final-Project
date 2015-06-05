# Spring-APCS-Final-Project
Vivian Li and Mindy Ruan's Final Project for APCS

TEAM NAME: Ocean Ravioli

VERSIONS
- version 1 - https://github.com/VivianLi1/Spring-APCS-Final-Project/tree/version1

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
- added modes

1/6
- better Door class

4/6
- door can be drawn now
