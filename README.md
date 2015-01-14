## Adafruit Servo Driver ##

### Description ###

A Ruby implementation of Adafruit's Python library for the Adafruit PCA9685 16-Channel
PWM Servo Driver for use with the Raspberry Pi.

### Installation ###

```
gem install adafruit-servo-driver
```

### Usage/Example ###

```ruby
require 'adafruit-servo-driver'

pwm = PWM.new(0x40, true)
pwm.setPWMFreq(50)

channel = 0

3.times do
  pwm.setPWM(channel, 0, 212)
  sleep(0.5)
  pwm.setPWM(channel, 0, 412)
  sleep(0.5)
end
```

### Relevant Links: ###

Product Page:
http://www.adafruit.com/products/815

Original Adafruit Python Adafruit_PWM_Servo_Driver Library:
https://github.com/adafruit/Adafruit-Raspberry-Pi-Python-Code

Tutorial: Adafruit 16 Channel Servo Driver with Raspberry Pi
http://learn.adafruit.com/adafruit-16-channel-servo-driver-with-raspberry-pi
