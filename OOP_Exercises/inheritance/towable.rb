=begin

Using the following code, create a Towable module that contains a method named
tow that prints I can tow a trailer! when invoked. Include the module in the
Truck class.

class Truck
end

class Car
end

truck1 = Truck.new
truck1.tow
=end

class Vehicle
  attr_reader :year
  def initialize(year)
    @year = year
  end
end

module Towable
  def tow
    puts "I can tow a trailer!"
  end
end

class Truck < Vehicle
  include Towable
end

class Car < Vehicle
end

truck1 = Truck.new(1994)
puts truck1.year
puts truck1.tow
car1 = Car.new(2006)
puts car1.year

=begin
Using the previous code, create a class named Vehicle that, upon instantiation,
assigns the passed in argument to @year. Both Truck and Car should inherit from
Vehicle.

=end

