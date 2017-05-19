require 'optparse'

module Generator
  class GeneratorOptparser
    DEFAULT_OPTIONS = {
      freeze: false,
      all: false,
      verbose: false,
      slug: nil
    }.freeze

    attr_reader :options

    def initialize(args, paths, available_generators:)
      @args = args
      @paths = paths
      @available_generators = available_generators
      @options = parse_options
    end

    def options_valid?
      validate_paths && validate_options &&
        (options[:all] || (validate_exercise && validate_cases))
    end

    private

    attr_reader :available_generators

    def parse_options
      @options = DEFAULT_OPTIONS.dup
      option_parser.parse!(@args)
      options.tap { |opts| opts[:slug] = @args.shift unless opts[:all] }
    end

    def option_parser
      @option_parser ||= OptionParser.new do |parser|
        parser.banner = "Usage: #{$PROGRAM_NAME} [options] exercise-generator"
        parser.on('-f', '--freeze', 'Don\'t update test version') { |value| options[:freeze] = value }
        parser.on('-a', '--all', 'Regenerate all available test suites (implies freeze)') do |value|
          options[:all] = value
        end
        parser.on('-h', '--help', 'Displays this help message') { |value| options[:help] = value }
        parser.on('-v', '--verbose', 'Display progress messages') { |value| options[:verbose] = value }
      end
    end

    def usage
      option_parser.help <<
        "\nAvailable exercise generators:\n" <<
        available_generators.sort.join(' ')
    end

    def validate_paths
      return true if File.directory?(@paths.metadata)
      $stderr.puts metadata_repository_missing_message(@paths.metadata)
      false
    end

    def metadata_repository_missing_message(repository)
      <<-EOM.gsub(/^ {6}/, '')

      'x-common' repository not found.
      Try running the command:
        git clone https://github.com/exercism/x-common.git "#{repository}"

      EOM
    end

    def validate_options
      return true unless options[:help]
      $stdout.puts usage
      false
    end

    def validate_exercise
      return true if options[:slug]
      $stderr.puts "Exercise name required!\n"
      $stdout.puts usage
      false
    end

    def validate_cases
      slug = options[:slug]
      return true if available_generators.include?(slug)
      warning = "A generator does not currently exist for #{slug}}!"
      exercise_repository = ExerciseRepository.new(paths: @paths, slug: slug)
      expected_location = "Expecting it to be at: #{exercise_repository.expected_test_case_filename}"
      $stderr.puts [warning, expected_location].join("\n")
      false
    end
  end
end
