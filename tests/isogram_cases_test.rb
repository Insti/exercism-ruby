require_relative 'test_helper'
require 'isogram_cases'

class IsogramCaseTest < Minitest::Test
  def test_can_create_a_whole_test
    data = { description: 'isogram is an isogram', input: 'isogram', expected: true }
    subject = IsogramCase.new(data)
    expected = <<EXPECTED.gsub(/^ {4}/,'')
      def test_isogram_is_an_isogram
        skip
        string = 'isogram'
        assert Isogram.isogram?(string), '\"isogram\" is an isogram'
      end
EXPECTED
    assert_equal expected, subject.render
  end
end
