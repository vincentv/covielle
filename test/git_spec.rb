require 'spec_helper'
require 'covielle/installers/git'

describe Covielle::Installers::Git do
  before do
    @tmp_path = expand_path 'tmp'
    FileUtils.mkdir_p @tmp_path
  end

  after do
    FileUtils.remove_entry_secure @tmp_path, true
  end

  describe 'default values' do
    before do
      bundle = MiniTest::Mock.new
      bundle.expect :installer, :git
      bundle.expect :path, 'https://github.com/github/pong.git'
      @installer = Covielle::Installers::Git.new(bundle)
    end

    it 'has a config dir' do
      @installer.config_dirname.must_equal '.git'
    end

    it 'has a cmd for remote path' do
      @installer.cmd_remote_path.must_equal 'git config --get remote.origin.url'
    end

    it 'has a cmd for install' do
      @installer.cmd_install.must_equal 'git clone -q https://github.com/github/pong.git'
    end

    it 'has a cmd for update' do
      @installer.cmd_update.must_equal 'git pull origin master -q'
    end
  end

  describe 'identical?' do
    before do
      @path = Pathname.new @tmp_path.concat('/pong')

      bundle = MiniTest::Mock.new
      bundle.expect :installer, :git
      bundle.expect :path, 'https://github.com/github/pong.git'
      bundle.expect :local_path, @path

      @installer = Covielle::Installers::Git.new(bundle)

    end

    it 'must be identical' do
      fake_git_repository @path.to_s, 'https://github.com/github/pong.git'
      @installer.identical?(@path).must_equal true
    end

    it 'wont be identical' do
      @installer.identical?(@path).must_equal false
    end
  end

  describe 'run' do
    before do
      bundle = Covielle::Bundle.new('https://github.com/github/pong.git', {:installer => 'git'})
      Covielle.stub :bundles_path, Pathname.new(@tmp_path) do
        bundle.local_path
      end

      @path = Pathname.new(@tmp_path).join('pong')
      @installer = Covielle::Installers::Git.new(bundle)
    end

    it 'returns conflict status' do
      fake_git_repository @path.to_s, 'https://github.com/github/ping.git'
      @installer.run.must_equal :conflict
    end

    it 'returns updated status' do
      fake_git_repository @path.to_s, 'https://github.com/github/pong.git'
      @installer.run.must_equal :updated
    end

    it 'returns installed status' do
      @installer.run.must_equal :installed
    end
  end
end
