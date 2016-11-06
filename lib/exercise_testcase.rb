class ExerciseTestCase
  attr_reader :canonical_data

  def initialize(canonical_data)
    @canonical_data = OpenStruct.new(canonical_data)
  end

  def render(index = -1)
    @index = index
    [comment, *full_method].compact.join("\n") + "\n"
  end

  def full_method
    indent( [
      method_definition,
      *method_body,
      method_end
    ], 2)
  end

  def comment
    nil
  end

  def description
    canonical_data.description || ''
  end

  def method_definition
    "def #{test_name}"
  end

  def method_body
    indent( [skip, *workload], 2)
  end

  def method_end
    "end"
  end

  def skip
    @index.zero? ? '# skip' : 'skip'
  end

  def test_name
    "test_#{description_as_test_name}"
  end

  def description_as_test_name
    description.downcase.tr_s(' -','_')
  end

  def workload
    "assert #{@canonical_data.expected.inspect}, Subject.method #{@canonical_data.input.inspect}"
  end

  def indent(lines, count)
    lines.compact.map { |line| ' ' * count + line }
  end
end
