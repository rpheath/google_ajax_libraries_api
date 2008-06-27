require 'ostruct'

# Reference: http://code.google.com/apis/ajaxlibs/
module RPH
  module Google
    module AjaxLibraries
      # base path to libraries on Google's servers
      BASE_PATH = 'http://ajax.googleapis.com/ajax/libs'
      
      # unnecessarily complex way to set constants for each
      # of the supported libraries
      %w(jquery prototype scriptaculous mootools dojo).each do |lib|
        const_set lib.upcase, lib
      end      
      
      # update this hash constant when new libraries are
      # added or new versions are supported
      GOOGLE_LIBRARIES = {
        JQUERY => OpenStruct.new(
          :name => JQUERY, 
          :path => "#{BASE_PATH}/#{JQUERY}/VERSION/jquery.min.js",
          :pathu => "#{BASE_PATH}/#{JQUERY}/VERSION/jquery.js",
          :versions => ['1.2.3', '1.2.6'],
          :default_version => '1.2.6'
        ),
        PROTOTYPE => OpenStruct.new(
          :name => PROTOTYPE, 
          :path => "#{BASE_PATH}/#{PROTOTYPE}/VERSION/prototype.js",
          :pathu => '',
          :versions => ['1.6.0.2'],
          :default_version => '1.6.0.2'
        ),
        SCRIPTACULOUS => OpenStruct.new(
          :name => SCRIPTACULOUS, 
          :path => "#{BASE_PATH}/#{SCRIPTACULOUS}/VERSION/scriptaculous.js",
          :pathu => '',
          :versions => ['1.8.1'],
          :default_version => '1.8.1'
        ),
        MOOTOOLS => OpenStruct.new(
          :name => MOOTOOLS, 
          :path => "#{BASE_PATH}/#{MOOTOOLS}/VERSION/mootools-yui-compressed.js",
          :pathu => "#{BASE_PATH}/#{MOOTOOLS}/VERSION/mootools.js",
          :vesions => ['1.11'],
          :default_version => '1.11'
        ),
        DOJO => OpenStruct.new(
          :name => DOJO, 
          :path => "#{BASE_PATH}/#{DOJO}/VERSION/dojo/dojo.xd.js",
          :pathu => "#{BASE_PATH}/#{DOJO}/VERSION/dojo/dojo.xd.js.uncompressed.js",
          :versions => ['1.1.1'],
          :default_version => '1.1.1'
        )
      }
      
      # fix so that GOOGLE_LIBRARIES[:jquery] == GOOGLE_LIBRARIES['jquery']
      GOOGLE_LIBRARIES = HashWithIndifferentAccess.new(GOOGLE_LIBRARIES)
    end
  end
end