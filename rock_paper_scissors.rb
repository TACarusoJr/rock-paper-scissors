VALID_CHOICES = ['rock', 'paper', 'scissors', 'lizard', 'Spock']
LOSES_TO = { 'rock' => ['paper', 'Spock'],
             'paper' => ['scissors', 'lizard'],
             'scissors' => ['rock', 'Spock'],
             'lizard' => ['rock', 'scissors'],
             'Spock' => ['paper', 'lizard'] }

def tie_condition?(player, computer)
  player == computer
end

def player_lose?(player, computer)
  LOSES_TO[player].include?(computer)
end

def prompt(message)
  Kernel.puts("=> #{message}")
end

def formatted_choice(choice)
  case choice
  when 'r'
    'rock'
  when 'p'
    'paper'
  when 's'
    'scissors'
  when 'l'
    'lizard'
  when 'S'
    'Spock'
  else
    choice
  end
end

def display_results(player, computer)
  return prompt("It's a tie") if tie_condition?(player, computer)

  if player_lose?(player, computer)
    prompt("You lose!")
  else
    prompt("You win!")
  end
end

player_win_count = 0
computer_win_count = 0
loop do
  choice = ''
  loop do
    choices = <<-MSG
      Choose one:
      rock (r)
      paper (p)
      scissors (s)
      lizard (l)
      Spock (S)
    MSG

    prompt(choices)
    choice = Kernel.gets().chomp()

    if VALID_CHOICES.include?(formatted_choice(choice))
      break
    else
      prompt("That's not a valid choice.")
    end
  end

  computer_choice = VALID_CHOICES.sample

  prompt("You chose: #{formatted_choice(choice)}
   The computer chose: #{computer_choice}")

  display_results(formatted_choice(choice), computer_choice)

  if player_lose?(formatted_choice(choice), computer_choice)
    computer_win_count += 1
  elsif tie_condition?(formatted_choice(choice), computer_choice)
  else
    player_win_count += 1
  end

  prompt("Your Wins: #{player_win_count} Computer Wins: #{computer_win_count}")

  if computer_win_count == 5
    prompt("The computer is the champion!")
    break
  end

  if player_win_count == 5
    prompt("The player is the champion!")
    break
  end
end

prompt("Thanks for playing! Goodbye.")
