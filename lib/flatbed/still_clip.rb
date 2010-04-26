require 'fileutils'

module Flatbed
  class StillClip < Clip
  
    def initialize(clip, convert_from = nil)
      super(clip, convert_from)
      self.input_options = {
        :loop_input => true,
        :vframes => 250
      }
    end

  end
end