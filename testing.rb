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