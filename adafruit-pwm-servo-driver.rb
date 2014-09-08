require 'i2c/i2c'

class PWM
  # Registers
  MODE1         = 0x00
  MODE2         = 0x01
  SUBADR1       = 0x02
  SUBADR2       = 0x03
  SUBADR3       = 0x04
  PRESCALE      = 0xFE
  LED0_ON_L     = 0x06
  LED0_ON_H     = 0x07
  LED0_OFF_L    = 0x08
  LED0_OFF_H    = 0x09
  ALL_LED_ON_L  = 0xFA
  ALL_LED_ON_H  = 0xFB
  ALL_LED_OFF_L = 0xFC
  ALL_LED_OFF_H = 0xFD

  # Bits
  RESTART            = 0x80
  SLEEP              = 0x10
  ALLCALL            = 0x01
  INVRT              = 0x10
  OUTDRV             = 0x04

  def initialize(address=0x40, debug=false)
    # TODO detect pi revision
    @address = address
    @i2c = I2C.create('/dev/i2c-1')
    @debug = debug
    puts 'Reseting PCA9685 MODE1 (without SLEEP) and MODE2' if @debug
    setAllPWM(0, 0)
    @i2c.write(@address, MODE2, OUTDRV)
    @i2c.write(@address, MODE1, ALLCALL)
    sleep(0.005)           # wait for oscillator

    mode1 = @i2c.read(@address, 8, MODE1).unpack('C').first
    @i2c.write(@address, MODE1, ALLCALL)
    mode1 = mode1 & ~SLEEP # wake up (reset sleep)
    @i2c.write(@address, MODE1, mode1)
    sleep(0.005)           # wait for oscillator
  end

  def set_pwm_freq(freq)
    prescaleval = 25000000.0    # 25MHz
    prescaleval /= 4096.0       # 12-bit
    prescaleval /= Float(freq)
    prescaleval -= 1.0
    if @debug
      puts "Setting PWM frequency to #{freq} Hz"
      puts "Estimated pre-scale: #{prescaleval}"
    end
    prescale = (prescaleval + 0.5).floor
    if @debug
      puts "Final pre-scale: #{prescale}"
    end

    oldmode = @i2c.read(@address, 8, MODE1).unpack('C').first
    newmode = (oldmode & 0x7F) | 0x10    # sleep
    @i2c.write(@address, MODE1, newmode) # go to sleep
    @i2c.write(@address, PRESCALE, prescale)
    @i2c.write(@address, MODE1, oldmode)
    sleep(0.005)
    @i2c.write(@address, MODE1, oldmode | RESTART)
  end
  alias_method :setPWMFreq, :set_pwm_freq

  def set_pwm(channel, on, off)
    @i2c.write(@address, LED0_ON_L+4*channel, on & 0xFF)
    @i2c.write(@address, LED0_ON_H+4*channel, on >> 8)
    @i2c.write(@address, LED0_OFF_L+4*channel, off & 0xFF)
    @i2c.write(@address, LED0_OFF_H+4*channel, off >> 8)
  end
  alias_method :setPWM, :set_pwm

  def set_all_pwm(on, off)
    @i2c.write(@address, ALL_LED_ON_L, on & 0xFF)
    @i2c.write(@address, ALL_LED_ON_H, on >> 8)
    @i2c.write(@address, ALL_LED_OFF_L, off & 0xFF)
    @i2c.write(@address, ALL_LED_OFF_H, off >> 8)
  end
  alias_method :setAllPWM, :set_all_pwm
end
