class Dimmer {
  int selectedSound = 0;
  int selectedId;
  int selectedOn;

  int selectedField;
  int modulated;
  int midiNote1 = 0;
  int midiNote2 = 0;
  int channel = 0;
  int velocity = 127;


  int number1 = 0;
  int number2 = 1;

  int mute1 = 36;
  int mute2 = 37;

  boolean play = false;
  boolean playMod = false;
  boolean playOn = false;

  Dimmer(int id, int sound, int on, int modulated, int activatedField) {
    selectedSound = sound;
    selectedId = id;
    selectedOn = on;
    selectedModulate = modulated;
    selectedField = activatedField;
  }

  void update() {
    switch(selectedSound) {
    case 0:
      midiNote1 = 39;
      midiNote2 = 39;
      break;
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

    if (selectedSound != oldSound) {
      play = true;
    }
    if (selectedModulate != oldSelectedModulate) {
      playMod= true;
    }
    if (selectedOn != oldSelectedOn) {
      playOn= true;
    }

    //SOUNDSelector___________________________
    if (selectedField == 0) {
      if ( play == true) {
        if (selectedOn == 1) {
          if (selectedId == 1) {
            myBus.sendNoteOn(channel, midiNote1, velocity); // Send a Midi noteOn
            myBus.sendNoteOff(channel, midiNote1, velocity); // Send a Midi nodeOff
            oldSound = selectedSound;
            play = false;
          }
          if (selectedId == 2) {
            myBus.sendNoteOn(channel, midiNote2, velocity); // Send a Midi noteOn
            myBus.sendNoteOff(channel, midiNote2, velocity); // Send a Midi nodeOff
            oldSound = selectedSound;
            play = false;
          }
        }
        if (selectedOn == 0) {
          if (selectedId == 1) {
            myBus.sendNoteOn(channel, 28, velocity); // Send a Midi noteOn
            myBus.sendNoteOff(channel, 28, velocity); // Send a Midi nodeOff
            oldSound = selectedSound;
            play = false;
          }
          if (selectedId == 2) {
            myBus.sendNoteOn(channel, 29, velocity); // Send a Midi noteOn
            myBus.sendNoteOff(channel, 29, velocity); // Send a Midi nodeOff
            oldSound = selectedSound;
            play = false;
          }
        }
      }
    }

    //PerfoMode___________________________
    if (selectedField == 10) {
      if ( playMod == true) {
        if (selectedOn == 1) {
          if (selectedId == 1) {
            myBus.sendControllerChange(channel, number1, selectedModulate); // send modulation data
            //println("Send Dimmer 1 " + selectedModulate + " to Ableton");
            playMod = false;
          }
          if (selectedId == 2) {
            //println("Send Dimmer 2 " + selectedModulate + " to Ableton");
            myBus.sendControllerChange(channel, number2, selectedModulate); // send modulation data 
            playMod = false;
          }
        }
        if (playOn == true) {
          if (selectedOn == 0) {
            if (selectedId == 1) {
              myBus.sendNoteOn(channel, mute1, velocity); // Send a Midi noteOn
              myBus.sendNoteOff(channel, mute1, velocity); // Send a Midi nodeOff
              oldSelectedOn = selectedOn;
              playMod = false;
            }
            if (selectedId == 2) {
              myBus.sendNoteOn(channel, mute2, velocity); // Send a Midi noteOn
              myBus.sendNoteOff(channel, mute2, velocity); // Send a Midi nodeOff
              oldSelectedOn = selectedOn;
              playMod = false;
            }
          }
        }
      }
    }
    oldSelectedOn = selectedOn;
    oldSelectedModulate = selectedModulate;
  }
}
