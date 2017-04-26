module Generator
  # Contains methods accessible to the ERB template
  class TemplateValues
    attr_reader :abbreviated_commit_hash, :version, :test_cases

    def initialize(abbreviated_commit_hash:, version:, test_cases:)
      @abbreviated_commit_hash = abbreviated_commit_hash
      @version = version
      @test_cases = test_cases
    end

    def get_binding
      binding
    end
  end

  module TemplateValuesFactory
    def template_values
      TemplateValues.new(
        abbreviated_commit_hash: canonical_data.abbreviated_commit_hash,
        version: version,
        test_cases: extract
      )
    end

    private

    def extract
      load cases_load_name
      extractor.extract(canonical_data.to_s)
    end

    def extractor
      if Files::GeneratorCases.proc?(exercise_name)
        CaseValues::ProcExtractor.new(
          code_proc: Object.const_get(Files::GeneratorCases.proc_name(exercise_name))
        )
      else
        CaseValues::AutoExtractor.new(
          exercise_name: exercise_name,
          exercise_data: canonical_data.to_s
        )
      end
    end

    def cases_load_name
      Files::GeneratorCases.load_filename(paths.track, exercise_name)
    end
  end
end
