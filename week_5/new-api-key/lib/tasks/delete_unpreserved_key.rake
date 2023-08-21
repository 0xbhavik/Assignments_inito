desc 'deleting unpreserved key'

task deleting_unpreserved_keys: :environment do
  puts 'running inside rake task'
  AccessToken.delete_record_if_not_preserved
  AccessToken.release_blocked_key
end
