require 'covielle/bundle'

module Covielle
  class Dsl

    VALID_OPTIONS = [:file, :git, :branch, :tag]
    VALID_INSTALLERS = [:file, :git]

    attr_accessor :bundles

    def initialize
      @bundles = []
    end

    def eval_file (path)
      content = File.open(path, 'rb') { |file| file.read }
      instance_eval content
    end

    def bundle(*args)
      options = args.last.is_a?(Hash) ? args.pop : {}

      check_options options
      check_installers options

      normalize_options options

      bdl = Covielle::Bundle.new(options[:path], options)
      @bundles << bdl
    end

    private

    def check_options (opts)
      invalid_keys = opts.keys - VALID_OPTIONS
      if invalid_keys.any?
        invalid_keys = invalid_keys.map { |key| ':' + key.to_s }.join(', ')
        raise InvalidOption, "Invalid options #{invalid_keys} "
      end
    end

    def check_installers (opts)
      valid_installers = opts.keys & VALID_INSTALLERS
      if valid_installers.empty?
        raise InvalidOption, 'No valid source specified'
      end
    end

    def normalize_options (opts)
      installer = (opts.keys & VALID_INSTALLERS).first

      path = opts.delete installer
      opts[:installer] = installer
      opts[:path] = path
    end

  end
end
