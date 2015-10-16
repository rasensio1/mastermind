require 'pry'
puts "Welcome to MASTERMIND"

def game_input
  puts "Would you like to (p)lay, read the (i)nstructions, or (q)uit?"
  command = gets.chomp.downcase

  case command
  when 'p'
    play_game
  when 'q'
    quit_game
  when 'i'
    display_instructions
  else
    puts "Please enter a valid command"
    game_input
  end
end

def play_game
  ans = generate_ans
  puts"I have generated a beginner sequence with four elements made up of: (r)ed, (g)reen, (b)lue, and (y)ellow. Use (q)uit at any time to end the game.  What's your guess?"

  guess_again(ans)
end

def guess_again(ans)
  byebug
  guess = gets.chomp.downcase

  if guess == 'q'
    exit_game
  elsif guess == 'c'
    puts ans
  elsif guess.length < 4 
    puts "Too short"
    play_game
  elsif guess.length > 4 
    puts "Too Long"
    play_game
  elsif guess == ans
    end_game
  else
    guess_again(ans)
  end
end

def exit_game
  puts "Exiting the game"
  exit
end

def end_game
  puts "Congratulations! You guessed the sequence 'GRRB' in 8 guesses over 4 minutes, 22 seconds."
  puts "Do you want to (p)lay again or (q)uit?"
  response = gets.chomp.downcase
  if response == 'play' || response == 'p' 
     play_game 
  elsif response == 'quit' || response == 'q' 
    exit_game
  end
end

def generate_ans
  ans = []
  4.times do
    ans << ['r','g','b','y'].sample
  end
  ans.join
end

game_input
