class CliInterface
    def greeting 
        puts "Welcome to Coffee Run"
    end

    def prompt_to_login_or_signup
        puts "Log in or Sign up"
        input = gets.chomp.capitalize 

        until input == "Log in" || input == "Sign up"
            puts "Please Log in or Sign up"
            input = gets.chomp.capitalize
        end

        input
    end

    # Inside the iteration this menu comes then does case check and does certain things
    def menu
        puts "- Buy Coffee"
        puts "- View My Reviews"
        puts "- Edit My Reviews"
        puts "- Delete a Review"
    end

    def sign_up
        name = nil
        username = nil
        password = nil

        puts "Enter a your name:"
        name = gets.chomp        
        puts "Enter a username:"
        username = gets.chomp
        puts "Enter a password:"
        password = gets.chomp

        User.create(name: name, username: username, password: password)
    end
    

    
end

# Addc system("clear")