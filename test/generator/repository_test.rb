require_relative '../test_helper'

module Generator
  class RepositoryTest < Minitest::Test
    FixturePaths = Paths.new(
      metadata: 'test/fixtures/metadata',
      track: 'test/fixtures/xruby'
    )

    def test_track_problems
      subject = Repository.new(paths: FixturePaths)
      expected = ['alpha', 'alpha-beta', 'beta']
      assert_equal expected, subject.track_problems
    end

  end

  class ExerciseRepositoryTest < Minitest::Test
    def test_construction
      subject = ExerciseRepository.new(paths: nil, slug: nil)
      assert_instance_of ExerciseRepository, subject
    end
  end
end
