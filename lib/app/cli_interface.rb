require "pry"

class CliInterface
    def initialize(user=nil)
        @user = user
    end

    def greeting 
        puts "
        /$$$$$$   /$$$$$$  /$$$$$$$$ /$$$$$$$$ /$$$$$$$$ /$$$$$$$$       /$$$$$$$  /$$   /$$ /$$   /$$
        /$$__  $$ /$$__  $$| $$_____/| $$_____/| $$_____/| $$_____/      | $$__  $$| $$  | $$| $$$ | $$
       | $$  \\__/| $$  \\ $$| $$      | $$      | $$      | $$            | $$  \\ $$| $$  | $$| $$$$| $$
       | $$      | $$  | $$| $$$$$   | $$$$$   | $$$$$   | $$$$$         | $$$$$$$/| $$  | $$| $$ $$ $$
       | $$      | $$  | $$| $$__/   | $$__/   | $$__/   | $$__/         | $$__  $$| $$  | $$| $$  $$$$
       | $$    $$| $$  | $$| $$      | $$      | $$      | $$            | $$  \\ $$| $$  | $$| $$\\  $$$
       |  $$$$$$/|  $$$$$$/| $$      | $$      | $$$$$$$$| $$$$$$$$      | $$  | $$|  $$$$$$/| $$ \\  $$
        \\______/  \\______/ |__/      |__/      |________/|________/      |__/  |__/ \\______/ |__/  \\__/                                                                                                                                                                                          
        "                                                                         
        
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
        puts "- Update Password"
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

        @user = User.create(name: name, username: username, password: password)
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

    def buy_coffee
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
            
            loc_name_input = sanitize_word(gets.chomp)
            coffee_shop_obj = CoffeeShop.all.find_by(name: loc_name_input)
            
            system("clear")
            puts "What type of coffee would you like to buy?"
            self.coffee_options
            input = gets.strip

            system("clear")
            puts "Thank you #{@user.name} for buying #{self.sanitize_word(input)} from #{loc_name_input}."
            puts "Hey #{@user.name}, would you like to make a review? (Yes/No)"
            input = gets.strip.downcase
            
            if input == 'yes'
                self.write_review(coffee_shop_obj ,loc_name_input)
            elsif user_input == "no"
                puts "No worries...enjoy your coffee!"
            end
        end
    end

    def password_logic(password)
        if password == @user.password
            puts "Welcome back, #{@user.name}! Let's get you some coffee!"
            return
        else 
            puts "Password does not match what we have. Please try again."
            new_password = gets.chomp
            password_logic(new_password)
        end
    end 

    def log_in
        puts "Welcome back. Please enter your username."
        username = gets.chomp 
        if User.exists?(username: username)
            @user = User.find_by(username: username)
            puts "Please enter your password."
            password = gets.chomp 

            password_logic(password)  
        end 
        if !User.exists?(username: username)
            puts "Username does not exist. Please sign up for an account."
            sign_up 
        end 
        
        @user
    end 

    def view_my_reviews
        i = 0

        my_reviews = @user.reviews 
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

    def write_review(coffee_shop_obj, coffee_shop)
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
        new_review = Review.create(user_id: @user.id, coffee_shop_id: coffee_shop_obj.id, description: description_input, rating: rating_input)
        @user = User.find(@user.id)
    end 

    # a user can only delete reviews belonging to themselves
    def delete_review
        user_reviews = Review.all.select { |review| review.user_id == @user.id }
        iteration = true
        
        while iteration 
            iteration = false

            puts "Choose which one of your reviews you want to delete."
            user_reviews.each_with_index do |review, index|
                puts " --------------- "
                puts "#{(index += 1)}."
                puts "Coffee Shop: #{review.coffee_shop.name}"
                puts "Rating: #{review.rating}"
                puts "Review: #{review.description}"
                puts " --------------- "
                puts "\n"
            end
            puts "Select a review to delete"
            user_input = gets.chomp.to_i - 1
            review = user_reviews[user_input]
            # binding.pry

            record_id = user_reviews[user_input].id
            # selected_review = gets.chomp
            # record_id = user_reviews[(selected_review).to_i - 1].id

            Review.find_by(id: record_id).destroy
            @user = User.find(@user.id)

            puts "Your review for #{review.coffee_shop.name} has been deleted."
            puts "Would you like to delete another review you made?(yes/no)"
            update_another = gets.chomp.downcase

            if update_another == "yes"
                iteration = true
            elsif update_another == "no"
                iteration = false
            end
        end
    end 

    def check_range_and_number(range, user_input)
        (0..range).to_a.include?(user_input)
    end

    def edit_my_reviews
        user_reviews = Review.all.select { |review| review.user_id == @user.id }

        iteration = true
        while iteration
            iteration = false

            system("clear")
            puts "Which review would you like to update"
            user_reviews.each_with_index do |review, index|
                puts "\n"
                puts "#{index += 1}."
                puts "Coffee Shop: #{review.coffee_shop.name}"
                puts "Your Rating: #{review.rating}"
                puts "Description: #{review.description}"
            end
            
            puts "\n"
            puts "Select a review to updated"
            user_input = gets.chomp.to_i - 1
            review = user_reviews[user_input]

            system("clear")
            puts "Coffee Shop: #{review.coffee_shop.name}"
            puts "Your Rating: #{review.rating}"
            puts "Description: #{review.description}"
            puts "\n"

            puts "New rating of #{review.coffee_shop.name}."
            new_rating = gets.chomp.to_i

            puts "Update your description for #{review.coffee_shop.name}."
            new_description = gets.chomp

            puts "Would you like to update another review you made?(yes/no)"
            update_another = gets.chomp.downcase

            if update_another == "yes"
                iteration = true
            elsif update_another == "no"
                iteration = false
            end
            
            review.update(rating: new_rating, description: new_description)
            @user = User.find(@user.id)
            
        end
    end

    def update_password
        puts "Please enter a new password"
        new_password = gets.chomp.to_s
        @user.update(password: new_password)
        @user = User.find(@user.id)
        puts "Password successfully changed!"
    end 

     def run 
        system("clear")
        self.greeting 

        iteration = nil
        case self.prompt_to_login_or_signup 
        when "Log in"
            iteration = true
            self.log_in
        when "Sign up"  
            self.sign_up
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
                self.buy_coffee
            when "view my reviews"
                iteration = true
                self.view_my_reviews
            when "edit my reviews"
                iteration = true
                self.edit_my_reviews
            when "delete a review"
                iteration = true
                self.delete_review
            when "update password"
                iteration = true
                self.update_password
            when "log out"
                iteration = false
                system("clear")
            end 
        end
    end
end
