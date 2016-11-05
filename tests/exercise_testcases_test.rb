require_relative 'test_helper'
require 'exercise_testcases'
require 'exercise_testcase'
require 'json'

class ExerciseTestCasesTest < Minitest::Test
  def test_initialistion
    some_json = JSON.generate(cases: [{ 'description' => 'first' },{ description: 'second' }])
    subject = ExerciseTestCases.new(some_json)
    result = subject.to_a
    assert_equal 2, result.size
    assert_equal ExerciseTestCase, result.first.class
  end
end
