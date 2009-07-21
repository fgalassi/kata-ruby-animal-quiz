require "tree.rb"

class AnimalQuiz
	def initialize(controller)
		@controller = controller
		@decisions = Tree::Node.new(AnimalQuiz::Animal.new("an elephant"))
	end

	def go
		@controller.think_animal
		process_decision_node(@decisions)
	end
	
	private
	def process_decision_node(node)
		case node.content
			when AnimalQuiz::Animal
				guess_animal = node.content.clone
				if @controller.guess_animal(guess_animal)
					@controller.i_win
				else
					@controller.you_win
					correct_animal = @controller.your_animal?
					tell_apart_question = @controller.tell_apart_animals(correct_animal, guess_animal)
					tell_apart_answer = @controller.answer_question_for_animal(tell_apart_question, correct_animal)
					inserted = @decisions.insert_before(tell_apart_question, node.content)
					if tell_apart_answer
						inserted.add_first(correct_animal)
					else
						inserted.add(correct_animal)
					end
					@controller.thanks
				end
				if @controller.play_again?
					go
				end
			when AnimalQuiz::Question
				question = node.content.clone
				answer = @controller.answer_question(question)
				left_children, right_children = node.children[0], node.children[1]
				if answer
					process_decision_node(left_children)
				else
					process_decision_node(right_children)
				end
		end
	end
end

class AnimalQuiz::Animal
	attr_reader :name

	def initialize(name)
		@name = name
	end

	def ==(animal)
		animal.respond_to? :name and @name == animal.name
	end
end

class AnimalQuiz::Question
	attr_reader :question
	
	def initialize(question)
		@question = question
	end

	def ==(question)
		question.respond_to? :question and @question == question.question
	end
end

