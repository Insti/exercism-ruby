class ExerciseTestCase
  attr_reader :canonical_data

  def initialize(canonical_data)
    @canonical_data = OpenStruct.new(canonical_data)
  end

  def test_name
    "test_#{description_as_test_name}"
  end

  def render
    [*workload].map.with_index do |item, index|
      index.zero? ? item : indent(item, 4)
    end.compact.join("\n")
  end

  def comment; end

  def skip(index = -1)
    index.zero? ? '# skip' : 'skip'
  end

  private

  def description
    canonical_data.description || ''
  end

  def description_as_test_name
    description.downcase.tr_s(' -','_')
  end

  def workload
    "assert #{@canonical_data.expected.inspect}, Subject.method #{@canonical_data.input.inspect}"
  end

  def indent(line, count)
    line = ' ' * count + line
  end
end
