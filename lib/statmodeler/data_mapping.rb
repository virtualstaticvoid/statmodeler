require 'csv'

class Statmodeler::DataMapping

  attr_reader :name
  attr_reader :type
  attr_reader :options
  attr_reader :columns

  def initialize(name, type, options = {}, &block)

    @name = name
    @type = type
    @options = options
    @columns = []

    instance_eval &block

  end

  def file_name(name)
    @file_name = name
  end

  def set_options(options = {})
    @options.merge!(options)
  end

  def mapping(&block)
    instance_eval &block
  end

  def define_column(name, source)
    @columns << ColumnMapping.new(name, source)
  end

  def load_observations(model)

    # get model data points definition, so we can create instances of the data point
    data_points_definition = model.data_points_definition
    observations = []

    CSV.foreach(@file_name, @options) do |row|

      observation = data_points_definition.create_observation(model)

      # using mapping, load respective attributes
      @columns.each do |col|
        observation.set_value(col.name, row[col.source])
      end

      observations << observation

    end

    return observations

  end

  class ColumnMapping

    attr_reader :name
    attr_reader :source

    def initialize(name, source)
      @name = name
      @source = source
    end

  end

end

