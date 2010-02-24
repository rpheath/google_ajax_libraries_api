require 'ostruct'

# Reference: http://code.google.com/apis/ajaxlibs/
module RPH
  module Google
    module AjaxLibraries
      # base path to libraries on Google's servers
      BASE_PATH = 'http://ajax.googleapis.com/ajax/libs'
      
      # unnecessarily complex way to set constants for each
      # of the supported libraries
      %w(jquery jqueryui prototype scriptaculous mootools dojo swfobject yui ext_core chrome_frame).each do |lib|
        const_set lib.upcase.gsub('-', '_'), lib
      end
      
      # used to maintain supported library versions
      SUPPORTED_VERSIONS = {
        JQUERY        => ['1.2.3', '1.2.6', '1.3.0', '1.3.1', '1.3.2', '1.4.0', '1.4.1', '1.4.2'],
        JQUERYUI      => ['1.5.2', '1.5.3', '1.7.0', '1.7.1', '1.7.2'],
        PROTOTYPE     => ['1.6.0.2', '1.6.0.3', '1.6.1.0'],
        SCRIPTACULOUS => ['1.8.1', '1.8.2', '1.8.3'],
        MOOTOOLS      => ['1.11', '1.2.1', '1.2.2', '1.2.3', '1.2.4'],
        DOJO          => ['1.1.1', '1.2.0', '1.2.3', '1.3.0', '1.3.1', '1.3.2', '1.4.0'],
        SWFOBJECT     => ['2.1', '2.2'],
        YUI           => ['2.6.0', '2.7.0', '2.8.0r4'],
        EXT_CORE      => ['3.0.0'],
        CHROME_FRAME  => ['1.0.0', '1.0.1', '1.0.2']
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
        ),
        EXT_CORE => OpenStruct.new(
          :name => EXT_CORE,
          :path => "#{BASE_PATH}/#{EXT_CORE.gsub('_','-')}/VERSION/ext-core.js",
          :pathu => "#{BASE_PATH}/#{EXT_CORE.gsub('_','-')}/VERSION/ext-core-debug.js",
          :versions => SUPPORTED_VERSIONS[EXT_CORE],
          :default_version => SUPPORTED_VERSIONS[EXT_CORE].max
        ),
        CHROME_FRAME => OpenStruct.new(
          :name => CHROME_FRAME,
          :path => "#{BASE_PATH}/#{CHROME_FRAME.gsub('_','-')}/VERSION/CFInstall.min.js",
          :pathu => "#{BASE_PATH}/#{CHROME_FRAME.gsub('_','-')}/VERSION/CFInstall.js",
          :versions => SUPPORTED_VERSIONS[CHROME_FRAME],
          :default_version => SUPPORTED_VERSIONS[CHROME_FRAME].max
        )
      })
    end
  end
end