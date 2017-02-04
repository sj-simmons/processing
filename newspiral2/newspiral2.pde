RoundWave wave1 = new RoundWave(100, false); // wave1 is an instance of
                                 // the class RoundWave
RoundWave wave2 = new RoundWave(100,false);
float ang; 
float roff = 0;
float lastx = -999;
float lasty = -999;
float seed = random(1);
float x = 50.0, y = 50.0;

void setup () {
  size(800,600);
  strokeWeight(5);
  background(250);
  frameRate(10);
}

void draw () {
  wave1.update(x,y);
  wave2.update(300*cos(radians(x/2)),200*sin(radians(x/2)));
  x += 1;
  y += 1;
  seed += .01;
}

class RoundWave {
  float r, x, y;           // attributes
  boolean show_lines;
  RoundWave(float rr, boolean lines) {  //constructor
    r = rr;
    show_lines = lines;
  }
  
  void update (float centx, float centy) {   //method
    translate(centx,centy);  
    roff = 0;
    for (ang = 0; ang <= 360; ang+=1 ) {
      float rad = r*(noise(seed+roff)+.5);
      float x = rad*cos(radians(ang));
      float y = rad*sin(radians(ang));
      if (lastx > -999) {
        strokeWeight(.5);
        stroke(100);
        line(lastx,lasty,x,y);
      }
      if (show_lines) {
        strokeWeight(.1);
        if (lastx > -999) {
          line(-noise(roff+1)*1.5*lastx+r*noise(roff+3)*.3,
               -noise(roff+2)*lasty*1.5+r*noise(roff+4)*.3,x,y);
        }
      }
      lastx = x;
      lasty = y;
      roff += .02;
    }
  }
}
