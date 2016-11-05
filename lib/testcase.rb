class TestCase
  attr_reader :data
  def initialize(json_data)
    @data = OpenStruct.new(json_data)
  end

  def method_definition
    format 'def %s', test_name
  end

  def skip
    data.index.zero? ? '# skip' : 'skip'
  end

  def method_end
    'end'
  end

  def test_name
    format 'test_%s', @data['description'].downcase.tr_s(' -','_')
  end

  def workload
    body = [skip, assertion].flatten
    [indent( body ),nil].join("\n")
  end

  def full_method
    [indent([method_definition],2), workload.split("\n"), indent([method_end],2)].flatten.join("\n") + "\n"
  end

  def indent(array, count=4 )
    array.map { |line| format "%s%s", ' ' * count, line }
  end
end


