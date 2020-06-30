#!/usr/bin/ruby

require "wavefile"
include WaveFile

x = 0
FILES_TO_APPEND = []
until x >= 6 do
  rand_num = rand(1..6)
  reader = Reader.new("#{rand_num}.wav")
  x = x + reader.total_duration.seconds
  FILES_TO_APPEND.push("#{rand_num}.wav")
end

Writer.new("generated_track.wav", Format.new(:stereo, :pcm_24, 44100)) do |writer|
   FILES_TO_APPEND.each do |file_name|
       Reader.new(file_name).each_buffer do |buffer|
      writer.write(buffer)
    end
  end
end
