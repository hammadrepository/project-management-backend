class CreateDevelopers < ActiveRecord::Migration[6.1]
  def change
    create_table :developers do |t|
      t.string :first_name
      t.string :last_name

      t.index [:first_name, :last_name], unique: true
      t.timestamps
    end
  end
end
