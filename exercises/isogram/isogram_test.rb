#!/usr/bin/env ruby
# encoding: utf-8
gem 'minitest', '>= 5.0.0'
require 'minitest/autorun'
require_relative 'isogram'

# Test data version: 82eb00d
class IsogramTest < Minitest::Test

  def test_empty_string
    # skip
    string = ''
    assert Isogram.isogram?(string), '"" is an isogram'
  end

  def test_isogram_with_only_lower_case_characters
    skip
    string = 'isogram'
    assert Isogram.isogram?(string), '"isogram" is an isogram'
  end

  def test_word_with_one_duplicated_character
    skip
    string = 'eleven'
    refute Isogram.isogram?(string), '"eleven" is NOT an isogram'
  end

  def test_longest_reported_english_isogram
    skip
    string = 'subdermatoglyphic'
    assert Isogram.isogram?(string), '"subdermatoglyphic" is an isogram'
  end

  def test_word_with_duplicated_character_in_mixed_case
    skip
    string = 'Alphabet'
    refute Isogram.isogram?(string), '"Alphabet" is NOT an isogram'
  end

  def test_hypothetical_isogrammic_word_with_hyphen
    skip
    string = 'thumbscrew-japingly'
    assert Isogram.isogram?(string), '"thumbscrew-japingly" is an isogram'
  end

  def test_isogram_with_duplicated_non_letter_character
    skip
    string = 'Hjelmqvist-Gryb-Zock-Pfund-Wax'
    assert Isogram.isogram?(string), '"Hjelmqvist-Gryb-Zock-Pfund-Wax" is an isogram'
  end

  def test_made_up_name_that_is_an_isogram
    skip
    string = 'Emily Jung Schwartzkopf'
    assert Isogram.isogram?(string), '"Emily Jung Schwartzkopf" is an isogram'
  end

  # Problems in exercism evolve over time, as we find better ways to ask
  # questions.
  # The version number refers to the version of the problem you solved,
  # not your solution.
  #
  # Define a constant named VERSION inside of the top level BookKeeping
  # module, which may be placed near the end of your file.
  #
  # In your file, it will look like this:
  #
  # module BookKeeping
  #   VERSION = 1 # Where the version number matches the one in the test.
  # end
  #
  # If you are curious, read more about constants on RubyDoc:
  # http://ruby-doc.org/docs/ruby-doc-bundle/UsersGuide/rg/constants.html
  def test_bookkeeping
    skip
    assert_equal 2, BookKeeping::VERSION
  end
end

<b>Hello I am a partial</b>
