require_relative 'exercise_testcases'
require_relative 'exercise_testcase'

class IsogramCases < ExerciseTestCases
end

class IsogramCase < ExerciseTestCase
  def workload
    [
      "string = '#{canonical_data.input}'",
      "#{assertion} Isogram.isogram?(string), '#{failure_message}'"
    ]
  end

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
