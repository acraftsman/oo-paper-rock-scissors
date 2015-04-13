# There two players in the game of Paper Rock Scissors. They all have to pick a gesture with paper or rock or scissor. Finally, Judgment compares gestures between two players, then judgment shows a winner according to the rule.
# noun => two players, gesture, Judgment
# verb => pick a gesture, judge

class Player
  attr_reader :name
  attr_accessor :gesture
  CHOICE = ['p', 'r', 's']
  def initialize(n)
    @name = n
  end

  def pick_gesture
  end
end

class Gesture
  include Comparable
  attr_accessor :value
  def initialize(v)
    self.value = v
  end

  def <=>(another)
    if (value == 'p' && another.value == 'r') ||
       (value == 'r' && another.value == 's') || 
       (value == 's' && another.value == 'p')
      1
    elsif value == another.value
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
    end until CHOICE.include? choice
    self.gesture = Gesture.new(choice)
  end
end

class Computer < Player
  def pick_gesture
    self.gesture = Gesture.new(CHOICE.sample)
  end
end

class Judgment
  attr_accessor :player1, :player2
  def initialize(player1, player2)
    self.player1 = player1
    self.player2 = player2
  end

  def judge(gesture1, gesture2)
    if gesture1 == gesture2
      say "It's a tie!"
    elsif gesture1 > gesture2
      say "#{player1.name} won!"
      show_winning_msg(gesture1.value)
    else gesture1 < gesture2
      say "#{player2.name} won!"
      show_winning_msg(gesture2.value)
    end
  end

  def show_winning_msg(gesture_value)
    case gesture_value
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
    @judgment = Judgment.new(human, computer)
  end

  def play
    human_gesture = human.pick_gesture
    computer_gesture = computer.pick_gesture
    judgment.judge(human_gesture,computer_gesture)
  end
end

begin
  Game.new.play
  print "play again?(y/n):"
  is_play = gets.chomp.downcase
end while is_play == 'y'
