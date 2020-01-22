class CliInterface
    def greeting 
        puts "Welcome to Coffee Run"
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
    
    def prompt_to_login_or_signup
        puts "Log in or Sign up"
        gets.chomp 
    end
end