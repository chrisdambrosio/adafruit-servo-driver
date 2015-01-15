module AdafruitServoDriver
  class I2CDevice
    DEVICES = [
      '/dev/i2c-0', # Raspberry Pi rev 1
      '/dev/i2c-1', # Raspberry Pi rev 2
    ]

    class << self
      def detect
        DEVICES.find(if_not_found) do |device_path|
          File.exist? device_path
        end
      end

      def if_not_found
        -> { raise DeviceNotFoundError.new }
      end
    end
  end

  class DeviceNotFoundError < StandardError
  end
end
