require 'spec_helper'
require 'covielle'

describe Covielle do

  it do
    Covielle.vim_path.to_s.must_equal expand_path('~/.vim')
    Covielle.bundles_path.to_s.must_equal expand_path('~/.vim/bundle')
    Covielle.settings_path.to_s.must_equal expand_path('~/.vim/Bundlefile')
  end

end
