class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.integer :ruler_height
      t.integer :ruler_width
      t.string :ip_address
      t.text :comments
      t.references :turkee_task
      t.references :experiment

      t.timestamps
    end
    add_index :surveys, :turkee_task_id
    add_index :surveys, :experiment_id
  end
end
