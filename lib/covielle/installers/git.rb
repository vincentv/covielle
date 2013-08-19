module Covielle
  module Installers
    class Git
      attr_reader :bundle

      def initialize(bundle)
        @bundle = bundle
      end

      def config_dirname
        @config_dirname ||= '.git'
      end

      def cmd_remote_path
       @cmd_remote_path ||= 'git config --get remote.origin.url'
      end

      def cmd_install
        @cmd_install ||= "git clone -q #{@bundle.path}"
      end

      def cmd_update
        @cmd_update ||= 'git pull origin master -q'
      end

      def run
        path = @bundle.local_path
        if path.exist?
          if identical? path
            status = exec path, cmd_update, :updated
          else
            status = :conflict
          end
        else
          status = exec path.parent, cmd_install, :installed
        end

        status
      end

      def identical?(path)

        unless path.join(config_dirname).exist?
          return false
        end

        Dir.chdir path do
          origin_url = `#{cmd_remote_path}`.strip
          origin_url == @bundle.path
        end
      end

      private

      def exec (dest, cmd, success_status)
        Dir.chdir dest do
          cmd += '> /dev/null'
          out = system cmd
          out ? success_status : :failed
        end
      end
    end
  end
end
