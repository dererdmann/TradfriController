// This example sketch connects to shiftr.io
// and sends a message on every keystroke.
//
// After starting the sketch you can find the
// client here: https://shiftr.io/try.
//
// Note: If you're running the sketch via the
// Android Mode you need to set the INTERNET
// permission in Android > Sketch Permissions.
//
// by Joël Gähwiler
// https://github.com/256dpi/processing-mqtt

import mqtt.*;



MQTTClient client;

int currentDim;
int currentOn;
int intPayload;
int currentId;
String dim = "dim";
String on = "on";
String currentData;

void setup() {
  client = new MQTTClient(this);
  client.connect("mqtt://127.0.0.1", "processing");
  client.subscribe("#");
  // client.unsubscribe("/example");
}

void draw() {
  //client.publish("/test", "test");
}

void keyPressed() {
}

void messageReceived(String topic, byte[] payload) {
  
  //convert payload from Byte to String to Int
  intPayload = int(new String(payload));

  String[] topics = split(topic, "/");
  currentId = int(topics[2]);
  currentData = topics[4]; 

  //paste dim and on corresponding to topics
  if (currentData.equals(dim) == true) {
    currentDim = intPayload;
  }
  if (currentData.equals(on) == true) {
    currentOn = intPayload;
  }

  if (currentOn == 1) {
    println("Controller " + currentId + " hat den Wert: " + currentDim);
  } else {
    println("Controller " + currentId + " ist ausgeschaltet.");
  }
  println(topic + " " + new String(payload));
  
}
