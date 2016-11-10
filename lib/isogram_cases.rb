require_relative 'exercise_test_cases'
require_relative 'exercise_test_case'

class IsogramCases < ExerciseTestCases; end

class IsogramCase < ExerciseTestCase

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
