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

        puts "Enter your name:"
        name = gets.chomp 

        puts "Enter a username:"
        username = gets.chomp
        while User.exists?(username: username)
            puts "Username already taken, please choose another one."
            username = gets.chomp
        end
        
        puts "Enter a password:"
        password = gets.chomp

        User.create(name: name, username: username, password: password)
    end

    def password_logic(user, password)
        if password == user.password
            puts "Successfully logged in!"
            #recursive function; will call itself until the base case evaluates as true
            return
        else 
            puts "Password does not match what we have. Please try again."
            new_password = gets.chomp
            password_logic(user, new_password)
        end
    end 

    def log_in
        puts "Welcome back. Please enter your username."
        username = gets.chomp 
        # check against database that that username exists
        if User.exists?(username: username)
            # if it does exist, ask for password
            puts "Please enter your password."
            password = gets.chomp 
            # if the password entered matches the password stored for the existing username, 
            # sign user in 
            user = User.find_by(username: username)

            password_logic(user, password)
            # if password == user.password
            #     puts "Successfully logged in!"
            # else 
            #     puts "Password does not match what we have. Please try again."

            # end 
        end 
        # if username does not exist, prompt user to sign up    
        if !User.exists?(username: username)
            puts "Username does not exist. Please sign up for an account."
            sign_up 
        end 
    end 

def view_my_reviews
    
end 

end 