require_relative '../test_helper'

module Generator
  class CommandLineTest < Minitest::Test
    FixturePaths = Paths.new(
      metadata: 'test/fixtures/metadata',
      track: 'test/fixtures/xruby'
    )

    def test_parse
      expected_stderr = 'Exercise name required'
      assert_output(/Usage:/, /#{expected_stderr}/) do
        refute CommandLine.new(FixturePaths).parse([])
      end
    end

    def test_invalid_metadata_repository_outputs_message_to_stderr
      paths = Paths.new(metadata: 'test/fixtures/nonexistent', track: '')
      expected_stderr = <<-MESSAGE.gsub(/^ {6}/, '')
      'x-common' repository not found.
      Try running the command:
        git clone https://github.com/exercism/x-common.git "test/fixtures/nonexistent"
      MESSAGE
      assert_output nil, /#{expected_stderr}/ do
        refute CommandLine.new(paths).parse([])
      end
    end

    def test_usage_help
      args = %w(-h)
      assert_output(/Usage:/, nil) do
        refute CommandLine.new(FixturePaths).parse(args)
      end
    end

    def test_usage_help_with_exercise
      args = %w(-h beta)
      assert_output(/Usage:/, nil) do
        refute CommandLine.new(FixturePaths).parse(args)
      end
    end

    def not_a_command_line_test_test_usage_help_includes_available_generators
      args = %w(-h)
      fake_generators = %w(some fake generator names also-hyphen-ated)
      Files::GeneratorCases.stub :available, fake_generators do
        assert_output(/#{fake_generators.sort.join(' ')}/, nil) do
          refute CommandLine.new(FixturePaths).parse(args)
        end
      end
    end

    def test_validate_missing_generator
      args = %w(nonexistent)
      assert_output(nil, /A generator does not currently exist fo/) do
        refute CommandLine.new(FixturePaths).parse(args)
      end
    end

    def test_default_options
      args = %w(beta)
      Files::GeneratorCases.stub :available, %w(beta) do
        assert_instance_of UpdateVersionAndGenerateTests, CommandLine.new(FixturePaths).parse(args).first
      end
    end

    def test_frozen_option
      args = %w(-f beta)
      Files::GeneratorCases.stub :available, %w(beta) do
        assert_instance_of GenerateTests, CommandLine.new(FixturePaths).parse(args).first
      end
    end

    # FIXME: fix this test to use mocks
    def test_all_option
      args = %w(--all)
      fixture_generators = %w(alpha beta)
      generators = CommandLine.new(FixturePaths).parse(args)
      assert_equal fixture_generators.size, generators.size
      assert_instance_of GenerateTests, generators.first
    end

    def test_verbose_option
      args = %w(-v beta)
      assert_instance_of UpdateVersionAndGenerateTests, CommandLine.new(FixturePaths).parse(args).first
    end
  end
end
