require 'rubygems'
require 'active_support'

$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))
  
require 'autumn/context'
require 'autumn/injector'
require 'autumn/bean'

module Autumn
  VERSION = '0.1.0'
end