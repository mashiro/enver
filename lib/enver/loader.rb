require 'ostruct'

module Enver
  class Loader
    attr_reader :store

    def initialize(env, &block)
      @env = env
      @store = OpenStruct.new
      instance_eval(&block) if block
    end

    def value(name, env_name, options = {})
      value = fetch env_name, options
      @store.send("#{name}=", value.is_a?(String) ? yield(value) : value)
    end

    def string(name, env_name, options = {})
      value(name, env_name, options) do |v|
        v
      end
    end

    def integer(name, env_name, options = {})
      value(name, env_name, options) do |v|
        Integer(v)
      end
    end

    def float(name, env_name, options = {})
      value(name, env_name, options) do |v|
        Float(v)
      end
    end

    def boolean(name, env_name, options = {})
      value(name, env_name, options) do |v|
        true_values = options[:true_values] || %w(1 t true y yes)
        true_values.include?(v)
      end
    end

    def array(name, env_name, options = {})
      value(name, env_name, options) do |v|
        pattern = options[:pattern] || ','
        limit = options[:limit] || 0
        v.split(pattern, limit)
      end
    end

    private

    def fetch(env_name, options = {})
      if options.has_key? :default
        @env.fetch(env_name, options[:default])
      else
        @env.fetch(env_name)
      end
    end
  end
end
