require 'ostruct'

class TestCase
  attr_reader :data
  def initialize(json_data)
    @data = OpenStruct.new(json_data)
  end

  def method_definition
    format 'def %s', test_name
  end

  def method_end
    'end'
  end

  def test_name
    format 'test_%s', @data['description'].downcase.tr_s(' -','_')
  end

  def workload
    body = skip,
      format( "string = '%s'", data.input ),
      format( "%s Isogram.is_isogram?(string)", assertion)
    [indent( body ),nil].join("\n")
  end

  def full_method
    [indent([method_definition],2), workload.split("\n"), indent([method_end],2)].flatten.join("\n") + "\n"
  end

  def indent(array, count=4 )
    array.map { |line| format "%s%s", ' ' * count, line }
  end
end

class IsogramCase < TestCase

  def input
    data.input
  end

  def index
    data.index
  end

  def expected
    data.expected
  end


  def assertion
    expected ? 'assert' : 'refute'
  end

  def skip
    index.zero? ? '# skip' : 'skip'
  end
end

IsogramCases = proc do |data|
  JSON.parse(data)['cases'].map.with_index do |test_case,index| 
    test_case['index'] = index
    IsogramCase.new(test_case)
  end
end
