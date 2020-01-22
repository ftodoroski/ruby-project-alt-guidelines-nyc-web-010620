require_relative '../config/environment'

app1 = CliInterface.new
# app1.valid?('fefefe')

# binding.pry

puts "hello world"

app1.greeting
app1.sign_up