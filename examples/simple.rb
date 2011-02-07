$:.unshift('lib')

require 'statmodeler'

#
# This model defines 4 data points, one of which is calculated based on the others
# and provides a filter which excludes observations based on a condition
#

model = Statmodeler.define_model :simple do

  define_parameter :long_positions_only, false

  define_data_points do

    define_data_point :security
    define_data_point :book_value
    define_data_point :market_value

    define_data_point :unrealized_profit_or_loss do
      @market_value - @book_value
    end

  end

  define_filter "Long positions only" do
    !parameters.long_positions_only && @market_value > 0
  end

end

data_mapping = Statmodeler.define_data_mapping 'CSV File', :csv  do

  file_name 'simple.csv'
  set_options :has_header => true,
              :data_starts_on_row => 1
  
  mapping do
    
    define_column :security, 'ticker'
    define_column :book_value, 'bookvalue'
    define_column :market_value, 'currentmarketvalue'
    
  end
  
end 

observations = Statmodeler.run_model(model, data_mapping)

puts observations.inspect

