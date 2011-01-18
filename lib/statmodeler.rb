#
# Copyright (c) 2011 Chris Stefano
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#

require 'statmodeler/version'
require 'statmodeler/model'
require 'statmodeler/parameters'
require 'statmodeler/definition'
require 'statmodeler/import_definition'
require 'statmodeler/operation'
require 'statmodeler/export_definition'

module Statmodeler

  def self.define_model(name, options = {}, &block)
    Model.new(name, options, &block)
  end

  def self.run_model(model)

    # load source data (observations)
    observations = []

# BEGIN HACK: test data...
observations << model.data_points_definition.create_observation(model)
observations << model.data_points_definition.create_observation(model)
observations << model.data_points_definition.create_observation(model)
observations << model.data_points_definition.create_observation(model)
observations << model.data_points_definition.create_observation(model)
observations.each do |observation|
  observation.market_value = 1
end
# END HACK: test data...

    # perform processing
    model.operations.each do |operation|

      puts "Executing '#{operation.name}'..."
      operation.block.call(observations)
    end

    # output results
    return observations

  end

end

