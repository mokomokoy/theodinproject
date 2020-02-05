class Node
  attr_accessor :data, :left, :right
  def initialize(data = nil, left = nil, right = nil)
    @data = data
    @left = left
    @right = right
  end

  def to_s
    puts "  #{@data}  "
    puts " / \\  "
    puts "#{@left ? @left.data : 'nil'}   #{@right ? @right.data : 'nil'}"
  end
end