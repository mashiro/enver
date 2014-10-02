require 'enver/loader'

module Enver
  module Extension
    def load(env = ENV, &block)
      Enver::Loader.new(env) do
        instance_eval &block if block
      end.attributes
    end
  end
end
