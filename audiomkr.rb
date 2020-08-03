#!/usr/bin/ruby

require "wavefile"
include WaveFile

puts "What is the topic?"
topic = gets.chomp

puts "How many minutes?"
time = gets.chomp

puts "What do you want to call the final file?"
name = gets.chomp

save_as = "#{name}.wav"
previous = 0
x = 0
count = Dir["#{topic}//**/*"].length
FILES_TO_APPEND = []

until x >= time.to_i  do
  rand_num = rand(1..count)
  if rand_num != previous
    reader = Reader.new("#{topic}/#{rand_num}.wav")
    x = x + reader.total_duration.seconds
    FILES_TO_APPEND.push("#{topic}/#{rand_num}.wav")
    previous = rand_num
  end 
end

Writer.new(save_as, Format.new(:stereo, :pcm_24, 44100)) do |writer|
   FILES_TO_APPEND.each do |file_name|
       Reader.new(file_name).each_buffer do |buffer|
      writer.write(buffer)
    end
  end
end


