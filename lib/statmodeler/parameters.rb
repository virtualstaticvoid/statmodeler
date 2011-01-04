class Statmodeler::Parameters

  def initialize()
    @klass = class << self; self; end
  end

  def add_parameter(name, value = nil)
    @klass.instance_eval do
      attr_accessor name
    end
    method("#{name}=").call(value)
  end

end

