# encoding: UTF-8

require 'thor'

module Covielle
    class Cli < Thor
        include Thor::Actions

        map 'update' => 'install'

        desc 'init', 'Initialise ... '
        def init
          unless Covielle.bundles_path.exist?
            Covielle.bundles_path.mkdir
          end

          unless Covielle.settings_path.exist?
            settings = File.new Covielle.settings_path, 'w'
            settings.puts 'bundle :git => "https://github.com/tpope/vim-pathogen.git"'
          end
        end

        desc 'install', 'Installations des plugins'
        def install
            Covielle::Bundles.list.each do |bundle|
                installer = Covielle::Bundles.get_installer bundle
                status = installer.run
                say_status status, bundle.name
            end
        end

    end
end
