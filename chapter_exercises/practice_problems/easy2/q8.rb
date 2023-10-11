=begin
class Game
  def play
    "Start the game!"
  end
end

class Bingo
  def rules_of_play
    #rules of play
  end
end

What can we add to the Bingo class to allow it to inherit the play method
from the Game class?

just subclass is
Bingo < Game