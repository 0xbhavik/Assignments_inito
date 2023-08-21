class DeleteKeyIfNotPreservedJob < ApplicationJob
  queue_as :default

  def perform(*args)
    AccessToken.delete_record_if_not_preserved
  end
end
