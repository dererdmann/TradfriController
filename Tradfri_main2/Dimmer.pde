class Dimmer {
  int selectedSound = 0;
  int selectedId;
  int selectedOn;
  int midiNote1 = 0;
  int midiNote2 = 0;
  int channel = 0;
  int velocity = 127;
  boolean play = false;
  

  Dimmer(int id, int sound, int on) {
    selectedSound = sound;
    selectedId = id;
    selectedOn = on;
  }

  void update() {  
    println(oldSound);
    switch(selectedSound) {
    case 1:  
      midiNote1 = 48;
      midiNote2 = 45;
      break;
    case 2: 
      midiNote1 = 49;
      midiNote2 = 46;
      break;
    case 3:  
      midiNote1 = 50;
      midiNote2 = 47;
      break;
    case 4: 
      midiNote1 = 51;
      midiNote2 = 40;
      break;
    case 5:
      midiNote1 = 44;
      midiNote2 = 41 ;
      break;
    } 

if (selectedSound != oldSound){
  play= true;
  println("change!!!!!");
}

    //println(selectedId + "  " + selectedSound + "  " + selectedOn);
    if ( play == true) {
      if (selectedOn == 1) {
        if (selectedId == 1) {
          myBus.sendNoteOn(channel, midiNote1, velocity); // Send a Midi noteOn
          //delay(200);
          myBus.sendNoteOff(channel, midiNote1, velocity); // Send a Midi nodeOff
          oldSound = selectedSound;
          play = false;
          println("1played");
          
        }
        if (selectedId == 2) {
          myBus.sendNoteOn(channel, midiNote2, velocity); // Send a Midi noteOn
          //delay(200);
          myBus.sendNoteOff(channel, midiNote2, velocity); // Send a Midi nodeOff
          oldSound = selectedSound;
          play = false;
          println("2played");
          
        }
      }
    }
    println(oldSound);
    
  }
  
  
  
}
