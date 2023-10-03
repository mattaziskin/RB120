=begin
Modify the following code so that Hello! I'm a cat! is printed when
Cat.generic_greeting is invoked.

class Cat
end

Cat.generic_greeting

2) Using the following code, add an instance method named #rename that renames
kitty when invoked.

class Cat
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

kitty = Cat.new('Sophie')
kitty.name
kitty.rename('Chloe')
kitty.name

3) Using the following code, add a method named #identify that returns its
calling object.

class Cat
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

kitty = Cat.new('Sophie')
p kitty.identify

4) Using the following code, add two methods: ::generic_greeting and
#personal_greeting. The first method should be a class method and print a
greeting that's generic to the class. The second method should be an instance
method and print a greeting that's custom to the object.

5) track the number of times a new Cat object is instantiated. The total
number of Cat instances should be printed when ::total is invoked.

6) create a class named Cat that prints a greeting when #greet is invoked. The
greeting should include the name and color of the cat. Use a constant to
define the color.

7) Update the code so that it prints I'm Sophie! when it invokes puts kitty.


=end
class Cat
  attr_reader :name

  @@total_cats = 0

  COLOR = "Black"

  def initialize(name)
    @name = name
    @@total_cats += 1
  end

  def rename(new_name)
    self.name = new_name
  end

  def identify
    self
  end

  def self.generic_greeting
    puts "Hi! I'm a cat!"
  end

  def personal_greeting
    puts "Hi! I'm #{name}"
  end

  def self.total
    p @@total_cats
  end

  def greet
    puts "Hail me.  I am #{name} the #{COLOR}.  You exist to feed me."
  end

  def to_s
    "I'm #{name}!"
  end
end

kitty = Cat.new('Sophie')
Cat.generic_greeting
kitty.personal_greeting
kitty1 = Cat.new("Yaboy")
kitty2 = Cat.new("Huey")
Cat.total

kitty.greet
puts kitty
