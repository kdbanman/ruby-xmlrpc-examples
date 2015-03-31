require 'xmlrpc/server'


class MyHandler

  def initialize(t = 0)
    @t = t
  end

  def sumAndDifference(a, b)
    t += 1
    puts "#{a}, #{b}, #{t}"
    { 'sum' => a + b + t, 'difference' => a - b  - t}
  end
end

s = XMLRPC::Server.new 8080, 'localhost', 10, $stdout, true, true

s.add_handler('sample', MyHandler.new)

s.add_handler('block.test') do |str|
  puts str
  Random.rand 10
end

s.serve