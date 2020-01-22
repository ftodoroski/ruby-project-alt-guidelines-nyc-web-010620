require_relative '../config/environment'

app1 = CliInterface.new

# binding.pry

app1.greeting
app1.prompt_to_login_or_signup
app1.log_in
# app1.sign_up