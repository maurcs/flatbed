require File.dirname(__FILE__) + '/../test_helper'

class TestStillClip < Test::Unit::TestCase
  
  def setup
    @clip_path = file_fixture("3-baby.mpeg")
    @source_path = file_fixture("3-baby.mp4")
    @clip = Flatbed::StillClip.new @clip_path, @source_path
  end
  
  def teardown
    FileUtils.rm @clip_path if File.exists? @clip_path
  end
  
  def test_should_extend_clip
    assert_equal Flatbed::Clip, Flatbed::StillClip.superclass
  end
  
  def test_should_have_preconfigured_input_options
    assert_equal({
      :loop_input => true,
      :vframes => 250
    }, @clip.input_options)
  end
  
  def test_should_have_clip
    assert_equal(@clip_path, @clip.clip)
  end
  
  def test_should_have_source
    assert_equal(@source_path, @clip.source)
  end

end





















