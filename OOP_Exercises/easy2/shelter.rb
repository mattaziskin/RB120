=begin

butterscotch = Pet.new('cat', 'Butterscotch')
pudding      = Pet.new('cat', 'Pudding')
darwin       = Pet.new('bearded dragon', 'Darwin')
kennedy      = Pet.new('dog', 'Kennedy')
sweetie      = Pet.new('parakeet', 'Sweetie Pie')
molly        = Pet.new('dog', 'Molly')
chester      = Pet.new('fish', 'Chester')

phanson = Owner.new('P Hanson')
bholmes = Owner.new('B Holmes')

shelter = Shelter.new
shelter.adopt(phanson, butterscotch)
shelter.adopt(phanson, pudding)
shelter.adopt(phanson, darwin)
shelter.adopt(bholmes, kennedy)
shelter.adopt(bholmes, sweetie)
shelter.adopt(bholmes, molly)
shelter.adopt(bholmes, chester)
shelter.print_adoptions
puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."

Write the classes and methods that will be necessary to make this code run, and
print the following output:

P Hanson has adopted the following pets:
a cat named Butterscotch
a cat named Pudding
a bearded dragon named Darwin

B Holmes has adopted the following pets:
a dog named Molly
a parakeet named Sweetie Pie
a dog named Kennedy
a fish named Chester

P Hanson has 3 adopted pets.
B Holmes has 4 adopted pets.

=end

class Shelter

  attr_accessor :adoptable_pets
  def initialize
    @adoptions = Hash.new([])
    @adoptable_pets = Pet.adoptable_pets
  end
  def adopt(owner, pet)
    owner.adopt(pet)
    @adoptions[owner.name] += ["A #{pet.type} named #{pet.name}"]
    @adoptable_pets.delete("A #{pet.type} named #{pet.name}")
  end
  def print_adoptions
    @adoptions.each_key do |key|
      puts "#{key} has adopted the following pets:"
      @adoptions[key].each do |value|
        puts value
      end
      puts ""
    end
    puts "The Shelter has the remaining pets available to adopt"
    @adoptable_pets.each do |pet|
      puts pet
    end
  end
end

class Owner
  attr_reader :name, :number_of_pets, :pets
  def initialize(name)
    @name = name
    @pets = []
  end
  def adopt(pet)
    @pets << pet
  end
end

class Pet
  @@created_pets = []
  attr_reader :type, :name
  def initialize(type, name)
    @type = type
    @name = name
    @@created_pets << "A #{type} named #{name}"
  end
  def self.adoptable_pets
    @@created_pets
  end
end

butterscotch = Pet.new('cat', 'Butterscotch')
pudding      = Pet.new('cat', 'Pudding')
darwin       = Pet.new('bearded dragon', 'Darwin')
kennedy      = Pet.new('dog', 'Kennedy')
sweetie      = Pet.new('parakeet', 'Sweetie Pie')
molly        = Pet.new('dog', 'Molly')
chester      = Pet.new('fish', 'Chester')
rex = Pet.new('dog', "Rex")
sinbad = Pet.new('fish', "Sinbad")

phanson = Owner.new('P Hanson')
bholmes = Owner.new('B Holmes')

shelter = Shelter.new
shelter.adopt(phanson, butterscotch)
shelter.adopt(phanson, pudding)
shelter.adopt(phanson, darwin)
shelter.adopt(bholmes, kennedy)
shelter.adopt(bholmes, sweetie)
shelter.adopt(bholmes, molly)
shelter.adopt(bholmes, chester)
shelter.print_adoptions
puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."
puts "The shelter has #{shelter.adoptable_pets.size} animals available"

# P Hanson has adopted the following pets:
# a cat named Butterscotch
# a cat named Pudding
# a bearded dragon named Darwin

# B Holmes has adopted the following pets:
# a dog named Molly
# a parakeet named Sweetie Pie
# a dog named Kennedy
# a fish named Chester

# P Hanson has 3 adopted pets.
# B Holmes has 4 adopted pets.