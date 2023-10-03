#add accessor method for following

class Person
  attr_accessor :name
  attr_writer :phone_number
end

person1 = Person.new
person1.name = 'Jessica'
puts person1.name

=begin

Add the appropriate accessor methods to the following code.
class Person
end

person1 = Person.new
person1.name = 'Jessica'
person1.phone_number = '0123456789'
puts person1.name
=end

person2 = Person.new
person2.name = 'Jessica'
person2.phone_number = '0123456789'
puts person1.name