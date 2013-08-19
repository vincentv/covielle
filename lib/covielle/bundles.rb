
module Covielle
    class Bundles

        def self.list
            @list ||= begin
              dsl = Covielle::Dsl.new
              dsl.eval_file Covielle.settings_path
              dsl.bundles
            end
        end

        def self.unkown_bundle? (path)
            list.index { |bundle| path.eql? bundle.local_path.to_s }.nil?
        end

        def self.conflicted_bundle? (bundle)
          installer = get_installer bundle
          !installer.identical? bundle.local_path
        end

        def self.get_installer(bundle)
          installer_name = bundle.installer.to_s.capitalize
          installer = Covielle::Installers.const_get(installer_name)
          installer.new(bundle)

          # raise "Unkown installer"
        end

    end
end
