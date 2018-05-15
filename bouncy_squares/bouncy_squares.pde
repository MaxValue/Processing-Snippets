
float square = 50;
float v_square = 10;

void setup() {
  size(640, 360);
}

void draw() { 
  background(255);
  fill(0);
  rect(width/2, height/2, square, square);
  fill(255,0,0);
  rect(width/2, height/2, square, -square);
  if (-100 >= square || square >= 100) {
    v_square *= -1;
  }
  square += v_square;
} 

void mousePressed() {
}