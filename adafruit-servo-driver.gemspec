# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'adafruit-servo-driver/version'

Gem::Specification.new do |spec|
  spec.name          = "adafruit-servo-driver"
  spec.version       = AdafruitServoDriver::VERSION
  spec.authors       = ["Chris D'Ambrosio"]
  spec.email         = ["cdambrosio@gmail.com"]
  spec.summary       = %q{Ruby i2c interface for the Adafruit PCA9685 Servo } +
                       %q{Driver and Raspberry Pi}
  spec.description   = %q{A Ruby implementation of Adafruit's Python library } +
                       %q{for the Adafruit PCA9685 16-Channel PWM Servo } +
                       %q{Driver for use with the Raspberry Pi.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "i2c", "~> 0.4.0"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
