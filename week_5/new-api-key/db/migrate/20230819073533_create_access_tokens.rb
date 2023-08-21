class CreateAccessTokens < ActiveRecord::Migration[5.0]
  def change
    create_table :access_tokens do |t|
      t.string :name
      t.boolean :is_blocked
      t.datetime :time_when_blocked
      t.datetime :time_when_preserved
    end
  end
end
