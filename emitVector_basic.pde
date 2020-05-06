//在鼠标按下的位置生成粒子，并往鼠标移动的方向射出；
PVector pos;
PVector vel;
PVector emitforce;

float r;
float mass;
float presstime;
float d;

void setup() {
  size(900, 400);
  pos = new PVector(mouseX, mouseY);
  vel = new PVector(0, 0);

  emitforce = new PVector();
  r = 20;
  mass = 10;
}

void draw() {
  background(0);
  speedadd();
  display();
}

void editvalue() {
  emitforce = PVector.sub(new PVector(mouseX, mouseY), new PVector(pmouseX, pmouseY));
  d = emitforce.mag();
  float limitD = 1-pow(2, -d);
  emitforce.mult(limitD/(mass*0.03));
  pos = new PVector(mouseX, mouseY);
}

void speedadd() {
  vel.add(emitforce);
  pos.add(vel);
  vel.mult(0);
  emitforce.mult(0.98);
  //如果不做衰减那么emitforce则会在鼠标松开后保持一个甩出时候的值。
  //vel会每帧都会累加这个值，以至于停不下来。
}


void display() {
  noStroke();
  fill(255);
  ellipse(pos.x, pos.y, mass, mass);
}

//持续拖动鼠标储能
void mouseDragged() {
  editvalue();
  mass+=0.1;
}

void mousePressed() {
  mass = 10;//初始质量
}
void chckedge() {
  if (pos.x <=0 || pos.x >= width || pos.y <= 0 ||pos.y >=height) {
    pos = new PVector(random(width), random(height));
  }
}
