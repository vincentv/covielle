require 'spec_helper'
require 'covielle/bundles'

describe Covielle::Bundles do
  before do
    Covielle.stub :settings_path, expand_path('test/fixtures/bundlefile') do
      @bundles = Covielle::Bundles::list
    end
  end

  it "provide an array of bundle" do
    @bundles.must_be_instance_of Array

    @bundles.each do |bundle|
      bundle.must_be_instance_of Covielle::Bundle
    end
  end

  describe "first bundle" do
    before do
      @bundle = @bundles.first
    end

    it "use a git installer" do
      Covielle::Bundles::get_installer(@bundles.first).must_be_instance_of Covielle::Installers::Git
    end
  end

  describe "bundles" do
    before do
      @tmp_path = expand_path 'tmp'
      FileUtils.mkdir_p @tmp_path
    end

    after do
      FileUtils.remove_entry_secure @tmp_path, true
    end

    it do
      fake_git_repository @tmp_path + '/pong', 'https://github.com/github/pong.git'
      Covielle.stub :bundles_path, Pathname.new(expand_path('tmp')) do
        Covielle::Bundles::unkown_bundle?(@tmp_path + '/pong').must_equal(true)
      end
    end

    it do
      fake_git_repository @tmp_path + '/example', 'https://github.com/ex/example.git'
      Covielle.stub :bundles_path, Pathname.new(expand_path('tmp')) do
        Covielle::Bundles::unkown_bundle?(@tmp_path + '/example').must_equal(false)
      end
    end

    it  do
      fake_git_repository @tmp_path + '/example', 'https://github.com/github/pong.git'
      Covielle.stub :bundles_path, Pathname.new(expand_path('tmp')) do
        Covielle::Bundles::conflicted_bundle?(@bundles.first).must_equal(true)
      end
    end

    it do
      fake_git_repository @tmp_path + '/example', 'https://github.com/ex/example.git'
      Covielle.stub :bundles_path, Pathname.new(expand_path('tmp')) do
        Covielle::Bundles::conflicted_bundle?(@bundles.first).must_equal(false)
      end
    end
  end
end
