require_relative 'node.rb'
require_relative 'tree.rb'

tree = Tree.new(%w{8 6 3 05 2 94 72 4 56 7 9})
# tree = Tree.new([10, 5, 20, 6, 50, 15, 4])
# p tree.find('56')
tree.level_order {|node| node.to_s}
# p tree.level_order(tree.find('56'))
p tree.inorder
p tree.preorder
p tree.postorder