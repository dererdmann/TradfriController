# TrådfriController

Hardware hacked IKEA IoT-Devices for a freeform performance Interface.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

* [MQTT](http://mqtt.org) - Recieve Data from the Ikea gateway
* [Tradfri2Mqtt](https://github.com/hardillb/TRADFRI2MQTT) - Java App that translates the dimmer values to MQTT data
* [Ableton](https://www.ableton.com/de/live/) - Output the Data as Sound
* [Processing IDE](https://processing.org) - Processing
* Ableton Projectfiles coming
* Arduino Code coming

### Installing

Initialise the MQTT Broker on your machine and connect the "Tradfri2Mqtt" to the Gateway Ip and the Broker.

```
java -jar TRADFRI2MQTT-X.X.X-SNAPSHOT.jar -ip 192.168.1.XXX -psk xxxxxxxxxxxxxxxx -broker tcp://localhost
```
You can find the PSK on the bottom of the Gateway.

Subscribe in your Processing Code to the broker. You can alternatively check the send data in the terminal with (replace ip with your broker ip)

```
mosquitto_sub -t '#' -p 1883 -h 127.0.0.1 -v

```
You should be able to see the dimmer values come in as
```
TRÅDFRI/bulb/nameOfTheBulb/state/on  1
TRÅDFRI/bulb/nameOfTheBulb/state/dim  126
```
Install a MidiBus via IAC Bus (mac) or [Midi Yoke](http://www.midiox.com) (win) to send the commands to Ableton.

Connect Ableton to the created Bus and put the right output in the "processing.pde". If you are not sure which one it is use

```
MidiBus.list();
```
which prints a list for available ports.

Start the Processing file "name" and check for errormessages


Install a MidiBus via IAC Bus (mac) or [Midi Yoke](http://www.midiox.com) (win) to send the commands to Ableton.

## Acknowledgments

* wouldn't have been possible without [Robert Schnüll](https://github.com/robertschnuell)
