require 'http'

SCREEN_SIZE = 50

def header_view
  system 'clear'

  puts "=" * SCREEN_SIZE
  puts "Mini Capstone Runner".center(SCREEN_SIZE)
  puts "=" * SCREEN_SIZE
  puts
end

user_input = ''

while true
  if user_input == '1'
    header_view
    response = HTTP.get("http://localhost:3000/api/products")
    products = response.parse

    products.each do |product|
        puts "ID: #{product['id']}".ljust(7) + "| " + "Name: #{product['name']}".ljust(40) + "| " + "#{product['formatted']['price']}".ljust(8) + (product['is_discounted'] ? " - Discounted" : "")
    end

    puts
    puts "hit enter to return to menu"
    puts
    
    user_input = gets.chomp

  elsif user_input == '2' || user_input == 'create'
    header_view
    puts "Create a new product"
    puts

    client_params = {}

    print "name: "
    client_params[:name] = gets.chomp

    print "price: "
    client_params[:price] = gets.chomp

    print "description: "
    client_params[:description] = gets.chomp

    print "supplier_id: "
    client_params[:supplier_id] = gets.chomp

    client_params.delete_if {|k,v| v == "" }
    response = HTTP.post("http://localhost:3000/api/products", form: client_params)
    product = response.parse

    puts "ID: #{product['id']}"
    puts "Name: #{product['name']}"
    puts
    "description: #{product['description']}".scan(/.{0,#{SCREEN_SIZE}}/).each do |line|
      puts line
    end
    puts
    puts " " * 10 + "=" * (SCREEN_SIZE - 20) + " " * 10
    puts " " * 10 + "price".ljust((SCREEN_SIZE / 2) - 10, "_") + "#{product['formatted']['price']}".rjust((SCREEN_SIZE / 2) - 10, "_")
    puts " " * 10 + "tax".ljust((SCREEN_SIZE / 2) - 10, "_") + "#{product['formatted']['tax']}".rjust((SCREEN_SIZE / 2) - 10, "_")
    puts " " * 10 + "-" * (SCREEN_SIZE - 20) + " " * 10
    puts " " * 10 + "total".ljust((SCREEN_SIZE / 2) - 10, "_") + "#{product['formatted']['total']}".rjust((SCREEN_SIZE / 2) - 10, "_")
    puts " " * 10 + "=" * (SCREEN_SIZE - 20) + " " * 10
    
    puts
    puts "     [menu] return to menu"
    puts "     [create] create another individual product"
    puts "     [q] to quit"
    puts
    
    user_input = gets.chomp

  elsif user_input == '3' || user_input == 'show'
    response = HTTP.get("http://localhost:3000/api/products")
    products = response.parse

    header_view
    products.each do |product|
      puts "   [#{product['id']}] #{product['name']}"
    end
    puts
    print "Pick a product for detailed information: "
    product_id = gets.chomp

    header_view
    response = HTTP.get("http://localhost:3000/api/products/#{product_id}")
    product = response.parse

    puts "ID: #{product['id']}"
    puts "Name: #{product['name']}"
    puts
    "description: #{product['description']}".scan(/.{0,#{SCREEN_SIZE}}/).each do |line|
      puts line
    end
    puts
    puts " " * 10 + "=" * (SCREEN_SIZE - 20) + " " * 10
    puts " " * 10 + "price".ljust((SCREEN_SIZE / 2) - 10, "_") + "#{product['formatted']['price']}".rjust((SCREEN_SIZE / 2) - 10, "_")
    puts " " * 10 + "tax".ljust((SCREEN_SIZE / 2) - 10, "_") + "#{product['formatted']['tax']}".rjust((SCREEN_SIZE / 2) - 10, "_")
    puts " " * 10 + "-" * (SCREEN_SIZE - 20) + " " * 10
    puts " " * 10 + "total".ljust((SCREEN_SIZE / 2) - 10, "_") + "#{product['formatted']['total']}".rjust((SCREEN_SIZE / 2) - 10, "_")
    puts " " * 10 + "=" * (SCREEN_SIZE - 20) + " " * 10
    
    puts
    puts "     [menu] return to menu"
    puts "     [show] look at another individual product"
    puts "     [q] to quit"
    puts
    
    user_input = gets.chomp

  elsif user_input == '4'
    response = HTTP.get("http://localhost:3000/api/products")
    products = response.parse

    header_view
    products.each do |product|
      puts "   [#{product['id']}] #{product['name']}"
    end
    puts
    print "Pick a product to update: "
    product_id = gets.chomp

    header_view
    response = HTTP.get("http://localhost:3000/api/products/#{product_id}")
    product = response.parse

    puts "Update this product"
    puts "note: default values are seen in parenthesis,hit enter to keep default"
    puts

    client_params = {}

    print "name(#{product['name']}): "
    client_params[:name] = gets.chomp

    print "price(#{product['price']}): "
    client_params[:price] = gets.chomp
    puts

    "(#{product['description']})".scan(/.{0,#{SCREEN_SIZE}}/).each do |line|
      puts line
    end
    print "description: "
    client_params[:description] = gets.chomp
    puts

    client_params.delete_if {|k,v| v == ""}
    response = HTTP.patch("http://localhost:3000/api/products/#{product_id}", form: client_params)
    product = response.parse

    puts "ID: #{product['id']}"
    puts "Name: #{product['name']}"
    puts
    "description: #{product['description']}".scan(/.{0,#{SCREEN_SIZE}}/).each do |line|
      puts line
    end
    puts
    puts " " * 10 + "=" * (SCREEN_SIZE - 20) + " " * 10
    puts " " * 10 + "price".ljust((SCREEN_SIZE / 2) - 10, "_") + "#{product['formatted']['price']}".rjust((SCREEN_SIZE / 2) - 10, "_")
    puts " " * 10 + "tax".ljust((SCREEN_SIZE / 2) - 10, "_") + "#{product['formatted']['tax']}".rjust((SCREEN_SIZE / 2) - 10, "_")
    puts " " * 10 + "-" * (SCREEN_SIZE - 20) + " " * 10
    puts " " * 10 + "total".ljust((SCREEN_SIZE / 2) - 10, "_") + "#{product['formatted']['total']}".rjust((SCREEN_SIZE / 2) - 10, "_")
    puts " " * 10 + "=" * (SCREEN_SIZE - 20) + " " * 10
    
    puts
    puts "     [menu] return to menu"
    puts "     [create] create another individual product"
    puts "     [q] to quit"
    puts
    
    user_input = gets.chomp

  elsif user_input == '5'
    response = HTTP.get("http://localhost:3000/api/products")
    products = response.parse

    header_view
    puts
    products.each do |product|
      puts "   [#{product['id']}] #{product['name']}"
    end
    puts
    print "Pick a product to destroy: "
    product_id = gets.chomp

    header_view
    response = HTTP.delete("http://localhost:3000/api/products/#{product_id}")

    puts response.parse['message']

    puts
    puts "     [menu] return to menu"
    puts "     [q] to quit"
    puts
    
    user_input = gets.chomp
  elsif user_input == 'q'
    break
  else
    header_view

    puts "     [1] Products Index"
    puts "     [2] Products Create"
    puts "     [3] Products Show"
    puts "     [4] Products Update"
    puts "     [5] Products Destroy"
    puts "     [q] quit program"
    puts

    print "Pick an option: "
    user_input = gets.chomp
  end
end

header_view
puts "We know that you have a choice in runner script.".center(SCREEN_SIZE)
puts "Thank you for choosing 'Mini Capstone Runner'".center(SCREEN_SIZE)
puts 
puts