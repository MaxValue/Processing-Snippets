int SMALLEST;
Particles particles1;
/*
BUGS:
Q: startup is in waves?
A: bigger random pos at start
Q: effect itself cannot handle inner border?
A: incorporate inner border into formula. also consider making universal formula (math yay!).

ROADMAP:
particle velocity (becoming slower on edges)
particle tearing: quad(x1, y1, x2, y2, x3, y3, x4, y4)
*/
void settings() {
  JSONObject measures = loadJSONObject("screen_size.json");
  size(measures.getInt("width"), measures.getInt("height"));
}

void setup() {
  imageMode(CENTER);
  SMALLEST = width < height ? width : height;
  particles1 = new Particles(2500, SMALLEST);
}

void draw() { 
  background(0);
  particles1.live();
  particles1.draw(width/2, height/2);
}

class Particle {
  float radius, angle, size, speed, border;
  Particle(int b) {
    border = b;
    radius = random((border/2) * 0.80, border/2);
    angle = random(0, TAU);
    size = random(3.0, 3.0);
    speed = random(60.0, 80.0);
  }
  void move() {
    radius -= speed / frameRate;
  }
  void draw(PGraphics context, int center_x, int center_y) {
    int pos_x, pos_y;
    if (border * 0.25 >= radius) {// && radius >= border * 0.05) {
      pos_x = int(center_x + (((border * 0.25)-radius) * cos(angle)));
      pos_y = int(center_y + (((border * 0.25)-radius) * sin(angle)));
    } else {
      pos_x = int(center_x + (radius * cos(angle)));
      pos_y = int(center_y + (radius * sin(angle)));
    }
    context.rect(pos_x, pos_y, size, size);
  }
}

class Particles {
  Particle[] partlist;
  PGraphics buffer;
  int size;
  Particles(int count, int bound) {
    size = bound;
    partlist = new Particle[count];
    for (int i = 0; i < count; i++) {
      partlist[i] = new Particle(size);
    }
  }
  void live() {
    for (int i = 0; i < partlist.length; i++) {
      partlist[i].move();
      if (partlist[i].radius < 0) {
        partlist[i] = new Particle(size);
      }
    }
  }
  void draw(int center_x, int center_y) {
    buffer = createGraphics(size, size);
    buffer.beginDraw();
    buffer.noStroke();
    buffer.fill(255);
    for (int i = 0; i < partlist.length; i++) {
      partlist[i].draw(buffer, size/2, size/2);
    }
    buffer.endDraw();
    image(buffer, center_x, center_y);
  }
}