module Generator
  module CaseValues
    class AutoExtractor
      def initialize(case_class:)
        @case_class = case_class
      end

      def call(exercise_data)
        parsed_data = JSON.parse(exercise_data)['cases']
        extract_test_cases(data: parsed_data).map.with_index do |test, index|
          @case_class.new(test.merge('index' => index))
        end
      end

      private

      def extract_test_cases(data:)
        data.flat_map do |entry|
          entry.key?('cases') ? extract_test_cases(data: entry['cases']) : entry
        end
      end
    end

    class ProcExtractor
      def initialize(code_proc:)
        @code_proc = code_proc
      end

      def call(exercise_data)
        @code_proc.call(exercise_data)
      end
    end
  end
end
