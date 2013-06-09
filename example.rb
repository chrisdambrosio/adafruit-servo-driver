#!/usr/bin/env ruby

# adapted from http://www.raspberrypi.org/phpBB3/viewtopic.php?t=32826

require File.dirname(__FILE__) + '/adafruit-pwm-servo-driver'

pwm = PWM.new(0x40, true)
pwm.setPWMFreq(50)

channel = 0

3.times do
  pwm.setPWM(channel, 0, 212)
  sleep(0.5)
  pwm.setPWM(channel, 0, 412)
  sleep(0.5)
end
