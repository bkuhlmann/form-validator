# frozen_string_literal: true

begin
  require "git/lint/rake/setup"
rescue LoadError => error
  puts error.message
end

task default: %i[git_lint]
