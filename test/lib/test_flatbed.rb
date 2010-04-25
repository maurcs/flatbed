require File.dirname(__FILE__) + '/../test_helper'

class TestFlatbed < Test::Unit::TestCase
  
  def test_clip
    assert Object.const_defined?("Flatbed")
  end
  
end