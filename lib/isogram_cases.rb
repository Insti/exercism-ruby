require_relative 'testcase'

class IsogramCase < TestCase
  def workload
    [
      "string = '#{canonical_data.input}'",
      "#{assertion} Isogram.is_isogram?(string)"
    ]
  end

  def assertion
    canonical_data.expected ? 'assert' : 'refute'
  end
end

IsogramCases = proc do |data|
  JSON.parse(data)['cases'].map do |test_case|
    IsogramCase.new(test_case)
  end
end
