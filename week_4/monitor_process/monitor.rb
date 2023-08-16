
def monitor_process(process_to_monitor,pid) 
 
loop do

        Process.waitpid(pid, 0)
        puts "Process Died, Restarting"
        pid = spawn(process_to_monitor)

    end
end

# process_to_monitor = "ruby process.rb"
process_to_monitor = ARGV[0]

pid = spawn(process_to_monitor)

monitor_process(process_to_monitor,pid)