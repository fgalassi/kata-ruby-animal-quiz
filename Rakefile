require "rake/testtask"

task "default" => [:test]

Rake::TestTask.new("test") do |t|
	t.libs = ["src/lib", "test/lib"]
	t.pattern = ["test/**/tc_*.rb"]
end
