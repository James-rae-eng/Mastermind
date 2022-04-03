class Maker
attr_reader :code
    def initialize
        @possible_numbers = [1, 2, 3, 4, 5, 6]
        @code = nil
    end

    def valid_code?(code)
        if code.length >= 5 || code.length <= 3
            false
        elsif code.include?("7") || code.include?("8") || code.include?("9")
            false
        elsif code.count("a-zA-Z") > 0 || code.count("0") > 0
            false
        else 
            true
        end
    end

    def play(selection)
        if selection == "computer"
            @computer_code = (4.times.map {@possible_numbers.sample})
            @code = @computer_code
        elsif selection == "user"
            puts "Please type your 4 digit code, made from numbers 1-6"
            while @user_code = gets.chomp.gsub(/\W/, "0")
                case
                when valid_code?(@user_code) == false
                    puts "invalid code, please try again"
                else
                    @code = @user_code.split("").map{|string| string.to_i}
                    break
                end
            end
        end
    end
end

class Breaker
    def initialize
        @number_of_guesses = 12
        @hint_correct_number = 0
        @hint_correct_position = 0
        @computer_guesses = 1
        @computer_start_guess = [1, 1, 2, 2]
        @all_possible_codes = Array(1111..6666)
        @all_possible_codes.delete_if {|x| x.digits.member?(0)}
        @guess = nil
    end

    def guess(code)
        if @number_of_guesses >=1 
            puts "Please type your guess"
            while guess = gets.chomp
                case 
                when guess.length == 4 
                    array_guess = guess.split("").map(&:to_i)
                    @number_of_guesses -= 1
                    guess_correct?(array_guess, code)
                    break    
                else 
                    puts "Invalid response, please try again"
                end
            end
        else 
            print "You're all out of guesses, game over, better luck next time"
        end
    end

    def hint(guess, code)
        print "  Hint: "
        guess.each_with_index do |value, key|
            if value == code[key]
                print "\u{2B24} " #filled in circle
            elsif value != code[key] && code.include?(value)
                print "\u{25CD} " #half shaded circle
            else
                print "\u{25EF} " #empty circle
            end
        end
    end

    def guess_correct?(guess, code)
        print guess
        if guess == code
            puts " Correct, you win!"
        else 
            hint(guess, code)
            puts "  You have #{@number_of_guesses} guesses left"
            guess(code)
        end
    end

    def logic(guess, code)
        guess.each_with_index do |value, index|
            if !code.include?(value)
                @all_possible_codes.delete_if {|item| item.digits.member?(value)}
            elsif code.include?(value) && value != code[index]
                @all_possible_codes.delete_if do |item| 
                    array = item.digits.reverse
                    array[index] == value
                end
            end    
        end    
    end

    def computer_guess(code)
        @guess = @computer_start_guess
        until @guess == code || @computer_guesses == 13
            puts "\n" "Computer guess #{@computer_guesses}"
            print @guess
            hint(@guess, code)
            logic(@guess, code)
            @guess = @all_possible_codes[0].to_s.split("").map{|string| string.to_i}
            @computer_guesses += 1
        end
        if @guess == code
            puts "\nComputer guess #{@computer_guesses}"
            print "#{@guess} Correct"
            puts "\nGame over, the computer wins!"
        else 
            puts "\n" "Game over, the computer couldn't guess, you win!"
        end
    end

    def play(selection, code)
        if selection == "user"
            guess(code)
        elsif selection == "computer"
            computer_guess(code)
        end
    end
end

class Game 
puts "\n\e[1m\e[4mWelcome to Mastermind\e[0m"
puts "\n\e[4mHow to play\e[0m:
In this game you play against the computer and the object is to 
either break the code the computer has set, or make a code yourself for the 
computer to break.

The code MAKER types in a 4 digit code, comprising only numbers 1-6, numbers
can be repeated, but ony whole numbers can be used.

The code BREAKER must attempt to guess the code within 12 guesses and will get a
hint after each guess.

A hint consists of 4 circles which translate to the following:
-A full circle means the number guessed is correct, and in the correct position.
-A half filled circle means the number guessed is included somewhere in the makers
 code but is not in the correct position.
-An empty circle means that the number is not included in the makers code."
puts "\n\e[4mExample game\e[0m:
Makers code:
1665

Breakers code guesses:
1234
[1, 2, 3, 4]  Hint \u{2B24} \u{25EF} \u{25EF} \u{25EF}   11 guesses left
1566
[1, 5, 6, 6]  Hint \u{2B24} \u{25CD} \u{25CD} \u{25CD}   10 guesses left
1665
[1, 6, 6, 5]  Hint \u{2B24} \u{2B24} \u{2B24} \u{2B24}   Correct, game won!\n"

    def initialize
        @maker = Maker.new
        @breaker = Breaker.new
    end

    def replay_game
        puts "\nWould you like to play again? Enter y / n"
        choice = gets.chomp.to_s.downcase
        if choice == "y"
            game = Game.new
            game.start
        elsif choice == "n"
            puts "Thanks for playing!"
        else
            puts "Invalid selection"
        end
    end

    def start
        puts "Would you like to be the code Maker or the code Breaker?"
        puts "Please type 'm' to be maker and 'b' for breaker."
        while selection = gets.chomp.downcase
            case 
            when selection == "m" 
                #this not implemented yet, will need work
                @maker.play("user")
                @breaker.play("computer", @maker.code)
                break
            when selection == "b"
                @maker.play("computer")
                @breaker.play("user", @maker.code)
                break
            else 
                puts "Invalid choice please type m or b"
            end
        end
        replay_game()
    end
end  

game = Game.new
game.start