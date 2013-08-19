require 'spec_helper'
require 'covielle/dsl'

describe Covielle::Dsl do
  before do
    @dsl = Covielle::Dsl.new
  end

  describe "syntax errors" do
    it "raise a Covielle::InvalidOption" do
      file = 'test/fixtures/bundlefile_invalid_key'
      assert_raises(Covielle::InvalidOption) {
        @dsl.eval_file file
      }
    end

    it 'must have an installer' do
      file = 'test/fixtures/bundlefile_without_installer'
      assert_raises(Covielle::InvalidOption) {
        @dsl.eval_file file
      }
    end

  end
end
