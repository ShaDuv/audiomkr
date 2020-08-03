#!/usr/bin/ruby

require "wavefile"
include WaveFile
puts "What is the topic?"
topic = gets.chomp
puts "How many minutes?"
time = gets.chomp
x = 0
count = Dir["#{topic}//**/*"].length

FILES_TO_APPEND = []
until x >= time.to_i * 60 do
  rand_num = rand(1..count)
  reader = Reader.new("#{topic}/#{rand_num}.wav")
  x = x + reader.total_duration.seconds
  FILES_TO_APPEND.push("#{topic}/#{rand_num}.wav")
end

Writer.new("generated_track.wav", Format.new(:stereo, :pcm_24, 44100)) do |writer|
   FILES_TO_APPEND.each do |file_name|
       Reader.new(file_name).each_buffer do |buffer|
      writer.write(buffer)
    end
  end
end

p count
