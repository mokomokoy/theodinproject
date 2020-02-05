
class Tree
  def initialize(array)
    @tree = []
    @root = build_tree(array)
    @array = array
  end

  def build_tree(array)
    return if array.length == 0
    return Node.new(array[0]) if array.length == 1
    array.sort_by!(&:to_i).uniq!
    middle = (array.length/2).floor
    root = array[middle]
    left = build_tree(array[0 ... middle])
    right = build_tree(array[middle+1 .. -1])
    node = Node.new(root, left, right)
    @tree.push(node)
    node
  end

  def insert(value)

  end

  def delete(value)

  end

  def depth(node = @root)
    depth = 0
    left = node.left
    right = node.right
    until left == nil && right == nil
      left = left ? left.left || left.right : nil
      right = right ? right.left || right.right : nil
      depth += 1
    end
    depth
  end

  def balanced?
    left_depth = depth(@root.left)
    right_depth = depth(@root.right)
    p left_depth, right_depth
    left_depth - right_depth < 2 && left_depth - right_depth > -2
  end

  def rebalance!

  end

  def find(value)
    @tree.find do |node|
      node.data == value
    end
  end

  # breadth traversal
  def level_order(node = @root, queue = [], output = [])
    return if node == nil && block_given?
    return output if node == nil && !block_given?

    queue.shift

    if node.left
      queue.push(node.left)
    end
    if node.right
      queue.push(node.right)
    end

    output.push(node.data)
    if block_given?
      yield(node)
      return level_order(queue[0], queue) {|x| yield(x)}
    end
    level_order(queue[0], queue, output)
  end

  # depth traversal
  def inorder(node = @root, order = [])
    leftnodes = leftnodes(node).reverse
    leftnodes.each do |node|
      order.push(node)
      if node.right
        order.concat(leftnodes(node.right).reverse)
        order.push(node.right)
      end
    end
    order.push(node)
    if node.right
      inorder(node.right, order)
    end
    if block_given?
      return order.each { |node| yield(node) }
    end
    order.map { |node| node.data }
  end

  def preorder(node = @root, order = [])
    order.push(node)
    leftnodes = leftnodes(node)
    order.concat(leftnodes)
    leftnodes.each do |node|
      if node.right
        order.push(node.right)
        order.concat(leftnodes(node.right))
      end
    end
    if node.right
      preorder(node.right, order)
    end

    if block_given?
      return order.each { |node| yield(node) }
    end
    order.map { |node| node.data }
  end

  def postorder(node = @root, order = [])
    leftnodes = leftnodes(node).reverse
    leftnodes.each do |node|
      if node.right
        order.concat(leftnodes(node.right).reverse)
        order.push(node.right)
      end
      order.push(node)
    end
    if node.right
      postorder(node.right, order)
    end
    order.push(node)
    order.map { |node| node.data }
  end

  private
  def leftnodes(node)
    leftnodes = []
    search = node
    until search.left == nil
      search = search.left
      leftnodes.push(search)
    end
    leftnodes
  end
end