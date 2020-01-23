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

    def menu
        puts "- Buy Coffee"
        puts "- View My Reviews"
        puts "- Edit My Reviews"
        puts "- Delete a Review"
        puts "- Log out"
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

    def coffee_options
        puts "Cappuccino"
        puts "Macchiato"
        puts "Expresso"
        puts "Americano"
        puts "Iced Coffee"
        puts "Iced Tea "
    end

    def buy_coffee(user)
        system("clear")
        puts "Where area would you like to buy coffee from?"
        locations = CoffeeShop.all.map do |shop|
            shop.location
        end


        locations.uniq!.each { |location| puts location }
        user_input = gets.chomp

        if locations.include?(user_input)
            system("clear")
            puts "Where would you like to buy coffee from?"
            neighborhood_locations =  CoffeeShop.where(location: user_input)
            neighborhood_locations.each do |location|
                puts location.name
            end

            input = gets.chomp

            system("clear")
            puts "What type of coffee would you like to buy?"
            self.coffee_options
            input = gets.chomp

            puts "Thank you #{user.name} for buying #{input.capitalize}"
            puts "Hey #{user.name}, would you like to make a review?(yes/no)"
            inpute = gets.chomp
            
        end

        # name = gets.chomp
    end

    def run 
        user = nil

        system("clear")
        self.greeting 

        iteration = nil
        case self.prompt_to_login_or_signup 
        when "Log in"
            # self.log_in
            iteration = true
            # user = self.log_in
        when "Sign up"  
            # self.sign_up
            user = self.sign_up
            iteration = true
        end

        while iteration
            iteration = false

            system("clear")
            puts "What would you like to do?"
            self.menu
            user_input = gets.chomp.downcase

            case user_input
            when "buy coffee"
                iteration = true
                self.buy_coffee(user)
            when "view my reviews"
                iteration = true

            when "edit my reviews"
                iteration = true

            when "delete a review"
                iteration = true

            when "log out"
                iteration = false
                system("clear")
            end
        end
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

    # we should be able to search for a coffee shop by name 
    # and then be able to see all reviews for that coffee shop
    def view_coffee_shop_reviews(coffee_shop)
        i = 0 

        coffee_shop_reviews = coffee_shop.reviews 
        coffee_shop_reviews.each do |review|
            puts "#{(i += 1)}." 
            puts "Reviewed by: #{review.user.name}"
            puts "#{review.rating}"
            puts "#{review.description}"
            puts "\n"
        end 
    end 

    # we should be able to see the average rating that a coffee shop has 
    def average_rating(coffee_shop)
        # run through all reviews and select all the reviews with the coffee_shop_id 
        # that matches the id that belongs to the coffee shop passed in
        # then, take the sum of the ratings from that set of reviews and divide by the 
        # number of reviews to find the average 
    end 

end 
