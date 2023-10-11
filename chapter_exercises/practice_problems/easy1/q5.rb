=begin
Which of these two classes would create objects that would have an instance
variable and how do you know?

class Fruit
  def initialize(name)
    name = name
  end
end

class Pizza
  def initialize(name)
    @name = name
  end
end


Pizza because "@" prefixs mean an instance variable
There is actually an #instance_variables method that would return the
list in an array as well
=end

