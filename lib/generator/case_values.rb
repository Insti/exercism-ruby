module Generator
  module CaseValues

    class AutoExtractor
      attr_reader :exercise_name, :exercise_data

      def initialize(exercise_name:, exercise_data:)
        @exercise_name = exercise_name
        @exercise_data = exercise_data
      end

      def extract(_)
        extract_test_cases.map.with_index do |test, index|
          test_case_class.new(test.merge('index' => index))
        end
      end

      private

      def extract_test_cases(data: JSON.parse(exercise_data)['cases'])
        data.flat_map do |entry|
          entry.key?('cases') ? extract_test_cases(data: entry['cases']) : entry
        end
      end

      def test_case_class
        Object.const_get(Files::GeneratorCases.class_name(exercise_name))
      end
    end

    class ProcExtractor

      attr_reader :exercise_data

      def initialize(exercise_data:, code_proc:)
        @exercise_data = exercise_data
        @code_proc = code_proc
      end

      def extract(_)
        @code_proc.call(exercise_data)
      end

    end

  end
end
