require 'i2c/i2c'

class PWM
  # Registers
  SUBADR1      = 0x02
  SUBADR2      = 0x03
  SUBADR3      = 0x04
  MODE1        = 0x00
  PRESCALE     = 0xFE
  LED0_ON_L    = 0x06
  LED0_ON_H    = 0x07
  LED0_OFF_L   = 0x08
  LED0_OFF_H   = 0x09
  ALLLED_ON_L  = 0xFA
  ALLLED_ON_H  = 0xFB
  ALLLED_OFF_L = 0xFC
  ALLLED_OFF_H = 0xFD

  def initialize(address=0x40, debug=false)
    # TODO detect pi revision
    @address = address
    @i2c = I2C.create('/dev/i2c-1')
    @debug = debug
    puts 'Reseting PCA9685' if @debug
    @i2c.write(@address, MODE1, 0x00)
  end

  def setPWMFreq(freq)
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
    @i2c.write(@address, MODE1, oldmode | 0x80)
  end

  def setPWM(channel, on, off)
    @i2c.write(@address, LED0_ON_L+4*channel, on & 0xFF)
    @i2c.write(@address, LED0_ON_H+4*channel, on >> 8)
    @i2c.write(@address, LED0_OFF_L+4*channel, off & 0xFF)
    @i2c.write(@address, LED0_OFF_H+4*channel, off >> 8)
  end
end
