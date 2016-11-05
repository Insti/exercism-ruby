class TestCases
  attr_reader :cases_key
  def initialize(json_data, cases_key = 'cases')
    @data = json_data
    @cases_key = cases_key
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

class TestCase
  attr_reader :canonical_data

  def initialize(json_data)
    @canonical_data = OpenStruct.new(json_data)
  end

  def comment
    nil
  end

  def method_definition
    format 'def %s', test_name
  end

  def skip
    @index.zero? ? '# skip' : 'skip'
  end

  def method_end
    'end'
  end

  def test_name
    format 'test_%s', canonical_data.description.downcase.tr_s(' -','_')
  end

  def method_body
    body = [skip, workload].flatten
    [indent(body),nil].join("\n")
  end

  def full_method
    [comment,indent([method_definition],2), method_body.split("\n"), indent([method_end],2)].flatten.compact.join("\n") + "\n"
  end

  def render(index = -1)
    @index = index
    full_method
  end

  def indent(array, count = 4)
    array.map { |line| line ? ' ' * count + line : nil }
  end
end
