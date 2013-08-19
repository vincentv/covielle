require 'rbconfig'
require 'pathname'
require 'thor'

require 'covielle/installers/git'
require 'covielle/bundle'
require 'covielle/bundles'
require 'covielle/dsl'

module Covielle

  class InvalidOption < StandardError; end

  def self.vim_path
    @vim_path ||= Pathname.new(ENV['HOME']).join('.vim').expand_path
  end

  def self.bundles_path
    @bundles_path ||= Pathname.new(Covielle.vim_path).join('bundle')
  end

  def self.settings_path
    @setting_path ||= Pathname.new(Covielle.vim_path).join('Bundlefile')
  end

end
