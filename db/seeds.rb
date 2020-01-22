CoffeeShop.destroy_all
User.destroy_all
Review.destroy_all

balancero = CoffeeShop.create(name: "Balancero", location: "Astoria")
blue_stone = CoffeeShop.create(name: "Blue Stone", location: "Financial Distict")
tobys_estate = CoffeeShop.create(name: "Toby's Estate", location: "Williamsburg")
ceremonia = CoffeeShop.create(name: "Ceremonia", location: "Williamsburg")
birch = CoffeeShop.create(name: "Birch", location: "Murray Hill")
sant_am = CoffeeShop.create(name: "Sant Ambroeus", location: "Soho")
la_colombe = CoffeeShop.create(name: "La Colombe", location: "Financial Distict")
cha_cha_matcha = CoffeeShop.create(name: "Cha Cha Matcha", location: "Soho")
ground_support = CoffeeShop.create(name: "Ground Support Cafe", location: "Soho")
blue_bottle = CoffeeShop.create(name: "Blue Bottle", location: "Meat Packing District")
oslo_coffee = CoffeeShop.create(name: "Oslo Coffee Roaster", location: "Williamsburg")
burley_coffee = CoffeeShop.create(name: "Burley Coffee", location: "Williamsburg")
maman = CoffeeShop.create(name: "Maman", location: "Meat Packing District")

cindy = User.create(name: "Cindy", username: "cindykei", password: "hello")
filip = User.create(name: "Filip", username: "ftodoroski", password: "password")
alex = User.create(name: "Alex", username: "alex123", password: "byebye")
shalva = User.create(name: "Shalva", username: "shalva", password: "shalva")
miles = User.create(name: "Miles", username: "miles2go", password: "coffee")
mari = User.create(name: "Mari", username: "marimari", password: "lilo")

review1 = Review.create(user_id: cindy.id, coffee_shop_id: birch.id, description: "The best coffee shop in NYC!", rating: 5)
review2 = Review.create(user_id: mari.id, coffee_shop_id: blue_bottle.id, description: "My favorite place.", rating: 4)
review3 = Review.create(user_id: filip.id, coffee_shop_id: tobys_estate.id, description: "I love Williamsburg and I love coffee.", rating: 5)
review4 = Review.create(user_id: alex.id, coffee_shop_id: tobys_estate.id, description: "I hate coffee!", rating: 2)
review5 = Review.create(user_id: filip.id, coffee_shop_id: la_colombe.id, description: "Pretty decent coffee. Convenient location.", rating: 4)