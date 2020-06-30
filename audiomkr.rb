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

