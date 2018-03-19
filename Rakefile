# frozen_string_literal: true

begin
  require "git/cop/rake/setup"
  require "rubocop/rake_task"

  RuboCop::RakeTask.new
rescue LoadError => error
  puts error.message
end

task default: %i[git_cop rubocop]
