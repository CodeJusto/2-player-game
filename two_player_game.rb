@p1_score, @p2_score, @x, @y, @turn, @rand_question = 0,0,0,0,0,0
@p1_lives, @p2_lives = 3,3
@answer, @p1_name, @p2_name = "", "", ""
@question_storage = ["What is #{@x} + #{@y}?", "What is #{@x} - #{@y}?", "What is #{@x} * #{@y}?", "What is #{@x} / #{@y}?"]

require 'pry'
require 'colorize'

@question_hash = {
  "1": "+",
  "2": "-",
  "3": "*"
}

def generate_question
  @x, @y, @rand_question = rand(1..20), rand(1..20), rand(1..3)
  puts "What is #{@x} #{@question_hash[@rand_question.to_s.to_sym]} #{@y}?"
end

def generate_answer
  @answer = @x.send(@question_hash[@rand_question.to_s.to_sym],@y)
end

def print_score
    puts "Current scores"
    puts "#{@p1_name}: #{@p1_score}"
    puts "#{@p2_name}: #{@p2_score}"
end

def ask_question
  response = gets.chomp.downcase
  if response.to_i == @answer
    puts "You are correct!".colorize(:green) 
    @turn == :p1 ? @p1_score += 1 : @p2_score += 1
  else
    puts "You are very incorrect!".colorize(:light_red)
    @turn == :p1 ? @p1_lives -= 1 : @p2_lives -= 1
    print_score
  end
end

def turn_changer
  if @turn == :p1
    @turn = :p2
    puts "It is #{@p2_name}'s turn to answer!".colorize(:blue)
  else
    @turn = :p1
    puts "It is #{@p1_name}'s turn to answer!".colorize(:light_magenta)
  end
end

def input_name(player)
  puts "Enter Player #{player}'s' name."
  player == 1 ? @p1_name = gets.chomp : @p2_name = gets.chomp
end

def reset
  @p1_score, @p2_score, @p1_lives, @p2_lives = 0,0,3,3
  puts "Both players scores have been reset!"
  puts "#{@p1_name} and #{@p2_name} both have three lives."
end

# Game starts here!
puts "Shall we play a game?"
input = gets.chomp.downcase
if input == "yes"
  (1..2).each {|player| input_name(player)}
  while input == "yes"
    until (@p1_lives == 0) || (@p2_lives == 0) 
      turn_changer
      generate_question
      generate_answer
      ask_question
    end 
    
    puts "Thank you for playing!"
    if @p1_lives == 0
      puts "The winner is #{@p2_name} with a score of #{@p2_score}".colorize(:light_magenta)
      input = "no"
    else
      puts "The winner is #{@p1_name} with a score of #{@p1_score}".colorize(:blue)
      input = "no"
    end
    loop do
      puts "Play another game? (YES or NO)"
      input = gets.chomp.downcase
      if input == "yes"
        reset
        break
      elsif input == "no"
        puts "Thanks for playing!"
        break
      else
        puts "Please answer either YES or NO"
      end
    end
  end 
elsif input == "no"
  puts "Shutting down."
end