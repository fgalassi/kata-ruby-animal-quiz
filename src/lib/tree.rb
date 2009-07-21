module Tree
	class Node
		attr_accessor :content, :children, :father
		protected :content=, :children=, :father=

		include Enumerable

		def initialize(content)
			@content = content
			@children = []
			@father = nil
		end

		def add(content)
			node = Node.new(content)
			node.father = self
			@children << node
			node
		end

		def add_first(content)
			node = Node.new(content)
			node.father = self
			@children.unshift(node)
			node
		end

		def each(&callback)
			walk = lambda do |node|
				yield node
				node.children.each { |child| walk.call(child, &callback) }
			end
			walk.call(self, &callback)
		end

		def insert_before(content, target)
			raise "not found" unless
				target_node = self.find { |node| node.content == target }
			if target_node == self
				new_root = self.clone
				new_root.father = self
				@content = content
				@children = [new_root]
				self
			else
				old_father = target_node.father
				new_father = Node.new(content)
				new_father.father = old_father
				new_father.children = [target_node]
				target_node.father = new_father
				target_node_position = old_father.children.find_index { |node| node == target_node }
				old_father.children[target_node_position] = new_father
				new_father
			end
		end
	end
end
