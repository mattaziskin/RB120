=begin
We have an Oracle class and a RoadTrip class that inherits from the Oracle
class.

class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

class RoadTrip < Oracle
  def choices
    ["visit Vegas", "fly to Fiji", "romp in Rome"]
  end
end

What is result of following
trip = RoadTrip.new
trip.predict_the_future

You will + a random selection from choices within the roadtrip class

=end

class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

class RoadTrip < Oracle
  def choices
    ["visit Vegas", "fly to Fiji", "romp in Rome"]
  end
end

#What is result of following
trip = RoadTrip.new
p trip.predict_the_future
