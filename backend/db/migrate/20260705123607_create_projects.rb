class CreateProjects < ActiveRecord::Migration[8.1]
  def change
    create_table :projects do |t|
      t.string :name, null: false
      t.references :workspace,
                    null: false,
                    foreign_key: true
      t.timestamps
    end
    add_index :projects,
              "workspace_id, LOWER(name)",
              unique: true,
              name: "index_projects_on_workspace_id_and_lower_name"
  end
end
