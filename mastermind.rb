class Mastermind
  @@feedback = {}
  def initialize (user, computer)
    @roles = [user.new(self), computer.new(self)]
    @role_id 
    @count = 12
  end

  def play
    description
    ask_role
    code_maker = current_code_maker
    loop do
      code_breaker = current_code_breaker
      @@feedback = feedback(code_maker, code_breaker)
      return puts "=> Corrected!!!" if corrected?
      return game_over if @count == 0
      @count -= 1 
      feedback_message
    end
  end

  def current_code_maker
    @roles[@role_id].code_maker
  end
  
  def current_code_breaker
    @roles[@role_id - 1].code_breaker(@@feedback)
  end

  def ask_role
    loop do
    puts "Please choice your role:"
    puts "1. Code Maker"
    puts "2. Code Breaker"
    @role_id = gets.chomp.to_i - 1
    return @role_id if [0,1].include?(@role_id)
    end
  end

  def corrected?
    @@feedback.values.all?("O")
  end

  def game_over
    puts "Game Over!!!"
    puts "#{@@feedback.keys[0]} #{@@feedback.keys[1]} #{@@feedback.keys[2]} #{@@feedback.keys[3]}"
  end

  def feedback(code_maker, code_breaker)
    hash = {}
    4.times do |i|
      if code_breaker[i] == code_maker[i]
        hash[code_breaker[i]] = "O"
      elsif code_maker.include?(code_breaker[i])
        hash[code_breaker[i]] = "A"
      else
        hash[code_breaker[i]] = "X"
      end
    end
    hash
  end

  def feedback_message
    puts ""
    puts "=> #{@@feedback.values[0]} #{@@feedback.values[1]} #{@@feedback.values[2]} #{@@feedback.values[3]}"
    puts "=> #{@count} turn left."
    puts ""
    puts "Colors : Black, Blue, Green, Orange, Purple, Red, White, and Yellow."
    puts ""
  end

  def description
    puts "Mastermind game"
    puts "you have to guess 4 colors that computer has choosen."
    puts "colors : Black, Blue, Green, Orange, Purple, Red, Silver, and Yellow."
    puts ""
    puts "How to input => red blue purple silver"
    puts "You can input like this => RED Blue PURPLE silver"
    puts "but i recommend you to input all in small case."
    puts ""
    puts "You will give a feedback about your answer like this."
    puts "=> A X X O"
    puts "O = Corrected, X = Not Corrected, A = Corrected color but wrong place"
    puts ""
    puts "You give 12 turns to guess the correct answers."
    puts "Good Luck!!!"
    puts ""
    puts ""
    puts "colors : Black, Blue, Green, Orange, Purple, Red, Silver, and Yellow."
    puts ""
    puts ""
  end

  def to_s
    "Mastermind Game"
  end
end

class Player
  @@OPTIONS = ["black", "blue", "green", "orange", "purple", "red", "white", "yellow"]
  def initialize(game)
    @game = game
  end
end

class User < Player
  def code_maker
    puts "Please input Colors."
    take_input
  end

  def code_breaker(feedback)
    puts "Please input your guessing."
    take_input
  end
  
  def take_input
    loop do
    input = gets.chomp.downcase.split()
    correct_input = input.map {|item| @@OPTIONS.include?(item)}.all?(true)
    not_double = input.uniq.count == 4
    return input if correct_input && not_double
    puts ""
    puts "You made misspelling, color is not available"
    puts "and it is prohibited to input same color. Please input again."
    end
  end

  def to_s
    "User"
  end
end

class Computer < Player
  @@new_values = []
  def code_maker
    @@OPTIONS.sample(4)
  end

  def code_breaker(feedback)
    return breaker = code_maker if feedback.empty? || feedback.values.all?("X")

    all_values = feedback.keys
    almost_values = feedback.select {|key, value| value == "A"}.keys.rotate(1)
    @@new_values = []
    breaker = feedback.transform_keys do |key|
      if feedback[key] != "O" && almost_values.size > 0 
        key = almost_values.shift
      elsif feedback[key] != "O" && almost_values.size == 0
        key = (@@OPTIONS - all_values - @@new_values).sample
        @@new_values.push(key)
        key
      else
        key
      end
    end.keys
    breaker
  end

  def to_s
    "Computer"
  end
end

Game = Mastermind.new(User, Computer).play