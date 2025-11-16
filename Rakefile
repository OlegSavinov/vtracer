# frozen_string_literal: true

require "bundler/gem_tasks"
require "rubocop/rake_task"

RuboCop::RakeTask.new

require "rb_sys/extensiontask"

task build: :compile

GEMSPEC = Gem::Specification.load("vtracer.gemspec")

RbSys::ExtensionTask.new("vtracer", GEMSPEC) do |ext|
  ext.lib_dir = "lib/vtracer"
end

task default: %i[compile rubocop]
