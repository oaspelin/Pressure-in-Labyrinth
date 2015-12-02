//class for the ball
class Ball {
  int x, y;//tile
  int ballX, ballY; //coordinate
  boolean collisionRight, collisionLeft, collisionUp, collisionDown;
  Ball(int ballX, int ballY) {
    this.ballX=ballX;
    this.ballY=ballY;
    this.x=0;
    this.y=0;
    this.collisionRight=false;
    this.collisionLeft=false;
    this.collisionUp=false;
    this.collisionDown=false;
  }
  void update() {
    this.direction();
    this.checkCollision();
    this.move();
    x=max(0, ballX/(500/mapsize));
    y=max(0, ballY/(500/mapsize));
  }
  //draws the ball
  void drawBall() {
    noStroke();
    fill(#EA3232);
    ellipse(ballX, ballY, 30, 30);
    noFill();
  }
  void move() {
    if (collisionRight && vx>=0) {
      vx=0;
    }
    if (collisionLeft && vx<=0) {
      vx=0;
    }
    if (collisionUp && vy<=0) {
      vy=0;
    }
    if (collisionDown && vy>=0) {
      vy=0;
    }
    ballX+=vx;
    ballY+=vy;
  }

  void direction() {
    vx=(mouseX-250)/40;
    vy=(mouseY-250)/40;
  }
  void checkCollision() {
    collisionRight=false;
    collisionLeft=false;
    collisionUp=false;
    collisionDown=false;
    //borders
    if (ballX+offSet>=500 || ballX-offSet<=0) {
      if (ballX+offSet>=500) { 
        collisionRight=true;
      } else if (ballX-offSet<=0) { 
        collisionLeft=true;
      }
    }
    if (ballY+offSet>=500 || ballY-offSet<=0) {
      if (ballY+offSet>=500) { 
        collisionDown=true;
      } else if (ballY-offSet<=0) { 
        collisionUp=true;
      }
    }

    if (x<4) {//otherwise array out of bounds
      //wall to the right
      if ((tiles.get(x+mapsize*y+1)=='|') && (ballX>=((x+1)*(500/mapsize)-offSet+5))) {
        collisionRight=true;
      }
    }
    //wall to the left
    if ((tiles.get(x+mapsize*y)=='|') && (ballX<=((x)*(500/mapsize)+offSet))) {
      collisionLeft=true;
    }
    //wall to the right "/" wall
    if ((tiles.get(x+mapsize*y)=='/') && (ballX>=((x+1)*(500/mapsize)-offSet))) {
      collisionRight=true;
    }
    //wall down from up
    if ((tiles.get(x+mapsize*y)=='_') && (ballY>=((y+1)*(500/mapsize)-offSet+5))) {
      collisionUp=true;
    }
    if (y>0) {
      //wall down from down
      if ((tiles.get(x+mapsize*y-mapsize)=='_') && (ballY<=((y)*(500/mapsize+offSet)))) {
        collisionDown=true;
      }
    }
    //wall up
    if ((tiles.get(x+mapsize*y)=='-') && (ballY<=((y)*(500/mapsize)+offSet))) {
      collisionUp=true;
    }
    if (y<4) {
      //wall up from up
      if ((tiles.get(x+mapsize*y+mapsize)=='-') && (ballY>=((y+1)*(500/mapsize)-offSet+5))) {
        collisionDown=true;
      }
    }
    //L-shaped wall
    if (x<4) {//otherwise array out of bounds
      //wall to the right
      if ((tiles.get(x+mapsize*y+1)=='L') && (ballX>=((x+1)*(500/mapsize)-offSet+5))) {
        collisionRight=true;
      }
    }
    //wall to the left
    if ((tiles.get(x+mapsize*y)=='L')) {
      if (ballX<=((x)*(500/mapsize)+offSet)) {
        collisionLeft=true;
      }
      if (ballY>=((y+1)*(500/mapsize)-offSet+5)) {
        collisionDown=true;
      }
    }
    if (y>0) {
      if ((tiles.get(x+mapsize*y-mapsize)=='L') && (ballY<=((y)*(500/mapsize)+offSet))) {
        collisionUp=true;
      }
    }
    //J-shaped wall
    if (x>1) {//otherwise array out of bounds
      //wall to the left
      if ((tiles.get(x+mapsize*y-1)=='J') && (ballX<=((x)*(500/mapsize)+offSet))) {
        collisionLeft=true;
      }
    }
    //wall to the right
    if ((tiles.get(x+mapsize*y)=='J')) {
      if (ballX>=((x+1)*(500/mapsize)-offSet+5)) {
        collisionRight=true;
      }
      if (ballY>=((y+1)*(500/mapsize)-offSet+5)) {
        collisionDown=true;
      }
    }
    if (y>0) {
      if ((tiles.get(x+mapsize*y-mapsize)=='J') && (ballY<=((y)*(500/mapsize)+offSet))) {
        collisionUp=true;
      }
    }
  }
}
