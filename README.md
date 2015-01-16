## Adafruit Servo Driver ##

[![CodeClimate](https://codeclimate.com/github/chrisdambrosio/adafruit-servo-driver/badges/gpa.svg)](https://codeclimate.com/github/chrisdambrosio/adafruit-servo-driver)

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
pwm.set_pwm_freq(50)

channel = 0

3.times do
  pwm.set_pwm(channel, 0, 212)
  sleep(0.5)
  pwm.set_pwm(channel, 0, 412)
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
