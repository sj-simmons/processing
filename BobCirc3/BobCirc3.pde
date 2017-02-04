int cellsize = 100; // should divide both width and height

void setup() {
  size(500,500);
  background(255);
  frameRate(20);
  noStroke();  
}

void draw() {
  background(255);
  draw_board();
  draw_circle(3.5*cellsize,50,1);
  draw_circle(1.5*cellsize,150,-1);
  draw_circle(.5*cellsize,250,1);

}

// circle starts with center at (x,y), dir=1 is up, dir= -1 is down
void draw_circle(float x, float y, int dir) {
  float yy = mod(y+dir*frameCount, height);  // glue the bottom edge of the screen to the top edge.
  float t;  // t will determine the height of the line that cuts the circe in two.  
  if (yy % cellsize > cellsize/2.0 ) {   // if center of the circle in bottom half of a cell
    t = cellsize - (yy % cellsize);
  } else {
    t = -(yy % cellsize);
  }
  myCircle(x,yy,cellsize/2.0,t);  //draw the circle
  if (yy > height-cellsize) { // if close to the bottom of the screen, draw another circle
    myCircle(x,yy-height,cellsize/2.0,t);  // at just above the top of the screen.
  }
  if (yy < cellsize) {  // if close to the top of the screen, draw another circle at 
    myCircle(x,height+yy,cellsize/2.0,t);  // just below the bottom of the screen.
  }
}

// t is a number between -rad and rad that controls where the color changes, rad is the radius, (x,y) is the center
void myCircle(float x, float y, float rad, float t) {
  float angle = asin(t/rad);
  float yy = y+rad*sin(angle); // (x,yy) is the point on the line cutting the circle in two and on the vertical center line
  beginShape(); 
  if ((int(x/cellsize)+int(yy/cellsize)) % 2 == 1 ) {  // if in a black square
    fill(255); // fill white
  } else {
    fill(0); // fill black
  }
  for (float theta = angle; theta<=PI-angle ; theta += .01) {  // draw the lower part of the circle
    vertex(x+rad*cos(theta),y+rad*sin(theta));
  }
  vertex(x+rad*cos(angle),y+rad*sin(angle));
  endShape(CLOSE); 
  beginShape();
  if ((int(x/cellsize)+int((yy-.1)/cellsize)) % 2 == 1 ) {  // if in a black square
    fill(255); // fill white
  } else {
    fill(0);
  }    
  for (float theta = PI-angle; theta<=2*PI+angle ; theta += .01) {//draw the upper part of the circle
    vertex(x+rad*cos(theta),y+rad*sin(theta));
  }
  vertex(x+rad*cos(angle),y+rad*sin(angle));
  endShape(CLOSE);
}

void draw_board() {
  for (int x=0 ; x<width ; x += cellsize) {
    for (int y=0 ; y<height ; y += cellsize) {
      if ((x/cellsize+y/cellsize) % 2 == 1 ) {
        fill(0);
        rect(x,y,cellsize,cellsize);
        fill(255);
      }
    }  
  }  
}

float mod(float x, int n) {
  if (x >= 0) { return x%n;}
  else { return x%n + n; }
}
