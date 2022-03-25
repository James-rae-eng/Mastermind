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
    end

    def play(selection, code)
        if selection == "user"
            print code
            print "no work"
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
                @breaker.play("computer")
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