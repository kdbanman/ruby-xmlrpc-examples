require 'xmlrpc/client'

# Simple

# Make an object to represent the XML-RPC server.
server = XMLRPC::Client.new( 'localhost', '/', 8080)

result = server.call('block.test', 'stringy message')

puts "Returned: #{result}"

# Call the remote server and get our result
result = server.call('sample.sumAndDifference', 5, 3)

sum = result['sum']
difference = result['difference']

puts "Sum: #{sum}, Difference: #{difference}"

# Complex

game_name = 'testgame'
# TODO marshallable, require class
game_server = server.proxy(game_name)

puts game_server.place_token(1, 1, :T)