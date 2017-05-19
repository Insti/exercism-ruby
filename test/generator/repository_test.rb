require_relative '../test_helper'

module Generator
  class ExerciseRepositoryTest < Minitest::Test
    def test_construction
      subject = ExerciseRepository.new(paths: nil, slug: nil)
      assert_instance_of ExerciseRepository, subject
    end
  end
end
