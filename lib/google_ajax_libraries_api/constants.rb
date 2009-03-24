require 'ostruct'

# Reference: http://code.google.com/apis/ajaxlibs/
module RPH
  module Google
    module AjaxLibraries
      # base path to libraries on Google's servers
      BASE_PATH = 'http://ajax.googleapis.com/ajax/libs'
      
      # unnecessarily complex way to set constants for each
      # of the supported libraries
      %w(jquery jqueryui prototype scriptaculous mootools dojo swfobject yui).each do |lib|
        const_set lib.upcase, lib
      end
      
      # used to maintain supported library versions
      SUPPORTED_VERSIONS = {
        JQUERY        => ['1.2.3', '1.2.6', '1.3.0', '1.3.1', '1.3.2'],
        JQUERYUI      => ['1.5.2', '1.5.3', '1.7.0', '1.7.1'],
        PROTOTYPE     => ['1.6.0.2', '1.6.0.3'],
        SCRIPTACULOUS => ['1.8.1', '1.8.2'],
        MOOTOOLS      => ['1.11', '1.2.1'],
        DOJO          => ['1.1.1', '1.2.0', '1.2.3'],
        SWFOBJECT     => ['2.1'],
        YUI           => ['2.6.0', '2.7.0']
      }      
      
      # update this hash constant when new libraries are
      # added or new versions are supported
      GOOGLE_LIBRARIES = HashWithIndifferentAccess.new({
        JQUERY => OpenStruct.new(
          :name => JQUERY, 
          :path => "#{BASE_PATH}/#{JQUERY}/VERSION/jquery.min.js",
          :pathu => "#{BASE_PATH}/#{JQUERY}/VERSION/jquery.js",
          :versions => SUPPORTED_VERSIONS[JQUERY],
          :default_version => SUPPORTED_VERSIONS[JQUERY].max
        ),
        JQUERYUI => OpenStruct.new(
          :name => JQUERYUI,
          :path => "#{BASE_PATH}/#{JQUERYUI}/VERSION/jquery-ui.min.js",
          :pathu => "#{BASE_PATH}/#{JQUERYUI}/VERSION/jquery-ui.js",
          :versions => SUPPORTED_VERSIONS[JQUERYUI],
          :default_version => SUPPORTED_VERSIONS[JQUERYUI].max
        ),
        PROTOTYPE => OpenStruct.new(
          :name => PROTOTYPE, 
          :path => "#{BASE_PATH}/#{PROTOTYPE}/VERSION/prototype.js",
          :pathu => '',
          :versions => SUPPORTED_VERSIONS[PROTOTYPE],
          :default_version => SUPPORTED_VERSIONS[PROTOTYPE].max
        ),
        SCRIPTACULOUS => OpenStruct.new(
          :name => SCRIPTACULOUS, 
          :path => "#{BASE_PATH}/#{SCRIPTACULOUS}/VERSION/scriptaculous.js",
          :pathu => '',
          :versions => SUPPORTED_VERSIONS[SCRIPTACULOUS],
          :default_version => SUPPORTED_VERSIONS[SCRIPTACULOUS].max
        ),
        MOOTOOLS => OpenStruct.new(
          :name => MOOTOOLS, 
          :path => "#{BASE_PATH}/#{MOOTOOLS}/VERSION/mootools-yui-compressed.js",
          :pathu => "#{BASE_PATH}/#{MOOTOOLS}/VERSION/mootools.js",
          :versions => SUPPORTED_VERSIONS[MOOTOOLS],
          :default_version => SUPPORTED_VERSIONS[MOOTOOLS].max
        ),
        DOJO => OpenStruct.new(
          :name => DOJO, 
          :path => "#{BASE_PATH}/#{DOJO}/VERSION/dojo/dojo.xd.js",
          :pathu => "#{BASE_PATH}/#{DOJO}/VERSION/dojo/dojo.xd.js.uncompressed.js",
          :versions => SUPPORTED_VERSIONS[DOJO],
          :default_version => SUPPORTED_VERSIONS[DOJO].max
        ),
        SWFOBJECT => OpenStruct.new(
          :name => SWFOBJECT,
          :path => "#{BASE_PATH}/#{SWFOBJECT}/VERSION/swfobject.js",
          :pathu => "#{BASE_PATH}/#{SWFOBJECT}/VERSION/swfobject_src.js",
          :versions => SUPPORTED_VERSIONS[SWFOBJECT],
          :default_version => SUPPORTED_VERSIONS[SWFOBJECT].max
        ),
        YUI => OpenStruct.new(
          :name => YUI,
          :path => "#{BASE_PATH}/#{YUI}/VERSION/build/yuiloader/yuiloader-min.js",
          :pathu => "#{BASE_PATH}/#{YUI}/VERSION/build/yuiloader/yuiloader.js",
          :versions => SUPPORTED_VERSIONS[YUI],
          :default_version => SUPPORTED_VERSIONS[YUI].max
        )
      })
    end
  end
end