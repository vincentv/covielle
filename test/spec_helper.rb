require 'rubygems'
require 'bundler'
Bundler.setup

require 'minitest/autorun'
require 'minitest/spec'
require 'minitest/mock'

def expand_path relative_path
  File.expand_path relative_path
end

def fake_git_repository path, remote_path
  FileUtils.mkdir_p path
  Dir.chdir(path) do
    `git init`
    `git config user.email "lol@wut.com"`
    `git config user.name "lolwut"`
    `git remote add origin #{remote_path}`
  end
end
