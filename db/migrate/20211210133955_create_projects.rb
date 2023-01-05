class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.string :name
      t.string :description
      t.timestamp :start_date
      t.timestamp :end_date, null: true

      t.timestamps
    end
  end
end
