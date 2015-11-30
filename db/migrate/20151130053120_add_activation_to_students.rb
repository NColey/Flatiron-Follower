class AddActivationToStudents < ActiveRecord::Migration
  def change
    add_column :students, :activation_digest, :string
    add_column :students, :activated, :boolean
    add_column :students, :activated_at, :datetime
  end
end
