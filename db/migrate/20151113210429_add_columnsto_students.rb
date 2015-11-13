class AddColumnstoStudents < ActiveRecord::Migration
  def change
  	add_column :students, :github_handle, :string
  	add_column :students, :linkedin_url, :string
  	add_column :students, :twitter_handle, :string
  end
end
