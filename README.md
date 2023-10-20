# Introduction 
This application is used to monitor heart rate and temperature.
The application is built based on following hardware, software platform/component.

Hardware
- Raspberry Pi 4B 4G
- [ADS1115 ADC conversion module](https://learn.adafruit.com/adafruit-4-channel-adc-breakouts/downloads)
- Temperature sensor NTC 10K B3950

Software
- [Boot to Qt](https://doc.qt.io/Boot2Qt/)

# Boot to Qt Setting for Raspberry Pi
Refer to [Raspberry Pi 4 Quick Start Guide](https://doc.qt.io/Boot2Qt/b2qt-qsg-raspberry.html) to setup development environment for Raspberry Pi. The following items will be covered in this guide.
- Install Qt and Boot to Qt Software Stack
- Flashing the system image to a microSD card
- Setting up a device via Ethernet or Wi-Fi
- Configuring and building and running an application

# Hardware Connection
1. Connection between ADS1115 module and Raspberry Pi

Connect ADS1115 module to Raspberry Pi as below.
```
    Raspberry Pi              ADS1115 module
    Pin 1 (3.3V)                  VIN
    Pin 9 (Ground)                GND
    Pin 3 (I2C1 SDA)              SDA
    Pin 5 (I2C1 SCL)              SCL
```
The default I2C address (0x48) is used. Don't need to connect  ADDR pin of ADS1115 module.

2. Connection between temperature sensor circuit and ADS1115 module

Refer to this [tutorial](https://www.circuitbasics.com/arduino-thermistor-temperature-sensor-tutorial/) to create circuit for temperature sensor.
Connect the output of temperature sensor circuit (the connection between thermistor and 10K register) to channel 0 (pin A0) and channel 1 (pin A1) of ADS1115 module.

# Run Application
1. Enable I2C communication on Raspberry Pi

ssh to Raspberry Pi (IP adress displays on the screen, after Raspberry Pi booted), and enable i2c communication

```console
ssh root@IP-ADDRESS-HERE
modprobe i2c-dev
```

Verify i2c communication. The address of ADS1115 module will be displayed.

```console
i2cdetect -y 1

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:                         -- -- -- -- -- -- -- -- 
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
40: -- -- -- -- -- -- -- -- 48 -- -- -- -- -- -- -- 
50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
70: -- -- -- -- -- -- -- --  
```

2. From Qt Creator start the application

# Video
[<img src="https://i.ytimg.com/vi/0ZlhIj-2R3w/hqdefault.jpg">](https://youtu.be/0ZlhIj-2R3w "Heart rate and temperature monitoring demo")

# Todo
1. Proces analog heart rate sensor data (ECG)
2. Add system and sensor setting implementation
3. Add more monitoring parameters: ETCO2, SPO2
4. Add network service implementation

# Reference
1. Boot to Qt

https://doc.qt.io/Boot2Qt/

https://doc.qt.io/Boot2Qt/b2qt-qsg-raspberry.html

https://doc.qt.io/qtcreator/creator-configuring-projects.html

https://decovar.dev/blog/2016/07/25/b2qt-raspberry-pi/

https://retifrav.github.io/blog/2017/12/08/b2qt-startup-script/

https://forum.qt.io/topic/125919/unable-to-open-i2c-device-no-such-file-or-directory-on-boot2qt

2. ADS1115 ADC conversion module

https://learn.adafruit.com/adafruit-4-channel-adc-breakouts/downloads

https://github.com/OpenLabTools/RPi_ADS1115/blob/master/content.md

https://www.ti.com/lit/ds/symlink/ads1115.pdf?ts=1697788934923&ref_url=https%253A%252F%252Fwww.ti.com%252Fproduct%252FADS1115

3. I2C communication

https://www.ti.com/video/series/precision-labs/ti-precision-labs-i2c.html

4. Raspberry GPIO Pinout

https://www.raspberrypi.com/documentation/computers/raspberry-pi.html

https://pinout.xyz/

4. NTC temperature sensor

https://www.youtube.com/watch?v=Hr4QJ7u1Edk

https://www.circuitbasics.com/arduino-thermistor-temperature-sensor-tutorial/
