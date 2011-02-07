class Statmodeler::DataMapping

  attr_reader :name
  attr_reader :type
  attr_reader :options

  def initialize(name, type, options = {}, &block)

    @name = name
    @type = type
    @options = options

    instance_eval &block

  end

  def file_name(name)
    @file_name = name
  end

  def set_options(options = {})
    @options.merge!(options)
  end

  def mapping(&block)
    # TODO
  end

  def define_column(name, source)
    # TODO
  end

  def load_observations(model)

    data_points_definition = model.data_points_definition

    # TODO

    # HACK: load source data (observations)
    observations = []
    observations << data_points_definition.create_observation(model)
    observations << data_points_definition.create_observation(model)
    observations << data_points_definition.create_observation(model)
    observations << data_points_definition.create_observation(model)
    observations << data_points_definition.create_observation(model)
    observations << data_points_definition.create_observation(model)
    observations << data_points_definition.create_observation(model)
    observations << data_points_definition.create_observation(model)
    observations << data_points_definition.create_observation(model)

    observations.each do |observation|
      observation.market_value = 1
    end

    return observations

  end

end

