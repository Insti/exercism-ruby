require_relative 'test_helper'
require 'exercise_testcase'

class ExerciseTestCaseTest < Minitest::Test
  def test_can_be_created
    subject = ExerciseTestCase.new nil
    assert subject.instance_of? ExerciseTestCase
  end

  def test_render
    subject = ExerciseTestCase.new nil
    expected = "  def test_\n    skip\n  end\n"
    assert_equal expected, subject.render
  end

  def dont_test_can_get_data
    data = { 'key' => 'value' }
    expected = OpenStruct.new(data)
    subject = ExerciseTestCase.new(data)
    assert_equal expected, subject.canonical_data
  end

  def dont_test_test_name_from_description
    data = { 'description' => 'from_description' }
    subject = ExerciseTestCase.new(data)
    assert_equal 'test_from_description', subject.test_name
  end

  def dont_test_test_name_from_description_replaces_spaces
    data = { 'description' => 'from description with spaces' }
    subject = ExerciseTestCase.new(data)
    assert_equal 'test_from_description_with_spaces', subject.test_name
  end

  def dont_test_test_name_from_description_replaces_hyphens
    data = { 'description' => 'from-description-with-hyphens' }
    subject = ExerciseTestCase.new(data)
    assert_equal 'test_from_description_with_hyphens', subject.test_name
  end


end
