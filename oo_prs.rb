# There two players in the game of Paper Rock Scissors. They all have to pick a gesture with paper or rock or scissor. Finally, Judgment compares gestures between two players, then judgment shows a winner according to the rule.
# noun => two players, gesture, Judgment
# verb => pick a gesture, judge

class Player
  attr_reader :name
  attr_accessor :gesture
  def initialize(n)
    @name = n
  end

  def pick_gesture
  end
end

class Gesture
  include Comparable
  attr_accessor :value
  CHOICE = ['p', 'r', 's']
  def initialize(v)
    self.value = v
  end

  def <=>(another)
    if (self.value == 'p' && another.value == 'r') || (self.value == 'r' && another.value == 's') || (self.value == 's' && another.value == 'p')
      1
    elsif self.value == another.value
      0
    else
      -1
    end 
  end
end

class Human < Player
  def pick_gesture
    begin
      puts "Choose one(p/r/s):"
      choice = gets.chomp.downcase
    end until Gesture::CHOICE.include? choice
    self.gesture = Gesture.new(choice)
  end
end

class Computer < Player
  def pick_gesture
    self.gesture = Gesture.new(Gesture::CHOICE.sample)
  end
end

class Judgment
  attr_accessor :player1, :player2
  def initialize(p1, p2)
    self.player1 = p1
    self.player2 = p2
  end
  def judge(g1, g2)
    if g1 == g2
      say "It's a tie!"
    elsif g1 > g2
      say "#{player1.name} won!"
      show_winning_msg(g1.value)
    else g1 < g2
      say "#{player2.name} won!"
      show_winning_msg(g2.value)
    end
  end

  def show_winning_msg(gesture)
    case gesture
    when 'p'
      say "Paper wraps Rock!"
    when 'r'
      say "Rock smashs Scissors!"
    when 's'
      say "Scissors cuts Paper!"
    end
  end

  private
  def say(msg)
    puts "=> #{msg}"
  end  
end

class Game
  attr_reader :human, :computer, :judgment
  def initialize
    @human = Human.new("Alan")
    @computer = Computer.new("Mac")
    @judgment = Judgment.new(self.human, self.computer)
  end

  def play
    human_gesture = human.pick_gesture
    computer_gesture = computer.pick_gesture
    judgment.judge(human_gesture,computer_gesture)
  end
end

begin
  Game.new.play
  puts "play again?(y/n)"
  is_play = gets.chomp.downcase
end while is_play == 'y'
