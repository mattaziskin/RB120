=begin

What is used in this class but doesn't add any value?

class Light
  attr_accessor :brightness, :color

  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end

  def self.information
    return "I want to turn on the light with a brightness level of super high
    and a color of green"
  end

end

explicit return of the string in self.information
also
The attr accessor because we're hard writing in the brightness and color in the
self.information method
=end