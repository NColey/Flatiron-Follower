class CreateScrapings < ActiveRecord::Migration
  def change
    create_table :scrapings do |t|

      t.timestamps null: false
    end
  end
end
