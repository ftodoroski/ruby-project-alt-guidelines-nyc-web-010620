class User < ActiveRecord::Base
    has_many :reviews 
    has_many :coffee_shops, through: :reviews

    def write_review(coffee_shop:, description:, rating:) 
        review = Review.create(self.id, coffee_shop: coffee_shop, description: description,rating: rating)
    end
end