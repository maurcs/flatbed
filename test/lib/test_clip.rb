require File.dirname(__FILE__) + '/../test_helper'

class TestClip < Test::Unit::TestCase
  
  def setup
    @clip_path = file_fixture("3-baby.mpeg")
    @source_path = file_fixture("3-baby.mp4")
    @clip = Flatbed::Clip.new @clip_path, @source_path
  end
  
  def teardown
    FileUtils.rm @clip_path if File.exists? @clip_path
  end
  
  def test_clip
    assert Flatbed::const_defined?("Clip")
  end
  
  def test_should_know_if_a_clip_exists
    assert !@clip.exists?
  end
  
  def test_should_know_if_a_source_exists
    assert !@clip.exists?
  end
  
  def test_should_know_if_a_source_exists
    assert @clip.source_exists?
  end
  
  def test_should_have_clip_name
    assert_match @clip_path.split('/').last, @clip.clip_name
  end
  
  def test_should_have_source_name
    assert_match @source_path.split('/').last, @clip.source_name
  end
  
  def test_should_set_clip
    @clip.set_clip file_fixture("new_source.mpg")
    assert_match file_fixture("new_source.mpg"), @clip.clip
    assert_match "new_source.mpg", @clip.clip_name
  end
  
  def test_should_set_source
    @clip.set_source file_fixture("new_source.mpg")
    assert_match file_fixture("new_source.mpg"), @clip.source
    assert_match "new_source.mpg", @clip.source_name
  end
  
  def test_should_raise_error_on_command_if_no_source
    clip = Flatbed::Clip.new @clip_path
    assert_raise RuntimeError, "No input file specified." do
      clip.command
    end
  end
  
  def test_should_format_an_ffmpeg_command
    assert_match "ffmpeg -i #{@clip.source} #{@clip.clip}", @clip.command
  end
  
  def test_should_run_command_on_create
    assert !@clip.exists?
    @clip.create
    assert @clip.exists?
  end
  
  def test_should_have_options_hashes
    assert_equal({
      :input => {},
      :output=>{}
      }, @clip.options)
  end
  
  def test_should_have_input_options
    opts = {
      :r => "24"
    }
    @clip.input_options = opts
    assert_equal(opts, @clip.input_options)
  end
  
  def test_should_have_output_options
    opts = {
      :r => "24"
    }
    @clip.output_options = opts
    assert_equal(opts, @clip.output_options)
  end
  
  def test_should_merge_input_options
    opts = {
      :r => "24",
      :f => "mpg"
    }
    new_options = {
      :r => "30",
      :vframes => 400
    }
    @clip.input_options = opts
    @clip.input_options new_options
    assert_equal opts.merge(new_options), @clip.input_options
  end
  
  def test_should_merge_output_options
    opts = {
      :r => "24",
      :f => "mpeg"
    }
    new_options = {
      :r => "30",
      :vframes => 400
    }
    @clip.output_options = opts
    @clip.output_options new_options
    assert_equal opts.merge(new_options), @clip.output_options
  end
  
  def test_should_format_options_for_ffmpeg
    @clip.input_options = {
      :loop_input => true,
      :vframes => 150
    }
    @clip.output_options = {
      :r => "30",
      :f => "mpeg",
      :y => false
    }
    assert_match "ffmpeg -loop_input -vframes 150 -i #{@clip.source} -r 30 -f mpeg #{@clip.clip}", @clip.command
  end
  
end





















