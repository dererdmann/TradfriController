Box b;
Sound s;
Effect e;
Dimmer d;

void setup() {

  b= new Box();
  s= new Sound();
  e= new Effect();
}

void draw() {
  
  
  //if b.update is f1
  //d.soundSelector(rangeDim);
  
  b.update();
  
  s.update();
  
  e.update();
}
