class CreateTasks < ActiveRecord::Migration[8.1]
  def change
    create_table :tasks do |t|
      t.string :title, null: false
      t.string :description
      t.integer :status,
                null: false,
                default: 0
      t.integer :position,
                null: false,
                default: 1
      t.references :project,
                   null: false,
                   foreign_key: true

      t.timestamps
    end
    add_index :tasks, :project_id
  end
end
