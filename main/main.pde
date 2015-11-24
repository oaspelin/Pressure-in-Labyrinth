//ball positions
int ballX;
int ballY;
//same in both x and y
int offSet;
//velocity of the ball
int vx;
int vy;
//for reading the .txt file
String lines[];

void setup() {
  size(500, 500);
  background(255);
  ellipseMode(CENTER);

  readMap();

  //inits ball properties
  ballX=20;
  ballY=20;
  offSet=20;
  vx=0;
  vy=0;
}

void readMap() {
  int index=0;
  lines=loadStrings("../maps/test.txt");
  while(index < lines.length) {
    String[] pieces = split(lines[index], " ");
    println(pieces.length);
    index = index + 1;
  }
}

void draw() {
  background(#A5370C);
  fill(255);
  //kehys
  rect(5, 5, 490, 490);
  drawBall();
}

//draws the ball
void drawBall() {
  noStroke();
  fill(#EA3232);
  updateBall();
  ellipse(ballX, ballY, 30, 30);
  noFill();
}

//updates ball coordinates
void updateBall() {
  ballX+=vx;
  ballY+=vy;
  checkCollision();
}

//only checks for borders atm
void checkCollision() {
  if (ballX+offSet>=500 || ballX-offSet<=0) {
    vx=0;
  }
  if (ballY+offSet>=500 || ballY-offSet<=0) {
    vy=0;
  }
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