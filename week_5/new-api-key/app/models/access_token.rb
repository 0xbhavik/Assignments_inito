require 'securerandom'

class AccessToken < ApplicationRecord
  before_create :set_default_values
  validates :name, presence: true, uniqueness: true

  # instance method
  def unblock_key
    self.is_blocked = false
    self.time_when_blocked = Time.now
    save
  end

  def preserve_key
    self.time_when_preserved = Time.now
    save
  end

  # class method
  def self.delete_record_if_not_preserved
    interval_time_seconds = 30
    where("time_when_preserved + INTERVAL '#{interval_time_seconds} seconds' < ?", Time.now)
      .destroy_all
  end

  def self.release_blocked_key
    interval_time_seconds = 30
    where(is_blocked: true)
      .where("time_when_blocked + INTERVAL '#{interval_time_seconds} seconds' < ?", Time.now)
      .update_all(is_blocked: false, time_when_blocked: nil)
  end

  def self.generate_api_key(length = 5, max_attempts = 10)
    max_attempts.times do
      api_key_name = SecureRandom.hex(length)
      return api_key_name unless AccessToken.exists?(name: api_key_name)
    end

    raise 'cannot find unique key'
  end

  def self.fetch_random_unblocked_key
    AccessToken.where(is_blocked: false).sample
  end

  private

  def set_default_values
    self.is_blocked = false
    self.time_when_preserved = Time.now
    self.time_when_blocked = nil
  end
end
