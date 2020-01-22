class CliInterface
    def greeting 
        puts "Welcome to Coffee Run"
    end

    def sign_up
        name = nil
        username = nil
        password = nil

        puts "Enter your name:"
        name = gets.chomp        
        puts "Enter a username:"
        username_input = gets.chomp
        exists?(username_input) 
        # call method to check if username exists 
        puts "Enter a password:"
        password = gets.chomp

        User.create(name: name, username: username_input, password: password)
    end
    
    def prompt_to_login_or_signup
        puts "Log in or Sign up"
        gets.chomp 
    end

    def exists?(username_input)
        # validates with database if that username exists or not
        # returns true/false
        if User.all.select{|user| user.username == username_input} == [] 
            return false 
        else
            return true  
        end 
    end 

end