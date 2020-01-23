require_relative '../config/environment'

app1 = CliInterface.new

# binding.pry

app1.run
app1.greeting
# user = app1.log_in
user = app1.log_in
puts "#{user}"
app1.view_my_reviews(user)
# app1.view_coffee_shop_reviews(coffee_shop)