=begin
Using the following code, create a class named Person with an instance variable
named @secret. Use a setter method to add a value to @secret, then use a getter
method to print @secret.

person1 = Person.new
person1.secret = 'Shh.. this is a secret!'
puts person1.secret

Answer
class Person
  attr_accessor :secret
  def initialize
  end
end
person1 = Person.new
person1.secret = 'Shh.. this is a secret!'
puts person1.secret

2) Using the following code, add a method named share_secret that prints the
value of @secret when invoked.

class Person
  attr_writer :secret

  private

  attr_reader :secret
end

person1 = Person.new
person1.secret = 'Shh.. this is a secret!'
person1.share_secret

Answer
class Person
  attr_writer :secret
def share_secret
  puts secret
end
  private

  attr_reader :secret
end

person1 = Person.new
person1.secret = 'Shh.. this is a secret!'
person1.share_secret

3) Using the following code, add an instance method named compare_secret that
compares the value of @secret from person1 with the value of @secret of person2.

class Person
  attr_writer :secret

  protected

  attr_reader :secret
end

person1 = Person.new
person1.secret = 'Shh.. this is a secret!'

person2 = Person.new
person2.secret = 'Shh.. this is a different secret!'

puts person1.compare_secret(person2)
=end

class Person
  attr_writer :secret

  def compare_secret(other)
    secret == other.secret
  end
  protected

  attr_reader :secret
end

person1 = Person.new
person1.secret = 'Shh.. this is a secret!'

person2 = Person.new
person2.secret = 'Shh.. this is a different secret!'

puts person1.compare_secret(person2)