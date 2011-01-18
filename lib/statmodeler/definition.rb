class Statmodeler::Definition

  def initialize(&block)

    @attributes = {}

    @klass = Object.const_set("Observation#{object_id.to_s}", Class.new)

    @klass.class_eval do

      def initialize(model)
        @model = model
      end

      attr_reader :model

      def parameters
        @model.parameters
      end

    end

    instance_eval &block

  end

  def define_data_point(name, value = nil, &block)

    @attributes[name] = value

    @klass.instance_eval do
      if block
        define_method "#{name}" do
          instance_eval &block
        end
      else
        attr_accessor name
      end
    end

  end

  def create_observation(model)
    instance = @klass.new(model)

    @attributes.each do |name, value|
      instance.method("#{name}=").call(value) if value
    end

    return instance
  end

end

