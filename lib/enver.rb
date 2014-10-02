require 'enver/version'
require 'enver/extension'

module Enver
  class << self
    include Enver::Extension
  end
end
