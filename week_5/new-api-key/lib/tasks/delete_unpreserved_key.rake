desc "deleting unpreserved key"

task :print_something => :environment do
  puts "running inside rake task"
  # AccessToken.delete_record_if_not_preserved
end
