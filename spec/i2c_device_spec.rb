include AdafruitServoDriver

describe I2CDevice do
  context 'A Raspberry Pi rev 1' do
    before do
      allow(File).to receive('exist?').with('/dev/i2c-0').and_return true
    end

    it 'detects the device path' do
      expect(I2CDevice.detect).to eq '/dev/i2c-0'
    end
  end

  context 'A Raspberry Pi rev 2' do
    before do
      allow(File).to receive('exist?').with('/dev/i2c-0').and_return false
      allow(File).to receive('exist?').with('/dev/i2c-1').and_return true
    end

    it 'detects the device path' do
      expect(I2CDevice.detect).to eq '/dev/i2c-1'
    end
  end

  context 'an unknown device' do
    before do
      allow(File).to receive('exist?').with('/dev/i2c-0').and_return false
      allow(File).to receive('exist?').with('/dev/i2c-1').and_return false
    end

    it 'raises a DeviceNotFoundError' do
      expect{I2CDevice.detect}.to raise_error DeviceNotFoundError
    end
  end
end
