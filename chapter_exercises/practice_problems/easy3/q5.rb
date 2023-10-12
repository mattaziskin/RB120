=begin

If I have the following class:

class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end

What would happen if I called the methods like shown below?

tv = Television.new    new Televsion object created
tv.manufacturer        No method error
tv.model               model logic runs

Television.manufacturer      class method manufacturer runs
Television.model            no method error

=end


