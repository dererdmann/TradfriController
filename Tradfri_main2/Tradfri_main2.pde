import processing.serial.*;
Serial myPort; 
int val;

import mqtt.*;
MQTTClient client;

import themidibus.*;
MidiBus myBus;

//mqtt var
int currentDim;
int currentOn;
int intPayload;
int currentId;
String dimr = "dim";
String onr = "on";
String currentData;

//box var
boolean f0 = false;
boolean f1 = false;

//dimmerstatus var
int dId;
boolean dOn;
int dim;
int activeSound;
int modulate;

int oldSound = 0;
int oldSelectedOn = 0;

int activeField;

int sound;
int effect;

Dimmer d1;

void setup() {


  //arduino input
  String portName = Serial.list()[2]; //check the port
  myPort = new Serial(this, portName, 9600);

  //mqtt input
  client = new MQTTClient(this);
  client.connect("mqtt://127.0.0.1", "processing");
  client.subscribe("#");

  myBus = new MidiBus(this, -1, 1);

  d1 = new Dimmer(0, 0, 0, 0, 0);
}

void draw() {
  //activeField = -1;
  parseSerial();
  createDimmer();
  d1.update();
}



void parseSerial() {
  if ( myPort.available() > 0) {  // If data is available,
    val = myPort.read();  

    switch(val) {
    case 0: 
      //println("0"); 
      activeField = 0;
      break;
    case 1: 
      //println("1"); 
      activeField = 1;
      break;
    case 2: 
      //println("2");  
      activeField = 2;
      break;
    case 3: 
      //println("3");
      activeField = 3;
      break;
    case 4: 
      //println("4");
      activeField = 4;
      break;
    case 5: 
      //println("5");
      activeField = 5;
      break;
    case 6: 
      //println("6");
      activeField = 6;
      break;
    case 7: 
      //println("7");
      activeField = 7;
      break;
    case 8: 
      //println("8");
      activeField = 8;
      break;
    case 9: 
      //println("9");
      activeField = 9;
      break;
    case 10: 
      //println("9");
      activeField = 10;
      break;
    }
  }
}



void createDimmer() {

  //soundselection
  if (activeField == 0) {

    if (currentOn ==1) {
      activeSound = round(map(currentDim, 1, 254, 1, 5));
      //println(activeSound);
    }
    //println("activeSound "+ "of Controller " + currentId + " is: " + activeSound);
    d1 = new Dimmer(currentId, activeSound, currentOn, 0, activeField);
  } 

  if (activeField == 10) {
    modulate =  int(map(currentDim, 1, 254, 0, 127));
    println(modulate);
    d1 = new Dimmer(currentId, activeSound, currentOn, modulate, activeField);
  }

  /*when active field is 0
   then sound select shit
   
   when active field is 1
   then effect select shit
   
   write that shit into dimmer class  
   create dimmer with 
   
   int id;
   int sound;
   int effect;
   
   d= new Dimmer(with that shit in here);
   */
}

void messageReceived(String topic, byte[] payload) {

  //convert payload from Byte to String to Int
  intPayload = int(new String(payload));

  String[] topics = split(topic, "/");
  currentId = int(topics[2]);
  currentData = topics[4]; 

  //paste dim and on corresponding to topics
  if (currentData.equals(dimr) == true) {
    currentDim = intPayload;
  }
  if (currentData.equals(onr) == true) {
    currentOn = intPayload;
  }

  if (currentOn == 1) {
    //println("Controller " + currentId + " hat den Wert: " + currentDim);
  } else {
    //println("Controller " + currentId + " ist ausgeschaltet.");
    activeSound = 0;
    //println("shutoff");
  }
  //println(topic + " " + new String(payload)); //print all

  /*change the sound/effect/parameter of currentId dimmer via currentDim or delete 
   if currentOn is 0 of currentId*/
}
