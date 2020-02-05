class LinkedList
  def initialize
    @list = []
  end

  def append(value)
    node = Node.new(value)
    if @list.length > 0
      @list[-1].next_node = node
    end
    @list.push(node)
  end

  def prepend(value)
    node = Node.new(value)
    if @list.length > 0
      node.next_node = @list[0]
    end
    @list.unshift(node)
  end

  def head
    @list.first
  end

  def tail
    @list.last
  end

  def at(index)
    @list[index]
  end

  def pop
    @list[-2].next_node = nil
    @list.pop
  end

  def contains?(value)
    !!find(value)
  end

  def find(value)
    @list.find { |item| item.value == value }
  end

  def to_s
    string = ''
    @list.each do |node|
      string += "(#{node.value} | #{node.next_node ? node.next_node.value : 'nil'}) #{@list.last == node ? '-> nil' : '-> '}"
      end
    puts string
  end
end

class Node
  attr_accessor :value, :next_node
  def initialize(value = nil, next_node = nil)
    @value = value
    @next_node = next_node
  end
end

list = LinkedList.new
list.append("One")
list.append("Two")
list.prepend("Zero")

puts list.contains?('One')
puts list.find('One')
puts list.pop

list.to_s