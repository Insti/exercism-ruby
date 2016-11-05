class ExerciseTestCase
  attr_reader :canonical_data

  def initialize(canonical_data)
    @canonical_data = OpenStruct.new(canonical_data)
  end

  def render(index = -1)
    @index = index
    full_method
  end

  def full_method
    [comment,indent([method_definition],2), method_body.split("\n"), indent([method_end],2)].flatten.compact.join("\n") + "\n"
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

  def method_end
    'end'
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

  def method_body
    body = [skip, workload].flatten
    [indent(body,4),nil].join("\n")
  end

  def workload
  end

  def indent(array, count)
    array.map { |line| line ? ' ' * count + line : nil }
  end
end
