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
        puts "- Log Out"
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
        puts "Espresso"
        puts "Americano"
        puts "Iced Coffee"
        puts "Iced Tea"
    end

    def sanitize_word(word)
        split_word = word.split(" ")
        cap = split_word.map { |word| word.capitalize }
        cap.join(" ")
    end 

    def buy_coffee(user)
        system("clear")
        puts "What area would you like to buy coffee from?"
        locations = CoffeeShop.all.map do |shop|
            shop.location
        end


        locations.uniq!.each { |location| puts location }
        user_input = sanitize_word(gets.chomp)

        if locations.include?(user_input)
            system("clear")
            puts "Where would you like to buy coffee from?"
            neighborhood_locations =  CoffeeShop.where(location: user_input)
            neighborhood_locations.each do |location|
                puts location.name
            end
            # binding.pry
            loc_name_input = sanitize_word(gets.chomp)
            coffee_shop_obj = CoffeeShop.all.find_by(name: loc_name_input)
            # binding.pry
            system("clear")
            puts "What type of coffee would you like to buy?"
            self.coffee_options
            input = gets.strip

            system("clear")
            puts "Thank you #{user.name} for buying #{self.sanitize_word(input)} from #{loc_name_input}."
            puts "Hey #{user.name}, would you like to make a review? (Yes/No)"
            input = gets.strip.downcase
            
            if input == 'yes'
                self.write_review(coffee_shop_obj ,loc_name_input, user)
            elsif user_input == "no"
                puts "No worries...enjoy your coffee!"
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
            puts " --------------- "
            puts "#{(i += 1)}."
            puts "Coffee Shop: #{review.coffee_shop.name}"
            puts "Rating: #{review.rating}"
            puts "Review: #{review.description}"
            puts " --------------- "
            puts "\n"
        end 
        my_reviews
    end 

    # we should be able to search for a coffee shop by name 
    # and then be able to see all reviews for that coffee shop
    def view_coffee_shop_reviews(coffee_shop)
        i = 0 

        coffee_shop_reviews = coffee_shop.reviews 
        coffee_shop_reviews.each do |review|
            puts " --------------- "
            puts "#{(i += 1)}." 
            puts "Reviewed by: #{review.user.name}"
            puts "#{review.rating}"
            puts "#{review.description}"
            puts " --------------- "
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

    # valid rating is between 1-5
    def check_rating_valid(number)
        n = (1..5).to_a 
        n.include?(number)
    end 

    def write_review(coffee_shop_obj, coffee_shop, user)
        puts "On a scale of 1-5 (with 5 being the highest), what rating would you give #{coffee_shop}?"
        rating_input = gets.chomp.to_i
            until check_rating_valid(rating_input)
                puts "Rating needs to be between 1-5. Please enter a valid rating."
                rating_input = gets.chomp.to_i
            end
        puts "Thanks for rating #{coffee_shop}."
            
        puts "Now let users know why you gave that rating and what you thought about #{coffee_shop}."
        description_input = gets.chomp

        puts "Coffee Run runs on reviews to help users find the best coffee shop. Thanks for contributing to the community!"
        new_review = Review.create(user_id: user.id, coffee_shop_id: coffee_shop_obj.id, description: description_input, rating: rating_input)
    end 

    # a user can only delete reviews belonging to themselves
    def delete_review(user)
        puts "Choose which one of your reviews you want to delete."
        user_reviews = view_my_reviews(user)
        
        selected_review = gets.chomp
        record_id = user_reviews[(selected_review).to_i - 1].id

        Review.find_by(id: record_id).destroy
        
        # puts "Your review for #{coffee_shop.name} has been deleted."
    end 

     def run 
        user = nil

        system("clear")
        self.greeting 

        iteration = nil
        case self.prompt_to_login_or_signup 
        when "Log in"
            iteration = true
            user = self.log_in
        when "Sign up"  
            user = self.sign_up
            iteration = true
        end

        while iteration
            iteration = false

            # system("clear")
            puts "What would you like to do?"
            self.menu
            user_input = gets.chomp.downcase

            case user_input
            when "buy coffee"
                iteration = true
                self.buy_coffee(user)
            when "view my reviews"
                iteration = true
                self.view_my_reviews(user)
            when "edit my reviews"
                iteration = true

            when "delete a review"
                iteration = true
                self.delete_review(user)
            when "log out"
                iteration = false
                system("clear")
            end
        end
    end

end 

