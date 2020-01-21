class User < ActiveRecord::Base
    has_many :reviews 
    has_many :coffee_shops, through: :reviews
end