$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..'))

require 'test/unit'
require 'fileutils'
require 'flatbed'

class Test::Unit::TestCase

  def file_fixture filename
    File.expand_path(File.join(File.dirname(__FILE__), "fixtures",filename))
  end
  
end