class ExerciseTestCases
  attr_reader :cases_key

  def initialize(json_data)
    @data = json_data
    @cases_key = 'cases'
  end

  def case_classname
    classname = self.class.to_s.sub(/Cases$/,'Case')
    Object.const_get(classname)
  end

  def parsed_json_cases
    JSON.parse(@data)[cases_key]
  end

  def to_a
    parsed_json_cases.map { |test_case| case_classname.new(test_case) }
  end
end
