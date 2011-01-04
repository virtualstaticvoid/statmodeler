require 'statmodeler'

# define a model

model :simple do

  # define input parameters

  parameter :long_positions_only, false

  # specify the data points

  definition do

    data :security
    data :book_value
    data :market_value

    # a calculated data point
    data :unrealized_profit_or_loss do
      @market_value - @book_value
    end

  end

  # filter out data points

  filter "Long positions only" do
    # refer to model parameter
    model.long_positions_only && @market_value > 0
  end

  # output format is defaulted to the data definition above

end

