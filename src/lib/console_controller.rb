class AnimalQuiz::ConsoleController
	private 
	def ask(question)
		puts question
		gets.chomp
	end

	def ask_yes_no(question)
		answer = ask("#{question} (y or n)") while (answer != "y" and answer != "n")
		case answer
			when "y" then true
			when "n" then false
		end
	end

	public
	def think_animal
		puts("Think of an animal...")
	end

	def guess_animal(animal)
		ask_yes_no("Is it #{animal.name}?")
	end

	def you_win
		puts "You win. Help me learn from my mistakes before you go..."
	end

	def i_win
		puts "I win. Pretty smart, aren't I?"
	end

	def your_animal?
		animal = ask("What animal were you thinking of?")
		AnimalQuiz::Animal.new(animal)
	end

	def tell_apart_animals(animal1, animal2)
		question = ask("Give me a question to distinguish #{animal1.name} from #{animal2.name}.")
		AnimalQuiz::Question.new(question)
	end

	def answer_question_for_animal(question, animal)
		ask_yes_no("For #{animal.name}, what is the answer to your question?")
	end

	def answer_question(question)
		ask_yes_no(question.question)
	end

	def thanks
		puts "Thanks."
	end

	def play_again?
		ask_yes_no("Play again?")
	end
end
