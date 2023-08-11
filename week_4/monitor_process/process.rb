puts "Process will died if printed number is 2 "

loop do
    randNum = rand(1..3)
    puts "Number is #{randNum}"
    break if randNum == 2
    sleep 2
end