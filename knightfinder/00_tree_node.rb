class PolyTreeNode
  attr_reader :value, :parent, :children

  def initialize(value = nil)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(parent)
    unless @parent.nil?
      @parent.children.delete(self)
    end
    @parent = parent
    if parent
      @parent.children << self unless @parent.children.include?(self)
    end
  end

  def add_child(node)
    node.parent= self
  end

  def remove_child(node)
    raise "error" unless children.include?(node)
    node.parent= nil
  end

  def dfs(target_value)
    return self if self.value == target_value
    children.each do |child|
      search_result = child.dfs(target_value)
      return search_result if search_result
    end
    nil
  end

  def bfs(target_value)
    queue = [self]
    until queue.empty?
      current_node = queue.shift
      return current_node if current_node.value == target_value
      queue += current_node.children
    end

    nil
  end

end
