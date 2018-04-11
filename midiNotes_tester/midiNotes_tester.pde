import themidibus.*; //Import the library

MidiBus myBus; // The MidiBus

void setup() {
  size(400, 400);
  background(0);

  MidiBus.list(); // List all available Midi devices on STDOUT. This will show each device's index and name.

  // Either you can
  //                   Parent In Out
  //                     |    |  |
  //myBus = new MidiBus(this, 0, 1); // Create a new MidiBus using the device index to select the Midi input and output devices respectively.

  // or you can ...
  //                   Parent         In                   Out
  //                     |            |                     |
  //myBus = new MidiBus(this, "IncomingDeviceName", "OutgoingDeviceName"); // Create a new MidiBus using the device names to select the Midi input and output devices respectively.

  // or for testing you could ...
  //                 Parent  In        Out
  //                   |     |          |
  myBus = new MidiBus(this, -1, 1); // Create a new MidiBus with no input device and the default Java Sound Synthesizer as the output device.
}

void draw() {
  int channel = 0;
  
  int velocity = round(int(random(1,128)));
  
  
  
  if ((keyPressed == true) && (key == 'a')) {
    myBus.sendControllerChange(channel, 22, velocity); // Send a controllerChange
    delay(30);
    println("CC1");
    
  }
  
  if ((keyPressed == true) && (key == 's')) {
    myBus.sendNoteOn(channel, 49, velocity); // Send a Midi noteOn
    delay(200);
    myBus.sendNoteOff(channel, 49, velocity); // Send a Midi nodeOff
    println("49");
    
  }
  
  if ((keyPressed == true) && (key == 'd')) {
    myBus.sendNoteOn(channel, 50, velocity); // Send a Midi noteOn
    delay(200);
    myBus.sendNoteOff(channel, 50, velocity); // Send a Midi nodeOff
    println("50");
    
  }
  
  if ((keyPressed == true) && (key == 'f')) {
    myBus.sendNoteOn(channel, 51, velocity); // Send a Midi noteOn
    delay(200);
    myBus.sendNoteOff(channel, 51, velocity); // Send a Midi nodeOff
    println("51");
    
  }
  
  //myBus.sendNoteOn(channel, pitch, velocity); // Send a Midi noteOn
  //delay(200);
  //myBus.sendNoteOff(channel, pitch, velocity); // Send a Midi nodeOff

  int number = 0;
  int value = 90;

 // myBus.sendControllerChange(channel, 3, velocity); // Send a controllerChange
  delay(30);
}

void noteOn(int channel, int pitch, int velocity) {
  // Receive a noteOn
  println();
  println("Note On:");
  println("--------");
  println("Channel:"+channel);
  println("Pitch:"+pitch);
  println("Velocity:"+velocity);
}

void noteOff(int channel, int pitch, int velocity) {
  // Receive a noteOff
  println();
  println("Note Off:");
  println("--------");
  println("Channel:"+channel);
  println("Pitch:"+pitch);
  println("Velocity:"+velocity);
}

void controllerChange(int channel, int number, int value) {
  // Receive a controllerChange
  println();
  println("Controller Change:");
  println("--------");
  println("Channel:"+channel);
  println("Number:"+number);
  println("Value:"+value);
}

void delay(int time) {
  int current = millis();
  while (millis () < current+time) Thread.yield();
}
