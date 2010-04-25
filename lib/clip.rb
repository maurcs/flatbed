require 'fileutils'

module Flatbed
  class Clip
  
    attr_accessor :clip, :clip_name, :source, :source_name
  
    def initialize(clip, convert_from = nil)
      set_source convert_from if convert_from
      set_clip clip
    end
  
    def command
      raise "No input file specified." if self.source.to_s.empty?
      "ffmpeg #{format_options input_options}-i #{source} #{format_options output_options}#{clip}"
    end
  
    def create
      `#{command}`
    end
  
    def destroy
      FileUtils.rm clip
    end
    
    def exists?
      File.exists? clip
    end
  
    def options
      @options ||= {
        :input => {},
        :output => {}
      }
    end
  
    def input_options opts = {}
      options[:input] ||= {}
      options[:input].merge!(opts)
    end
  
    def input_options= opts
      options[:input] = opts
    end
  
    def output_options opts = {}
      options[:output] ||= {}
      options[:output].merge!(opts)
    end
  
    def output_options= opts
      options[:output] = opts
    end
  
    def set_clip(path)
      self.clip = File.expand_path(path)
      self.clip_name = clip.split("/").last
    end
  
    def set_source(path)
      self.source = File.expand_path(path)
      self.source_name = source.split("/").last
    end
    
    def source_exists?
      File.exists? source
    end
  
    private
  
    def format_options(opts)
      out = ""
      opts.each do |h|
        unless h[1]===false
          out << "-#{h[0]} "
          out << "#{h[1]} " unless h[1]===true
        end
      end
      out
    end
  
  end
end