#!/usr/bin/ruby

p1 = fork { sleep 0.1 }
p2 = fork { sleep 0.2 }
Process.detach(p1)
puts 'p1'
system("ps -o pid,state -p #{p1}")
puts 'p2'
system("ps -o pid,state -p #{p2}")
Process.waitpid(p2)
puts 'p1'
system("ps -o pid,state -p #{p1}")
puts 'p2'
system("ps -o pid,state -p #{p2}")
sleep 2
puts 'p1'
system("ps -o pid,state -p #{p1}")
