require 'xmlrpc/server'
require_relative '../ruby_four/src/rpc_game_server.rb'

# simple: a handler object and a block handler

class MyHandler

  def initialize(t = 0)
    @t = t
    puts 'initialized'
  end

  def sumAndDifference(a, b)
    @t += 1
    puts "#{a}, #{b}, #{@t}"
    result = Hash.new
    result['sum'] = a + b + @t
    result['difference'] = a - b - @t
    result
  end
end

s = XMLRPC::Server.new 8080, 'localhost', 10, $stdout, true, true

s.add_handler('sample', MyHandler.new(2))

s.add_handler('block.test') do |str|
  puts str
  Random.rand 10
end

# complex: a game server for two players is started
game_name = 'testgame'
game_server = RPCGameServer.new
game_server.start_from_config(GameConfig.new(:otto, :human, :human, 'steve', 'john', :easy, 8, 8), game_name)

s.add_handler(game_name, game_server)

trap('INT') { s.shutdown }

s.serve