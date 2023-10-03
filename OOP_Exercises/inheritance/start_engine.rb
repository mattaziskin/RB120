=begin
Change the following code so that creating a new Truck automatically invokes
#start_engine.

class Vehicle
  attr_reader :year

  def initialize(year)
    @year = year
  end
end

class Truck < Vehicle
  def start_engine
    puts 'Ready to go!'
  end
end

truck1 = Truck.new(1994)
puts truck1.year



class Vehicle
  attr_reader :year

  def initialize(year)
    @year = year
  end

  def start_engine
    puts 'Ready to go!'
  end
end

class Truck < Vehicle
  def initialize(year)
    super
    start_engine
  end
end

truck1 = Truck.new(1994)
puts truck1.year


Part 2

Given the following code, modify #start_engine in Truck by appending 'Drive
fast, please!' to the return value of #start_engine in Vehicle. The 'fast' in
'Drive fast, please!' should be the value of speed.

class Vehicle
  def start_engine
    'Ready to go!'
  end
end

class Truck < Vehicle
  def start_engine(speed)
  end
end

truck1 = Truck.new
puts truck1.start_engine('fast')
=end


class Vehicle
  def start_engine
    'Ready to go!'
  end
end

class Truck < Vehicle
  def start_engine(speed)
    super() + " Drive #{speed}, please!"
  end
end

truck1 = Truck.new
puts truck1.start_engine('fast')