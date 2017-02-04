float xxstart=random(10);
float yynoise=random(10);
float zoff = 0;
float zstep = .01;

void setup(){
  size(1000,800,P3D);
  background(150);
  stroke(0,50);
  fill(255,200);
  noiseDetail(3,.5);
}

void draw(){
  background(150);
  translate(width/2,height/2,0);  
  zoff += zstep; float xstart = xxstart; float ynoise = yynoise;
  for (float y=-height/8;y<=height/8;y+=3){
    ynoise+=0.02;
    float xnoise=xstart;
    for (float x=-width/8; x<=width/8; x+=3){
      xnoise+=0.02;
      drawPoint(x,y,noise(xnoise,ynoise,zoff));
    }
  }
}
void drawPoint(float x, float y, float noiseFactor){
  pushMatrix();
  translate(x*noiseFactor*4,y*noiseFactor*4,-y);
  float edgeSize = noiseFactor*26;
  ellipse(0,0,edgeSize,edgeSize);
  popMatrix();
}

void keyPressed() {
  if (key == 's') {
    zstep = 0;
  } 
  else if (key == 'r') {
    zstep = .01;
  }
  if (keyCode == ENTER) {
    saveFrame("screen-####.jpg");
  }
}

