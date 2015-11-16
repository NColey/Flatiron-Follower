class AddTwitterColumnsToStudents < ActiveRecord::Migration
  def change
    add_column :students, :provider, :string
    add_column :students, :uid, :string
    add_column :students, :token, :string
    add_column :students, :secret, :string
  end
end
