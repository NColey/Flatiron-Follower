class AddColumnToStudents < ActiveRecord::Migration
  def change
    add_column :students, :encrypted_github, :string
  end
end
