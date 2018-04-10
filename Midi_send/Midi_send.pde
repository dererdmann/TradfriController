import themidibus.*;
MidiBus myBus;

int channel = 0;
int pitch = 40;
int velocity = 127;

void setup() {
  size(200, 200);
  frameRate(6);
  //MidiBus.list(); // use the list to find your correct midi output port, for me it's 2, change it accordingly
  myBus = new MidiBus(this, -1, 1);
}

void draw() {
  pitch = int(random(40, 50));
  myBus.sendNoteOn(channel, pitch, velocity);
}
