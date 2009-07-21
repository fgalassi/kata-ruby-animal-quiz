#!/usr/bin/env ruby
#
$LOAD_PATH << File.join(File.dirname(__FILE__), "lib")

require "animalquiz.rb"
require "console_controller.rb"

controller = AnimalQuiz::ConsoleController.new
quiz = AnimalQuiz.new(controller)
quiz.go
