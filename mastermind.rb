class Maker
attr_reader :code
    def initialize
        @possible_numbers = [1, 2, 3, 4, 5, 6]
        @code = nil
    end

    def play(selection)
        if selection == "computer"
            @computer_code = (4.times.map {@possible_numbers.sample})
            @code = @computer_code
            print @code
        elsif selection == "user"
            puts "not coded yet"
        end
    end

end

class Breaker

    def initialize
        @number_of_guesses = 12
        @hint_correct_number = 0
        @hint_correct_position = 0
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

    def play(selection, code)
        if selection == "user"
            guess(code)
        elsif selection == "computer"
            puts "not coded yet"
        end
    end

end


class Game 
puts "Welcome to Mastermind"
puts "How to play:"
puts "Example:"

    def initialize
        @maker = Maker.new
        @breaker = Breaker.new
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
    end

end  


game = Game.new
game.start