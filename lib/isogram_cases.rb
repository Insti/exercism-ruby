require_relative 'testcase'

class IsogramCases < TestCases
end

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

