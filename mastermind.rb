class Maker
attr_reader :code
    def initialize
        @possible_numbers = [1, 2, 3, 4, 5, 6]
        @code = nil
    end

    def valid_code?(code)
        if code.length >= 5 || code.length <= 3
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
            print @code
        elsif selection == "user"
            puts "Please type your 4 digit code, made from numbers 1-6"
            while @user_code = gets.chomp.gsub(/\W/, "0")
                case
                when valid_code?(@user_code) == false
                    puts "invalid code, please try again"
                else
                    @code = @user_code.split("").map{|string| string.to_i}
                    #print @code
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

    def computer_guess(code)
        @guess = @computer_start_guess
        
        until @guess == code
            puts "Computer guess #{@computer_guesses}"
            #logic to get the computer to guess & get hints
            print @guess
            hint(@guess, code)
            #use @all_possible_codes


            @computer_guesses += 1
            break if @computer_guesses == 13
        end
        puts "Game over!"
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