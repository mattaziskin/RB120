=begin
We need a new class Noble that shows the title and name when walk is called:

=end
module Walk
  def walk
    puts "#{self} #{gait} forward"
  end
end

class Person
  include Walk
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def to_s
    "#{name}"
  end

  private

  def gait
    "strolls"
  end
end

class Noble < Person
  attr_reader :title

  def initialize(name, title)
    super(name)
    @title = title
  end

  def to_s
    "#{title} #{name}"
  end

  private

  def gait
    "struts"
  end
end

class Cat
  include Walk
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def to_s
    "#{name}"
  end

  private

  def gait
    "saunters"
  end
end

class Cheetah
  include Walk
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def to_s
    "#{name}"
  end

  private

  def gait
    "runs"
  end
end

byron = Noble.new("Byron", "Lord")
byron.walk
# => "Lord Byron struts forward"
p byron.name
#=> "Byron"
p byron.title
#=> "Lord"
