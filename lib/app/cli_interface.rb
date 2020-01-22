require "pry"

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
            puts "Welcome back, #{user.name}! Let's get you some coffee!"
            return
        else 
            puts "Password does not match what we have. Please try again."
            new_password = gets.chomp
            password_logic(user, new_password)
        end
    end 

    def log_in
        user = nil 
        puts "Welcome back. Please enter your username."
        username = gets.chomp 
        if User.exists?(username: username)
            puts "Please enter your password."
            password = gets.chomp 

            user = User.find_by(username: username)

            password_logic(user, password)  
        end 
        if !User.exists?(username: username)
            puts "Username does not exist. Please sign up for an account."
            sign_up 
        end 
        return user
    end 

    def view_my_reviews(user)
        i = 0

        my_reviews = user.reviews 
        my_reviews.each do |review|
            puts "#{(i += 1)}."
            puts "Coffee Shop: #{review.coffee_shop.name}"
            puts "Rating: #{review.rating}"
            puts "Review: #{review.description}"
            puts "\n"
        end 
    end 

end 