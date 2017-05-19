module Generator
  class Repository
    attr_reader :paths
    def initialize(paths:)
      @paths = paths
    end

    def track_problems
      Dir.glob(File.join(paths.track, 'exercises', '*')).map do |path|
        File.basename(path)
      end
    end

    def exercises_with_generator
      exercise_repostories.select(&:has_generator?).map(&:slug)
    end

    def exercise_repostory(slug)
      ExerciseRepository.new(paths: paths, slug: slug)
    end

    private

    def exercise_repostories
      track_problems.map do |slug|
        exercise_repostory(slug)
      end
    end
  end

  class ExerciseRepository
    include Files::TrackFiles
    include Files::MetadataFiles

    attr_reader :paths, :slug
    def initialize(paths:, slug:)
      @paths = paths
      @slug = slug
    end

    def has_generator?
      test_case.exist?
    end
  end
end
