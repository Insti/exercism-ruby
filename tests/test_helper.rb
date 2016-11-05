require 'simplecov'
SimpleCov.start do
  add_filter "/tests/"
end

require 'minitest/autorun'

$LOAD_PATH.push(File.expand_path('../../lib',__FILE__))
#p $LOAD_PATH
