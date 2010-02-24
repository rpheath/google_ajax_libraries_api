require File.join(File.dirname(__FILE__), 'spec_helper')

describe "RPH::Google::AjaxLibraries" do
  before(:all) do
    @module = RPH::Google::AjaxLibraries
  end
  
  before(:each) do
    @helper = ActionView::Base.new
  end
  
  it "should be mixed into ActionView::Base" do
    ActionView::Base.included_modules.include?(RPH::Google::AjaxLibraries).should be_true
  end
  
  it "should respond to 'google_javascripts()' helper" do
    ActionView::Base.new.should respond_to(:google_javascripts)
  end
  
  it "should have a helper for each library" do
    @module::GOOGLE_LIBRARIES.keys.each do |library|
      ActionView::Base.new.should respond_to("google_#{library.gsub('-', '_')}")
    end
  end
  
  describe "errors" do    
    it "should raise MissingLibrary error if no library is passed" do
      @helper.google_javascripts() rescue @module::MissingLibrary; true
    end
    
    it "should raise MissingLibrary error if only options are passed" do
      @helper.google_javascripts(:version => '1.2.3') rescue @module::MissingLibrary; true
    end
    
    it "should raise InvalidLibrary error if a non-supported library is specified" do
      @helper.google_javascripts(:yui) rescue @module::InvalidLibrary; true
    end
    
    it "should raise InvalidVersion error if a non-supported version is specified" do
      @helper.google_javascripts(:jquery, :version => '0.0.0') rescue @module::InvalidVersion; true
    end
    
    it "should raise InvalidVersion error if a non-supported version is specified" do
      @helper.google_jquery(:version => '0.0.0') rescue @module::InvalidVersion; true
    end
  end
  
  describe "defaults" do
    it "should set a default version" do
      @helper.google_jquery.match(/(\d.\d.\d)/)
      $1.should_not be_nil
    end
    
    it "should set a default version to the highest supported version" do
      expected_max_jquery_version = @module::GOOGLE_LIBRARIES[:jquery].versions.max
      @helper.google_jquery.match(/(\d.\d.\d)/)
      expected_max_jquery_version.should eql($1)
    end
    
    it "should set the default to be compressed version" do
      @helper.google_jquery.include?('jquery.min.js').should be_true
    end
  end
  
  describe "local access" do
    it "should load from the local directory if told to do so" do
      @helper.google_jquery(:local => true).
        should eql("<script src=\"/javascripts/jquery.js\" type=\"text/javascript\"></script>")
        
      @helper.google_prototype(:local => true).
        should eql("<script src=\"/javascripts/prototype.js\" type=\"text/javascript\"></script>")
    end
  end
  
  describe "all supported libraries with default version" do
    it "should map to the jquery google api url" do
      @helper.google_jquery.
        should eql("<script src=\"http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js\" type=\"text/javascript\"></script>")
    end
  
    it "should map to the jquery-ui google api url" do
      @helper.google_jqueryui.
        should eql("<script src=\"http://ajax.googleapis.com/ajax/libs/jqueryui/1.7.2/jquery-ui.min.js\" type=\"text/javascript\"></script>")
    end
  
    it "should map to the prototype google api url" do
      @helper.google_prototype.
        should eql("<script src=\"http://ajax.googleapis.com/ajax/libs/prototype/1.6.1.0/prototype.js\" type=\"text/javascript\"></script>")
    end
  
    it "should map to the scriptaculous google api url" do
      @helper.google_scriptaculous.
        should eql("<script src=\"http://ajax.googleapis.com/ajax/libs/scriptaculous/1.8.3/scriptaculous.js\" type=\"text/javascript\"></script>")
    end
  
    it "should map to the mootools google api url" do
      @helper.google_mootools.
        should eql("<script src=\"http://ajax.googleapis.com/ajax/libs/mootools/1.2.4/mootools-yui-compressed.js\" type=\"text/javascript\"></script>")
    end
  
    it "should map to the dojo google api url" do
      @helper.google_dojo.
        should eql("<script src=\"http://ajax.googleapis.com/ajax/libs/dojo/1.4.0/dojo/dojo.xd.js\" type=\"text/javascript\"></script>")
    end
    
    it "should map to the swfobject google api url" do
      @helper.google_swfobject.
        should eql("<script src=\"http://ajax.googleapis.com/ajax/libs/swfobject/2.2/swfobject.js\" type=\"text/javascript\"></script>")
    end
    
    it "should map to the YUI google api url" do
      @helper.google_yui.
        should eql("<script src=\"http://ajax.googleapis.com/ajax/libs/yui/2.8.0r4/build/yuiloader/yuiloader-min.js\" type=\"text/javascript\"></script>")
    end
    
    it "should map to the ext-core google api url" do
      @helper.google_ext_core.
        should eql("<script src=\"http://ajax.googleapis.com/ajax/libs/ext-core/3.0.0/ext-core.js\" type=\"text/javascript\"></script>")
    end
    
    it "should map to the chrome-frame google api url" do
      @helper.google_chrome_frame.
        should eql("<script src=\"http://ajax.googleapis.com/ajax/libs/chrome-frame/1.0.2/CFInstall.min.js\" type=\"text/javascript\"></script>")
    end
  end
  
  it "should allow library access via symbol or string" do
    libs = @module::GOOGLE_LIBRARIES
    libs[:jquery].should == libs['jquery']
  end
  
  it "should support multiple versions when using 'google_javascripts()' helper" do
    @helper.google_javascripts(:jquery, :version => '1.2.3').
      should eql("<script src=\"http://ajax.googleapis.com/ajax/libs/jquery/1.2.3/jquery.min.js\" type=\"text/javascript\"></script>")
  end
  
  it "should support multiple versions when using 'google_<library>' helper" do
    @helper.google_jquery(:version => '1.2.3').
      should eql("<script src=\"http://ajax.googleapis.com/ajax/libs/jquery/1.2.3/jquery.min.js\" type=\"text/javascript\"></script>")
  end
  
  it "should support uncompressed versions when using 'google_javascripts()' helper" do
    @helper.google_javascripts(:jquery, :uncompressed => true).
      should eql("<script src=\"http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.js\" type=\"text/javascript\"></script>")
  end
  
  it "should support uncompressed versions when using 'google_<library>' helper" do
    @helper.google_jquery(:uncompressed => true).
      should eql("<script src=\"http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.js\" type=\"text/javascript\"></script>")
  end
  
  it "should support multiple versions and uncompressed at once using 'google_javascripts()' helper" do
    @helper.google_javascripts(:jquery, :version => '1.2.3', :uncompressed => true).
      should eql("<script src=\"http://ajax.googleapis.com/ajax/libs/jquery/1.2.3/jquery.js\" type=\"text/javascript\"></script>")
  end
  
  it "should support multiple versions and uncompressed at once using 'google_<library>' helper" do
    @helper.google_jquery(:version => '1.2.3', :uncompressed => true).
      should eql("<script src=\"http://ajax.googleapis.com/ajax/libs/jquery/1.2.3/jquery.js\" type=\"text/javascript\"></script>")
  end
  
  it "should support multiple libraries at once" do
    @helper.google_javascripts(:prototype, :scriptaculous, :jquery).
      should eql(
        "<script src=\"http://ajax.googleapis.com/ajax/libs/prototype/1.6.1.0/prototype.js\" type=\"text/javascript\"></script>\n" +
        "<script src=\"http://ajax.googleapis.com/ajax/libs/scriptaculous/1.8.3/scriptaculous.js\" type=\"text/javascript\"></script>\n" +
        "<script src=\"http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js\" type=\"text/javascript\"></script>"
      )
  end
  
  it "should make the :version option irrelevent when loading multiple libraries at once" do
    @helper.google_javascripts(:prototype, :scriptaculous, :jquery, :version => '1.2.3').
      should eql(
        "<script src=\"http://ajax.googleapis.com/ajax/libs/prototype/1.6.1.0/prototype.js\" type=\"text/javascript\"></script>\n" +
        "<script src=\"http://ajax.googleapis.com/ajax/libs/scriptaculous/1.8.3/scriptaculous.js\" type=\"text/javascript\"></script>\n" +
        "<script src=\"http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js\" type=\"text/javascript\"></script>"
      )
  end
  
  it "should support uncompressed versions of all applicable when loading multiple libraries at once" do
    @helper.google_javascripts(:prototype, :dojo, :jquery, :uncompressed => true).
      should eql(
        "<script src=\"http://ajax.googleapis.com/ajax/libs/prototype/1.6.1.0/prototype.js\" type=\"text/javascript\"></script>\n" + 
        "<script src=\"http://ajax.googleapis.com/ajax/libs/dojo/1.4.0/dojo/dojo.xd.js.uncompressed.js\" type=\"text/javascript\"></script>\n" + 
        "<script src=\"http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.js\" type=\"text/javascript\"></script>"
      )
  end
end