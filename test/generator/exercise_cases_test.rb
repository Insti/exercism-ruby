require_relative '../test_helper'

module Generator
  class ExerciseCaseTest < Minitest::Test
    def test_indent_text
      subject = ExerciseCase.new
      input    = "hello\nworld"
      expected = "hello\n    world"
      assert_equal expected, subject.indent_text(4,input)
    end
  end
end
