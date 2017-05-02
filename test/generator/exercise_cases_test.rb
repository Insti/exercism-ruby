require_relative '../test_helper'

module Generator
  class ExerciseCaseTest < Minitest::Test
    def test_indent_text
      subject = ExerciseCase.new
      input    = "hello\nworld"
      expected = "hello\n    world"
      assert_equal expected, subject.indent_text(4,input)
    end

    def test_indented_heredoc
      subject = ExerciseCase.new
      input    = %w(hello world)
      expected = "<<-DELIMITER\n    hello\n    world\nDELIMITER"
      assert_equal expected, subject.indented_heredoc(input,'DELIMITER',4)
    end
  end
end
