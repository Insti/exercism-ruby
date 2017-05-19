module Generator
  class Repository
    attr_reader :paths
    def initialize(paths:)
      @paths = paths
    end

    def track_problems
      Dir.glob(File.join(paths.track, 'exercises', '*')).map do |path|
        Pathname.new(path).basename.to_s
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
  end
end
