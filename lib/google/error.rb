module RPH
  module Google
    module AjaxLibraries
      class Error < RuntimeError
        def self.message(msg=nil); msg.nil? ? @message : self.message = msg; end
        def self.message=(msg); @message = msg; end
      end
      
      class InvalidVersion < Error
        message "sorry, that version is not supported"; end
      
      class MissingLibrary < Error
        message "you must specify which library you want to load"; end
    end
  end
end