require_relative '../test_helper'

module Generator
  FixturePaths = Paths.new(
    metadata: 'test/fixtures/metadata',
    track: 'test/fixtures/xruby'
  )

  class RepositoryTest < Minitest::Test
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

    def test_test_case_filename
      subject = ExerciseRepository.new(paths: FixturePaths, slug: 'some-slug')
      expected = 'test/fixtures/xruby/exercises/some-slug/.meta/generator/some_slug_case.rb'
      assert_equal expected, subject.expected_test_case_filename
    end
  end
end
