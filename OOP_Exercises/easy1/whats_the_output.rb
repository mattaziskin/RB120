=begin
What output does this code print? Fix this class so that there are no surprises
waiting in store for the unsuspecting developer.
class Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s
  end

  def to_s
    @name.upcase!
    "My name is #{@name}."
  end
end

name = 'Fluffy'
fluffy = Pet.new(name)
puts fluffy.name
puts fluffy
puts fluffy.name
puts name


It prints
Fluffy
<Pet Object "Fluffy">
Fluffy
Fluffy
=end

class Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s
  end

  def to_s
    "My name is #{@name.upcase}."
  end
end

# name = 'Fluffy'
# fluffy = Pet.new(name)
# puts fluffy.name
# puts fluffy
# puts fluffy.name
# puts name


#further
name = 42
fluffy = Pet.new(name)
name += 1
puts fluffy.name
puts fluffy
puts fluffy.name
puts name

#on line 56 when called the .to_s its called on INTEGER not PET so normal one is used
# '42' is finally assigned to @name, we call puts on fluffy and 42.upcase is
# passed in, passing 42, reading in name on fluffy return 42 again, final line is
# passing in GLOBAL VARIABLE name which was incremented on line 55 so 43 is output