require 'constructorio/version'
require 'constructorio/configuration'
require 'constructorio/client'
require 'faraday'

begin
  require 'pry'
rescue LoadError
end

module ConstructorIO
  attr_accessor :configuration

  def self.configuration
    @configuration ||= Configuration.new
  end
end
