require "test/unit"
require "tree"

class TestTree < Test::Unit::TestCase
	def test_root
		root = Object.new
		tree = Tree::Node.new(root)
		assert_same(root, tree.content)
		assert_equal([], tree.children)
		assert_nil(tree.father)
	end

	def test_add_one_child
		root, child = Object.new, Object.new
		tree = Tree::Node.new(root)
		added = tree.add(child)
		assert_equal(1, tree.children.length)
		assert_same(child, tree.children[0].content)
		assert_equal([], tree.children[0].children)
		assert_same(added, tree.children[0])
		assert_same(tree, tree.children[0].father)
	end

	def test_add_two_children
		root, child1, child2 = Object.new, Object.new, Object.new
		tree = Tree::Node.new(root)
		added1 = tree.add(child1)
		added2 = tree.add(child2)
		assert_equal(2, tree.children.length)
		assert_same(child1, tree.children[0].content)
		assert_same(child2, tree.children[1].content)
		assert_equal([], tree.children[0].children)
		assert_equal([], tree.children[1].children)
		assert_same(added1, tree.children[0])
		assert_same(added2, tree.children[1])
		assert_same(tree, tree.children[0].father)
		assert_same(tree, tree.children[1].father)
	end
	
	def test_add_first_child
		root, child1, child2 = Object.new, Object.new, Object.new
		tree = Tree::Node.new(root)
		tree.add(child1)
		added = tree.add_first(child2)
		assert_equal(2, tree.children.length)
		assert_same(child2, tree.children[0].content)
		assert_same(child1, tree.children[1].content)
		assert_equal([], tree.children[0].children)
		assert_equal([], tree.children[1].children)
		assert_same(added, tree.children[0])
		assert_same(tree, tree.children[0].father)
	end


	def test_each
		root, child1, child2, child3 = Object.new, Object.new, Object.new, Object.new
		visited = []
		tree = Tree::Node.new(root)
		nodechild1 = tree.add(child1)
		nodechild1.add(child3)
		tree.add(child2)
		tree.each { |node| visited << node.content }
		assert_equal([root, child1, child3, child2], visited)
	end

	def test_insert_before_target_not_found
		root, node, target = Object.new, Object.new, Object.new
		tree = Tree::Node.new(root)
		assert_raise(RuntimeError) do
			tree.insert_before(node, target)
		end
	end

	def test_insert_before_target_is_root
		root, node = Object.new, Object.new
		tree = Tree::Node.new(root)
		inserted = tree.insert_before(node, root)
		assert_same(node, tree.content)
		assert_nil(tree.father)
		assert_equal(1, tree.children.length)
		assert_same(root, tree.children[0].content)
		assert_equal(0, tree.children[0].children.length)
		assert_same(tree, tree.children[0].father)
		assert_same(inserted, tree)
	end
	
	def test_insert_before_target_is_not_root
		root, child, node = Object.new, Object.new, Object.new
		tree = Tree::Node.new(root)
		tree.add(child)
		inserted = tree.insert_before(node, child)
		assert_equal(1, tree.children.length)
		assert_same(node, tree.children[0].content)
		assert_same(tree, tree.children[0].father)
		assert_equal(1, tree.children[0].children.length)
		assert_same(child, tree.children[0].children[0].content)
		assert_same(tree.children[0], tree.children[0].children[0].father)
		assert_same(inserted, tree.children[0])
	end
end
