import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

import shapes3d.*;
import shapes3d.animation.*;
import shapes3d.utils.*;
import processing.serial.*;
import cc.arduino.*;

//draws menu if true
boolean menu;
//offset of the ball
int offSet;
//velocity of the ball
int vx;
int vy;
//for reading the .txt file
String lines[];
//size of the map in terms of tiles
int mapsize;
int mapnum;
//list of all the characters from the .txt file
ArrayList<Character> tiles = new ArrayList<Character>();
ArrayList<String> mapbg = new ArrayList<String>();
//position of the ball (x,y) used for collision detection
Ball ball;
Map map;
Arduino arduino;
boolean use_board = false;
PImage bg1, bg2;
AudioPlayer player;
Minim minim;//audio context

void setup() {
  size(500, 500, P3D);
  //arduino = new Arduino(this, Arduino.list()[5], 57600);
  bg1 = loadImage("../backgrounds/white-bg.jpg");
  bg2 = loadImage("../backgrounds/wooden-bg.jpg");
  menu=true;
  menuSetup();
  ellipseMode(CENTER);
  mapbg.add("../maps/map1.txt");
  mapbg.add("../maps/map2.txt");
  mapbg.add("../maps/map3.txt");
  map = new Map();
  readMap();
  //inits ball properties
  ball = new Ball(40, 40); //where the ball starts
  offSet=20;
  vx=0;
  vy=0;
  minim = new Minim(this);
  player = minim.loadFile("../music/Happy.mp3");
  player.play();
}

void readMap() {
  int index = 2;
  tiles = new ArrayList<Character>();
  lines = loadStrings(mapbg.get(mapnum));
  mapsize = Integer.parseInt(lines[0]); //size of map defined in the .txt document
  while (index < lines.length-1) {
    //removes the "borders" from the map
    String temp= lines[index].substring(1);
    temp=temp.substring(0, temp.length()-1);
    for (char c : temp.toCharArray ()) {
      tiles.add(c);
    }
    index = index + 1;
  }
}
//for testing
/*
  for(int i=0; i<=5;i++){
 stroke(0);
 line(tilesize*i,0,tilesize*i,500);
 line(0, tilesize*i, 500,tilesize*i);
 }*/

void draw() {
  background(255);
  if (menu) {
    menuDraw();
  }//Draws menu
  else {
    if (mapnum == 1) {
      background(bg1);
    } else if (mapnum == 2) {
      background(bg2);
    } else background(bg1);
    
    map.drawMap();
    ball.update();
    ball.drawBall();
    if (ball.x == map.goalx && ball.y == map.goaly) {
      println("test");
      mapnum +=1;
      if (mapnum < mapbg.size()) {
        readMap();
        
      } else { 
        print("");
    }
   }
  }
  //println(ball.x, ball.y, map.goalx, map.goaly);
}

void stop()
{
  player.close();
  minim.stop();
  super.stop();
}


//control of the ball
void keyPressed() {
  if (key == CODED) {
    if (keyCode==UP) {
      vy-=1;
    }
    if (keyCode==DOWN) {
      vy+=1;
    }
    if (keyCode==LEFT) {
      vx-=1;
    }
    if (keyCode==RIGHT) {
      vx+=1;
    }
  }
}

/* not really needed
 void keyReleased() {
 if (key == CODED) {
 if (keyCode==UP) {
 vy=0;
 }
 if (keyCode==DOWN) {
 vy=0;
 }
 if (keyCode==LEFT) {
 vx=0;
 }
 if (keyCode==RIGHT) {
 vx=0;
 }
 }
 }
 */
