%w(constants error).each do |f| 
  require File.join(File.dirname(__FILE__), "google/#{f}")
end

module RPH
  module Google
    module AjaxLibraries
      def self.included(base)
        base.send :include, InstanceMethods
      end
      
      class Api
        def initialize(library, options={})
          raise(MissingLibrary, MissingLibrary.message) if library.blank?
          
          @library = GOOGLE_LIBRARIES[library]
          @options = options
        end
        
        def path
          version = @options[:version] || @library.default_version
          raise(InvalidVersion, InvalidVersion.message) unless @library.versions.include?(version)
          
          (@options[:uncompressed] && !@library.pathu.blank? ? @library.pathu : @library.path).sub(/VERSION/, version)
        end
      end
      
      module InstanceMethods
        def google_js_library_for(*libraries)
          options = libs.last.is_a?(Hash) ? libs.pop : {}
          
          if libraries.size == 1
            return javascript_include_tag(Api.new(libraries.first, options))
          else
            options.delete(:version)
          end
          
          returning [] do |js|
            libraries.each do |lib|
              js << javascript_include_tag(Api.new(lib, options).path)
            end
          end.join("\n")
        end
      end
    end
  end
end