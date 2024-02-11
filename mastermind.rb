class Mastermind
  @@OPTIONS = ["black", "blue", "green", "orange", "purple", "red", "silver", "yellow"]
  def computer_code_maker
    @@OPTIONS.sample(4)
  end

  def user_code_breaker
    puts "Please input your guessing."
    input = gets.chomp.downcase.split()
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

  def corrected?(feedback)
    feedback.values.all?("O")
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

  def draw_message(feedback)
    puts "Game Over!!!"
    puts "#{feedback.keys[0]} #{feedback.keys[1]} #{feedback.keys[2]} #{feedback.keys[3]}"
  end

  def play
    count = 12
    description
    code_maker = computer_code_maker
    loop do
      code_breaker = user_code_breaker
      feedback = feedback(code_maker, code_breaker)
      return puts "Corrected" if corrected?(feedback)
      return draw_message(feedback) if count == 0
      puts "=> #{feedback.values[0]} #{feedback.values[1]} #{feedback.values[2]} #{feedback.values[3]}"
      count -= 1 
      puts "=> #{count} turn left."
      puts ""
      puts "colors : Black, Blue, Green, Orange, Purple, Red, Silver, and Yellow."
      puts ""
    end
  end
end
mm = Mastermind.new
mm.play