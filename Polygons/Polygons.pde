class Polygon {
  
   float polColor;
   int sides;
   float radius;
   PVector center;
   float lastMillis = -1f;
   float duration;
   float actualDuration = 0;
  
   public Polygon(float polColor, float duration, int sides, float radius, PVector center) {
      this.polColor = polColor;
      this.sides = sides;
      this.radius = radius;
      this.center = center;
      this.duration = duration;
   }
   
   public void draw() {
     if(lastMillis <= 0f) lastMillis = millis();
     float actualMillis = millis();
     float deltaTime = actualMillis - lastMillis;
     actualDuration += deltaTime;
     lastMillis = actualMillis;
     if(actualDuration >= duration) actualDuration = 0;
     
     float progress = actualDuration / duration;
     float rotateAmount = progress * TWO_PI;
     
     float angle = TWO_PI / sides;
     
     stroke(polColor, 1.0, 1.0);
     noFill();
     
     translate(width / 2, height / 2);
     rotate(rotateAmount);
     translate(-width / 2, -height / 2);
     
     beginShape();
     for(int i = 0; i < sides; i++) {
       float x = cos(angle * i) * radius;
       float y = sin(angle * i) * radius;
       vertex(x + center.x, y + center.y);
     }
     endShape(CLOSE);
     
     translate(width / 2, height / 2);
     rotate(-rotateAmount);
     translate(-width / 2, -height / 2);
   }
  
}

ArrayList<Polygon> polygons = new ArrayList<Polygon>();

void setup() {
  size(600, 600);
  frameRate(60);
  colorMode(HSB, 1.0);
  
  PVector center = new PVector(width / 2, height / 2);
  
  int minSides = 3;
  int maxSides = 30;
  int interval = maxSides - minSides;
  
  for(int i = minSides; i <= maxSides; i++) {
    float progress = (float) (i - minSides) / (float) interval;
    polygons.add(new Polygon(progress, i * 1000, i, 10 + (i * 10), center));
  }
}

void draw() {
  background(0xffffff);
  for(Polygon poly : polygons) {
    poly.draw();
  }
}