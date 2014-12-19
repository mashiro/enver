require 'ostruct'

module Enver
  class Loader
    attr_reader :attributes

    def initialize(env, prefix = '', &block)
      @env = env
      @prefix = prefix
      @attributes = OpenStruct.new
      instance_eval(&block) if block
    end

    def value(*args)
      options = extract_options! args
      has_default = options.key? :default
      name = args.shift
      env_name = args.shift || name.to_s.upcase

      value = fetch env_name, options
      value = yield value, options if !has_default && block_given?

      store name, value
    end

    def string(*args)
      value(*args) do |v|
        v
      end
    end

    def integer(*args)
      value(*args) do |v|
        Integer(v)
      end
    end

    def float(*args)
      value(*args) do |v|
        Float(v)
      end
    end

    def boolean(*args)
      value(*args) do |v, options|
        true_values = options[:true_values] || %w(1 t true y yes)
        true_values.include?(v)
      end
    end

    def array(*args)
      value(*args) do |v, options|
        pattern = options[:pattern] || ','
        limit = options[:limit] || 0
        v.split(pattern, limit)
      end
    end

    def partial(*args, &block)
      options = extract_options! args
      name = args.shift
      env_prefix = args.shift || "#{name.to_s.upcase}_"
      store name, Loader.new(@env, with_prefix(env_prefix), &block).attributes
    end

    private

    def extract_options!(args)
      args.last.is_a?(::Hash) ? args.pop : {}
    end

    def with_prefix(env_name)
      "#{@prefix}#{env_name}"
    end

    def store(name, value)
      @attributes.send("#{name}=", value)
    end

    def fetch(env_name, options = {})
      env_name = with_prefix(env_name)
      if options.has_key? :default
        @env.fetch(env_name, options[:default])
      else
        @env.fetch(env_name)
      end
    end
  end
end
