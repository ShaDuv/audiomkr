#!/usr/bin/ruby

require "wavefile"
include WaveFile

puts "What is the topic?"
topic = gets.chomp

puts "How many minutes?"
time = gets.chomp 

puts "How many do you want to make?"
n = gets.chomp
n = n.to_i

puts "What do you want to call the final file?"
name = gets.chomp
track_count = 1


previous = 0
x = 0
count = Dir["library/#{topic}//**/*"].length
FILES_TO_APPEND = []

n.times {
  save_as = "#{name + '_' + track_count.to_s}.wav"
  puts "starting"
until x >= time.to_i * 60 do
  rand_num = rand(1..count)
  if rand_num != previous
    reader = Reader.new("library/#{topic}/#{rand_num}.wav")
    x = x + reader.total_duration.seconds
    FILES_TO_APPEND.push("library/#{topic}/#{rand_num}.wav")
    previous = rand_num
  end 
end
puts "writing"
Writer.new(save_as, Format.new(:stereo, :pcm_24, 44100)) do |writer|
   FILES_TO_APPEND.each do |file_name|
       Reader.new(file_name).each_buffer do |buffer|
      writer.write(buffer)
    end
  end
end
puts "Finished with file # #{track_count} of #{n}."
track_count += 1
FILES_TO_APPEND = []
}

