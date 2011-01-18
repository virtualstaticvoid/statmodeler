require 'statmodeler/parameters'
require 'statmodeler/definition'
require 'statmodeler/import_definition'
require 'statmodeler/operation'
require 'statmodeler/export_definition'

module Statmodeler

  class Model

    attr_reader :name
    attr_reader :options
    attr_reader :parameters
    attr_reader :operations
    attr_reader :data_points_definition

    def initialize(name, options = {}, &block)

      @klass = class << self; self; end

      @name = name
      @options = options
      @parameters = Parameters.new()

      @data_points_definition = Definition.new() {}
      @operations = []

      instance_eval &block

    end

    def define_parameter(name, value = nil)
      @parameters.add_parameter(name, value)
    end

    def define_data_point(name, value = nil, &block)
      @klass.instance_eval do
        if block
          define_method "#{name}" do
            instance_eval &block
          end
        else
          attr_accessor name
        end
      end
      method("#{name}=").call(value) if !block and value
    end

    def define_data_points(&block)
      @data_points_definition = Definition.new(&block)
    end

    def define_filter(name, &block)
      @operations << Operation.new(name) do |observations|
        observations.dup.each do |observation|
          observations.delete observation if observation.instance_eval(&block) == false
        end
      end
    end

    def define_aggregate(name, &block)
      # TODO
    end

    def define_calculation(name, &block)
      @operations << Operation.new(name) do |observations|
        instance_eval &block
      end
    end

    def model
      self
    end

  end

end

