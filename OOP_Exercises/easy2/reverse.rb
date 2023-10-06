=begin
Write a class that will display

ABC
xyz

When the following is run
my_data = Transform.new('abc')
puts my_data.uppercase
puts Transform.lowercase('XYZ')

=end

class Transform
  def initialize(input)
    @input = input
  end

  def uppercase
    @input.to_s.upcase
  end
  def self.lowercase(input)
    input.to_s.downcase
  end
end


my_data = Transform.new('abc')
puts my_data.uppercase
puts Transform.lowercase('XYZ')

# ABC
# xyz