require 'spec_helper'
require 'covielle/bundle'

describe Covielle::Bundle do

  it "provide a valid bundle" do
    bundle = Covielle::Bundle.new('https://github.com/ex/example.git')
    bundle.name.must_equal 'example'
    bundle.installer.must_equal :git
    bundle.path.must_equal 'https://github.com/ex/example.git'
    bundle.local_path.to_s.must_equal expand_path('~/.vim/bundle/example')
  end
end
