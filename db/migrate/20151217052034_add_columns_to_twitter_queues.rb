class AddColumnsToTwitterQueues < ActiveRecord::Migration
  def change
    add_column :twitter_queues, :social_media_method, :string
    add_column :twitter_queues, :provider, :string
    add_column :twitter_queues, :student_id, :integer
    add_column :twitter_queues, :cohort_id, :integer
  end
end
