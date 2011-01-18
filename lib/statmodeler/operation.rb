class Statmodeler::Operation

  attr_reader :name
  attr_reader :block

  def initialize(name, &block)

    if block.arity != 1
      # requires 1 parameter

    end

    @name = name
    @block = block
  end

end

