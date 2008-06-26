require 'ostruct'

module RPH
  module Google
    module AjaxLibraries
      BASE_PATH = 'http://ajax.googleapis.com/ajax/libs'
      
      %w(jquery prototype scriptaculous mootools dojo).each do |lib|
        const_set lib.upcase, lib
      end      
      
      # according to: http://code.google.com/apis/ajaxlibs/
      GOOGLE_LIBRARIES = {
        JQUERY => OpenStruct.new(
          :name => JQUERY, 
          :path => "#{BASE_PATH}/jquery/VERSION/jquery.min.js",
          :pathu => "#{BASE_PATH}/jquery/VERSION/jquery.js",
          :versions => ['1.2.3', '1.2.6'],
          :default_version => '1.2.6'
        ),
        PROTOTYPE => OpenStruct.new(
          :name => PROTOTYPE, 
          :path => "#{BASE_PATH}/prototype/VERSION/prototype.js",
          :pathu => '',
          :versions => ['1.6.0.2'],
          :default_version => '1.6.0.2'
        ),
        SCRIPTACULOUS => OpenStruct.new(
          :name => SCRIPTACULOUS, 
          :path => "#{BASE_PATH}/scriptaculous/VERSION/scriptaculous.js",
          :pathu => '',
          :versions => ['1.8.1'],
          :default_version => '1.8.1'
        ),
        MOOTOOLS => OpenStruct.new(
          :name => MOOTOOLS, 
          :path => "#{BASE_PATH}/mootools/VERSION/mootools-yui-compressed.js",
          :pathu => "#{BASE_PATH}/mootools/VERSION/mootools.js",
          :vesions => ['1.11'],
          :default_version => '1.11'
        ),
        DOJO => OpenStruct.new(
          :name => DOJO, 
          :path => "#{BASE_PATH}/dojo/VERSION/dojo/dojo.xd.js",
          :pathu => "#{BASE_PATH}/dojo/VERSION/dojo/dojo.xd.js.uncompressed.js",
          :versions => ['1.1.1'],
          :default_version => '1.1.1'
        )
      }
      
      GOOGLE_LIBRARIES = HashWithIndifferentAccess.new(GOOGLE_LIBRARIES)
    end
  end
end