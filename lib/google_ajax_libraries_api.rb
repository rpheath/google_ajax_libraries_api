%w(constants error).each do |f| 
  require File.join(File.dirname(__FILE__), "google_ajax_libraries_api/#{f}")
end

# Implements Google Ajax Libraries API as a Rails plugin
# (http://code.google.com/apis/ajaxlibs/)
module RPH
  module Google
    module AjaxLibraries
      def self.included(base)
        base.send :include, InstanceMethods
      end
      
      class Library
        def initialize(library, options={})
          raise(MissingLibrary, MissingLibrary.message) if library.blank?
          raise(InvalidLibrary, InvalidLibrary.message) unless GOOGLE_LIBRARIES.symbolize_keys.keys.include?(library.to_sym)
          
          # load the OpenStruct representation
          # of the desired js library
          @library = GOOGLE_LIBRARIES[library]
          
          # get the options
          # - :version => '0.0.0'
          # - :uncompressed => true
          @options = options
        end
        
        # returns the appropriate path based on version and
        # the uncompressed flag
        #
        # Default: highest supported version and compressed
        def path
          version = @options[:version] || @library.default_version
          raise(InvalidVersion, InvalidVersion.message) unless @library.versions.include?(version)
          
          (@options[:uncompressed] && !@library.pathu.blank? ? @library.pathu : @library.path).sub(/VERSION/, version)
        end
      end
      
      module InstanceMethods
        # Example(s):
        #   <%= google_javascripts :jquery -%>
        #   <%= google_javascripts :jquery, :version => '1.2.3' -%>
        #   <%= google_javascripts :jquery, :uncompressed => true -%>
        #
        # If you want to pass multiple libraries at once, use this helper:
        #   <%= google_javascripts :prototype, :scriptaculous, :jquery -%>
        #
        # Note: when passing multiple libraries, the :version option becomes
        # irrelevant, as it'd be too difficult to know which library the 
        # specified version was intended for. The :uncompressed option still
        # works, however, it will load the uncompressed versions of all the
        # libraries that support it.
        def google_javascripts(*libraries)
          raise(MissingLibrary, MissingLibrary.message) if libraries.blank? || libraries.first.is_a?(Hash)
          options = libraries.last.is_a?(Hash) ? libraries.pop : {}
          
          # if only a single library is passed in, avoid the overhead of
          # 'returning'; otherwise, if multiple libraries are passed in, 
          # delete the :version option from the options hash, as it plays
          # no role for multiple libraries.
          if libraries.size == 1
            return javascript_include_tag(Library.new(libraries.first, options).path)
          else
            options.delete(:version)
          end
          
          returning [] do |js|
            libraries.each do |lib|
              js << javascript_include_tag(Library.new(lib, options).path)
            end
          end.join("\n")
        end
        
        # generate convenience helpers for each library based on
        # the GOOGLE_LIBRARIES hash.
        #
        # Example(s):
        #   <%= google_jquery -%>
        #   <%= google_dojo :version => '1.1.2' -%>
        #   <%= google_mootools :uncompressed => true -%>
        #
        # Default: highest supported version and compressed
        GOOGLE_LIBRARIES.keys.each do |lib|
          eval <<-METHOD
            def google_#{lib.to_s}(options={})
              library = options.delete(:local) ? '#{lib.to_s}' : Library.new(:#{lib.to_s}, options).path
              javascript_include_tag(library)
            end
          METHOD
        end
      end
    end
  end
end