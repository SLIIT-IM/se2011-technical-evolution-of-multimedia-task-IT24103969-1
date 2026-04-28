int n = 14;  // number of butterflies
float br = 15;    //butterfly radius
float hr = 15;    //hand radius
float hx;    //hand x position
float hy;    //net y position
float bdx;    //boundary x position
float bdy;    //boundary y position
float[] bx = new float[n];   //butterfly x positions
float[] by = new float[n];   //butterfly y positions
float[] bvx = new float[n];  //butterfly x velocities
float[] bvy = new float[n];  //butterfly y velocities


void setup() {
  size(600, 300);
  frameRate(60);

  //Initialize each butterfly
  for (int i = 0; i < n; i++) {

    bx[i] = random(br, width - br);
    by[i] = random(br, height - br);
    bvx[i] = random(-1, 1);
    bvy[i] = random(-1, 1);
        
    if (abs(bvx[i]) < 1) {
      bvx[i] = 2;
    }

    if (abs(bvy[i]) < 1) {
      bvy[i] = -2;
    }
  }
}

void draw() {
  background(111,195,245);
  
  //Initialise net
  hx = mouseX+25;
  hy = mouseY-50;
  bdx=hx;
  bdy=hy;

  //Move butterflies
  for (int i = 0; i < n; i++) {
    bx[i] = bx[i] + bvx[i];
    by[i] = by[i] + bvy[i];

    //Bounce on walls
    if (bx[i] > width -br || bx[i] < br) {
      bvx[i] = bvx[i] *-1;
    }

    if (by[i] > height-br || by[i] < br) {
      bvy[i] = bvy[i] *-1;
    }
    
    //Bounce off boundary slowly
    float minDist = (hr * 3.5) + br;
    float distance = dist(bdx, bdy, bx[i], by[i]);
    
    if (distance < minDist) {
      bvx[i] += (bx[i] -bdx)*0.05;
      bvy[i] += (by[i] -bdy)*0.05;
    }
    float maxSpeed=3;
    bvx[i] = constrain(bvx[i],-maxSpeed,maxSpeed);
    bvy[i] = constrain(bvy[i],-maxSpeed,maxSpeed);
    bx[i] = constrain(bx[i],br,width-br);
    by[i] = constrain(by[i],br,height-br);
    
    //Draw butterflies
    noStroke();
    fill(250, random(10,180), 100);
    ellipse(bx[i], by[i], br*2, br*2);
  }
  
  //Draw net
  fill(90,58,8,200);
  ellipse(hx,hy, hr*3.8,hr*2.5);
  fill(90,58,8);
  rect(mouseX,mouseY-50,5,70);

  //Draw boundary
  fill(0,0,0,0);
  circle(hx,hy,hr*8);
}
