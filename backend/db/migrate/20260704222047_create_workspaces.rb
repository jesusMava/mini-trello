class CreateWorkspaces < ActiveRecord::Migration[8.1]
  def change
    create_table :workspaces do |t|
      t.string :name, null: false
      t.references :owner,
                   null: false,
                   foreign_key: { to_table: :users }

      t.timestamps
    end
    add_index :workspaces,
              "owner_id, LOWER(name)",
              unique: true,
              name: "index_workspaces_on_owner_id_and_lower_name"
  end
end
