require 'uri'

module Covielle
  class Bundle

    attr_reader :name
    attr_reader :path
    attr_reader :installer
    attr_reader :options

    def initialize (path, options = {})
      @path = path
      @name = parse_name path
      @installer = options.delete(:installer) || :git
      @options = options
    end

    def local_path
      @local_path ||= Covielle.bundles_path.join(@name)
    end

    private

    def parse_name (path)
      uri = URI.parse(path).path
      ext = File.extname uri
      File.basename uri, ext
    end

  end
end
