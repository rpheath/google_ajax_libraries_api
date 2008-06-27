require 'rubygems'
require 'action_controller'
require 'action_view'
require File.join(File.dirname(__FILE__), "../lib/google_ajax_libraries_api")

ActionView::Base.class_eval do
  include RPH::Google::AjaxLibraries
end