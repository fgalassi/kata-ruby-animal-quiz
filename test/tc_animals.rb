require "rubygems"
require "flexmock/test_unit"
require "animalquiz.rb"

class TestAnimalQuiz < Test::Unit::TestCase	
	def setup
		@controller = flexmock("controller")
		@animals = AnimalQuiz.new(@controller)
	end

	def test_acknowledge_win
		@controller.should_receive(:think_animal).once.ordered
		@controller.should_receive(:guess_animal).with(AnimalQuiz::Animal).and_return(true).once.ordered
		@controller.should_receive(:i_win).once.ordered
		@controller.should_receive(:play_again?).and_return(false).once.ordered
		@animals.go
	end

	def test_when_lose_then_improve
		@controller.should_receive(:think_animal).once.ordered
		@controller.should_receive(:guess_animal).with(AnimalQuiz::Animal.new("an elephant")).and_return(false).once.ordered
		@controller.should_receive(:you_win).once.ordered
		@controller.should_receive(:your_animal?).and_return(AnimalQuiz::Animal.new("a rabbit")).once.ordered
		@controller.should_receive(:tell_apart_animals).
			with(AnimalQuiz::Animal.new("a rabbit"), AnimalQuiz::Animal.new("an elephant")).
			and_return(AnimalQuiz::Question.new("is it small")).once.ordered
		@controller.should_receive(:answer_question_for_animal).
			with(AnimalQuiz::Question.new("is it small"), AnimalQuiz::Animal.new("a rabbit")).
			and_return(true).once.ordered
		@controller.should_receive(:thanks).once.ordered
		@controller.should_receive(:play_again?).and_return(true).once.ordered
		@controller.should_receive(:think_animal).once.ordered
		@controller.should_receive(:answer_question).with(AnimalQuiz::Question.new("is it small")).and_return(true).once.ordered
		@controller.should_receive(:guess_animal).with(AnimalQuiz::Animal.new("a rabbit")).and_return(true).once.ordered
		@controller.should_receive(:i_win).once.ordered
		@controller.should_receive(:play_again?).and_return(false).once.ordered
		@animals.go
	end
end
