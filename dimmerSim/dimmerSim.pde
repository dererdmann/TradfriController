// This example sketch connects to shiftr.io
// and sends a message on every keystroke.
//
// After starting the sketch you can find the
import mqtt.*;

MQTTClient client;

void setup() {
  client = new MQTTClient(this);
  client.connect("mqtt://127.0.0.1", "processing");
  client.subscribe("#");
}

void draw() {

  float r = random(1, 100); 
  int rInt = int(round(r));
  float dim = random(1,255);
  String dimString = str(round(dim));
  
  if (rInt == 3) {
    client.publish("TRÅDFRI/bulb/1/state/on", "1" );
    client.publish("TRÅDFRI/bulb/1/state/dim",  dimString);
    rInt = 4;
  }
}

void messageReceived(String topic, byte[] payload) {
  println("new message: " + topic + " - " + new String(payload));
}
