class CreateTwitterQueues < ActiveRecord::Migration
  def change
    create_table :twitter_queues do |t|
        t.integer :twitter_api_limit
        t.timestamps null: false
    end
  end
end
