require_relative 'testcase'

class IsogramCases < TestCases
end

class IsogramCase < TestCase
  def workload
    [
      "string = '#{canonical_data.input}'",
      "#{assertion} Isogram.isogram?(string), '#{failure_message}'"
    ]
  end

  private

  def failure_message
    "#{canonical_data.input.inspect} #{is_or_isnt} an isogram"
  end

  def is_or_isnt
    canonical_data.expected ? 'is' : 'is NOT'
  end

  def assertion
    canonical_data.expected ? 'assert' : 'refute'
  end
end

