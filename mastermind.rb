require 'pry'
puts "Welcome to MASTERMIND"

@guesses = 0

def game_input
  puts "Would you like to (p)lay, read the (i)nstructions, or (q)uit?"
  command = gets.chomp.downcase
  binding.pry

  a = {q: exit_game, p: choose_difficulty, i: instructions }
  a.default = valid_command
  a[command].call

end

def valid_command
  puts "Please enter a valid command"
  game_input
end

def instructions
  puts "I create a random sequence of lettters (four long). You try to guess it. I'll keep track or your number of guesses and the time it took you to solve it"
end

def choose_difficulty
  puts "Would you like to play the (e)asy, (m)edium or (h)ard mode?"
  mode = gets
  play_game(mode)
end

def play_game(mode)
  puts mode_intro(mode)

  @guesses = 0
  @start_time = Time.now
  ans = generate_ans

  guess_again(ans)
end

def mode_intro(mode)
  "I have generated a beginner sequence with #{mode_elements(mode).size} elements made up of: #{mode_elements(mode)}. Use (q)uit at any time to end the game.  What's your guess?"
end

def mode_elements(mode)
  if mode == 'e'
    ["(r)ed, ", "(g)reen, ", "(b)lue,","(y)ellow"]
  elsif mode == 'm'
    mode_elements('e') << "(p)urple" 
  else 
    mode_elements('m') << "(o)range"
  end
end

def guess_again(ans)
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
    end_game(ans)
  else
    puts "Nope!, guess again"
    binding.pry
    puts give_feedback(ans, guess)
    @guesses += 1
    guess_again(ans)
  end
end

exit_game = lambda {
  puts "Exiting the game"
  exit
}

def give_feedback(ans, guess)
  "you guessed #{correct_elements(ans, guess)} correct elements with #{correct_positions(ans, guess)} in the correct posision"
end

def correct_elements(ans, guess)
  ans.chars.select { |let| guess.chars.uniq.include?(let) }.size
end

def correct_positions(ans, guess)
  ans = ans.chars
  guess = guess.chars
  ans.select.with_index do |let, i|
    let == guess[i] 
  end.size
end

def end_game(ans)
  puts "Congratulations! You guessed the sequence '#{ans}' in #{@guesses} guesses over #{time_taken}seconds."
  puts "Do you want to (p)lay again or (q)uit?"
  response = gets.chomp.downcase
  if response == 'play' || response == 'p' 
     play_game 
  elsif response == 'quit' || response == 'q' 
    exit_game
  end
end

def generate_ans(mode)
  ans = []
  ans_length(mode).times do
    ans << sample(mode)
  end
  ans.join
end

def ans_length(mode)
  {e: 4, m: 6, h: 8}[mode.to_sym]
end

def sample(mode)
  if mode == 'e'
    ['r','g','b','y']
  elsif mode == 'm'
    sample('e') << 'p'
  else  
    sample('m') << 'o'
  end
end


def time_taken
  (Time.now - @start_time).to_i
end

game_input
