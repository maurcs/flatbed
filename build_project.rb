require File.dirname(__FILE__) + '/flatbed'

ROOT_DIR = File.dirname(__FILE__) + "/.."
IMAGE_DIR = File.expand_path(File.join(ROOT_DIR,"pngs"))
CLIP_DIR = File.expand_path(File.join(ROOT_DIR,"clips"))

FileUtils.mkdir_p(CLIP_DIR)

still_clips = {
  "0-slug-1" => {
    :source => File.join(IMAGE_DIR, "slug.png"),
    :vframes => 1
  },
  "1-title" => {
    :source => File.join(IMAGE_DIR, "TITLE.png"),
    :vframes => 75
  },
  "2-slug-2" => {
    :source => File.join(IMAGE_DIR, "slug.png"),
    :vframes => 15
  },
  "3-baby" => {
    :source => File.join(IMAGE_DIR, "Baby_being_weighed.png"),
    :vframes => 150
  },
  "4-coffin" => {
    :source => File.join(IMAGE_DIR, "Edimbourg_mortsafe.png"),
    :vframes => 100
  },
  "5-slug-3" => {
    :source => File.join(IMAGE_DIR, "slug.png"),
    :vframes => 15
  },
  "6-credits" => {
    :source => File.join(IMAGE_DIR, "CREDITS.png"),
    :vframes => 90
  },
  "7-slug-4" => {
    :source => File.join(IMAGE_DIR, "slug.png"),
    :vframes => 1
  }
}

clips = []

still_clips.sort.each do |h|
  source = h[1].delete(:source)
  clip = Flatbed::StillClip.new(File.join(CLIP_DIR, (h[0] + ".mp4")), source)
  clip.input_options h[1]
  clip.output_options({
    :f => "mp4",
    :b => "15000k",
    :minrate => "5000k",
    :maxrate => "20000k",
    :bufsize => "15000k",
    :s => "hd1080",
    :y => true
  })
  clip.create
  clip.set_source clip.clip
  clip.set_clip clip.clip.gsub('mp4','mpeg')
  clip.input_options = {}
  clip.output_options :f=>'mpeg1video'
  clip.create
  clips << clip
end

final_mpeg = CLIP_DIR + "/final_movie.mpeg"

`cat #{clips.collect(&:clip).join(" ")} > #{final_mpeg}`

final_clip = Flatbed::Clip.new(final_mpeg.gsub("mpeg","mp4"), final_mpeg)
final_clip.output_options({
  :f => "mp4",
  :b => "15000k",
  :minrate => "5000k",
  :maxrate => "20000k",
  :bufsize => "15000k",
  :s => "hd1080",
  :y => true
})

puts final_clip.create