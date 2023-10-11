=begin
If we have a class such as the one below

class Cat
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age  = 0
  end

  def make_one_year_older
    self.age += 1
  end
end

You can see in the make_one_year_older method we have used self. What does self
refer to here?

self returns the calling object

=end

class Cat
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age  = 0
  end

  def age=(new_age)
    @age = new_age
  end

  def make_one_year_older
    self.age += 1
  end
end

cat = Cat.new("tabby")
puts cat.age
cat.make_one_year_older
puts cat.age
rex = Cat.new('balk')
puts rex.age
rex.age = 2
puts rex.age