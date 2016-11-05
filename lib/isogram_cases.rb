require 'ostruct'
require_relative 'testcase'

class IsogramCase < TestCase

  def workload
    [
      format( "string = '%s'", data.input ),
      format( "%s Isogram.is_isogram?(string)", data.expected ? 'assert' : 'refute')
    ]
  end

end

IsogramCases = proc do |data|
  JSON.parse(data)['cases'].map.with_index do |test_case,index| 
    test_case['index'] = index
    IsogramCase.new(test_case)
  end
end
