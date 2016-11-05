require 'simplecov'
SimpleCov.start do
  add_filter "/tests/"
end

require 'minitest/autorun'


$LOAD_PATH.push(File.expand_path('../../lib',__FILE__))

# So we can be sure we have coverage on the whole lib directory:
Dir.glob('lib/*.rb').each {|file| require file.gsub(/(^lib\/|\.rb$)/,'') }
